Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264344AbUFCR3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbUFCR3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUFCR3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:29:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:18925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264299AbUFCR0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:26:38 -0400
Date: Thu, 3 Jun 2004 10:26:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: "Jeff V. Merkey" <jmerkey@drdos.com>, linux-kernel@vger.kernel.org
Subject: Re: submit_bh leaves interrupts on upon return
In-Reply-To: <20040603170328.GQ1946@suse.de>
Message-ID: <Pine.LNX.4.58.0406031025070.3403@ppc970.osdl.org>
References: <40BE93DC.6040501@drdos.com> <20040603085002.GG28915@suse.de>
 <40BF8E1F.1060009@drdos.com> <20040603165250.GO1946@suse.de>
 <40BF9124.6080807@drdos.com> <20040603170328.GQ1946@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jun 2004, Jens Axboe wrote:

> On Thu, Jun 03 2004, Jeff V. Merkey wrote:
> >
> > Sounds like I need to move to 2.6. I noticed the elevator is coalescing 
> > quite well, and since I am posting mostly continguous runs of sectors, 
> > what ends up at the adapter level would probably not change much much 
> > between 2.4 and 2.6 since I am maxing out the driver request queues as 
> > it is (255 pending requests of 32 scatter/gather elements of 256 sector 
> > runs). 2.6 might help but I suspect it will only help alleviate the 
> > submission overhead, and not make much difference on performance since 
> > the 3Ware card does have an upward limit on outstanding I/O requests.
> 
> That's correct, it just helps you diminish the submission overhead by
> pushing down 256 sector entities in one go. So as long as you're io
> bound it won't give you better io performance, of course. If you are
> doing 400MiB/sec it should help you out, though.

Well, if Jeff does almost exclusively contiguous stuff and submits them in
order, then the coalescing will make sure that even on 2.4.x the queues
don't get too long, and he probably won't see the pathological cases.

		Linus
