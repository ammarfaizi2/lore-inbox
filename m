Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTFLWdp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTFLWdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:33:45 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:58109 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263270AbTFLWdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:33:45 -0400
Date: Thu, 12 Jun 2003 15:43:33 -0700
From: Andrew Morton <akpm@digeo.com>
To: Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: 2.5.70: Lilo needs patching?
Message-Id: <20030612154333.608bca2c.akpm@digeo.com>
In-Reply-To: <200306122329.47365.Unai.Garro@ee.ed.ac.uk>
References: <200306122329.47365.Unai.Garro@ee.ed.ac.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 22:47:30.0498 (UTC) FILETIME=[9AFF2A20:01C33134]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk> wrote:
>
> Since version 2.5.69 (now with 2.5.70-mm6), I'm having trouble using lilo. 
> Every time I try to change the lilo boot, the boot menu is either not 
> changed, or it's corrupted. It looks like if Lilo doesn't manage to 
> completely write the boot sector.
> 
> I've been looking around, but I haven't found any information about this. Has 
> anything changed in the latest versions? Are there any patches that I need to 
> apply to lilo to make it work now? 
> 

It's a bug.  Seems that the ramdisk driver has somehow managed to
compromise the livelock avoidance logic in the sync() system call.

For now you can

a) stop using the ramdisk driver (don't mount it) or

b) manually run `blockdev --flushbufs /dev/hdXX' against the boot
   partition before rebooting.

