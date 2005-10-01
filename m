Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVJASjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVJASjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 14:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVJASjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 14:39:10 -0400
Received: from xenotime.net ([66.160.160.81]:16864 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750772AbVJASjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 14:39:08 -0400
Date: Sat, 1 Oct 2005 11:39:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Mark Lord <lkml@rtr.ca>
Cc: jgarzik@pobox.com, joshk@triplehelix.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de,
       torvalds@osdl.org
Subject: Re: SATA suspend/resume (was Re: [PATCH] updated version of Jens'
 SATA suspend-to-ram patch)
Message-Id: <20051001113906.2105f152.rdunlap@xenotime.net>
In-Reply-To: <433ED44C.3060805@rtr.ca>
References: <20050923163334.GA13567@triplehelix.org>
	<433B79D8.9080305@pobox.com>
	<433ED44C.3060805@rtr.ca>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Oct 2005 14:24:12 -0400 Mark Lord wrote:

> Jeff Garzik wrote:
> ..
> > Ah hah!  I found the other SCSI suspend patch:
> >     http://lwn.net/Articles/97453/
> > Anybody (Joshua?) up for reconciling and testing the two?
> 
> I just now tried out *only* "the other SCSI suspend patch",
> and by itself it hangs on resume.  Laptop computer, blank screen,
> no serial ports, no printk()s visible.
> 
> And there's one minor bug in that patch:  it uses GFP_KERNEL to
> alloc a buffer, but on resume it really should use GFP_ATOMIC instead,
> since the swap device is the same drive we're trying to resume..
> 
> > 2) sd should call START STOP UNIT on resume
> 
> That's probably why it hangs when used as-is by itself.
> I may do some further testing.
> 
> Anyone else out there playing with this yet?

Not playing with it yet, just making some changes as suggested
by Jeff and Christoph.  Patches are in
  http://www.xenotime.net/linux/scsi/

1.  http://www.xenotime.net/linux/scsi/scsi-suspend-resume.patch
2.  http://www.xenotime.net/linux/scsi/scsi-susres-startstop2.patch

and work-in-progress:  adding <spindown> ok/allowed to scsi
targets:  http://www.xenotime.net/linux/scsi/scsi-susres-stst-spin.patch
(this patch file includes 1. and 2. above)

---
~Randy
