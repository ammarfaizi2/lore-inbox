Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271643AbTGRARL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271647AbTGRARL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:17:11 -0400
Received: from 69-55-72-145.ppp.netsville.net ([69.55.72.145]:12258 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S271643AbTGRARI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:17:08 -0400
Subject: Re: 2.4.22pre6aa1
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030717225002.GY1855@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random>
	 <200307180013.38078.m.c.p@wolk-project.de>
	 <200307180024.17523.m.c.p@wolk-project.de>
	 <20030717225002.GY1855@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1058488216.4016.338.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Jul 2003 20:30:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 18:50, Andrea Arcangeli wrote:
> On Fri, Jul 18, 2003 at 12:30:45AM +0200, Marc-Christian Petersen wrote:
> > 2.4.22-pre[6|6aa1]:
> > -------------------
> > root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> > 131072+0 records in
> > 131072+0 records out
> > 2147483648 bytes transferred in 128.765686 seconds (16677453 bytes/sec)
> > 
> > 2.4.22-pre2:
> > ------------
> > root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> > 131072+0 records in
> > 131072+0 records out
> > 2147483648 bytes transferred in 98.489331 seconds (21804226 bytes/sec)
> > 
> > both kernels freshly rebooted.
> 
> this explains it.
> 
> Can you try to change include/linux/blkdev.h like this:
> 
> -#define MAX_QUEUE_SECTORS (4 << (20 - 9)) /* 4 mbytes when full sized */
> +#define MAX_QUEUE_SECTORS (16 << (20 - 9)) /* 4 mbytes when full sized */
> 
> This will raise the queue from 4 to 16M. That is the first(/only) thing
> that can explain a drop in performnace while doing contigous I/O.
> However I didn't expect it to make a difference, or at least not so
> relevant.
> 
> If this doesn't help at all, it might not be an elevator/blkdev thing.
> At least on my machines the contigous I/O still at the same speed.
> 
Especially with just one writer, you really shouldn't be able to see a
difference in pre6.  Did you measure this change on both pre6 and
pre6aa1.  Your message indicated that but I wanted to double check to
make sure.

-chris


