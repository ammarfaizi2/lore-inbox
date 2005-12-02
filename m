Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVLBTMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVLBTMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVLBTMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:12:35 -0500
Received: from silver.veritas.com ([143.127.12.111]:48224 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750781AbVLBTMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:12:34 -0500
Date: Fri, 2 Dec 2005 19:12:19 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20051202180326.GB7634@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com>
References: <20051129092432.0f5742f0.akpm@osdl.org>
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
 <20051202180326.GB7634@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Dec 2005 19:12:20.0979 (UTC) FILETIME=[51C0E430:01C5F774]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Ryan Richter wrote:
> On Thu, Dec 01, 2005 at 08:21:57PM +0000, Hugh Dickins wrote:
> > If the problem were easily reproducible, it'd be great if you could
> > try this patch; but I think you've said it's not :-(
> 
> I can throw this in and test it for sure.  I'll run the backups every
> day for a while to speed up the testing also.

Thanks - though everyone seems to have agreed that the patch is needed
whatever: so although it would be interesting to know if it has fixed
your problem, we're not waiting on you to go forward with it (James
already invited Linus to pull).

> Could someone please tell me exactly which patches I should include in
> the kernel I will boot tomorrow?

You hit the problem with 2.6.14.2.  My own opinion would be to apply
just that patch to that release, or to 2.6.14.3 if you prefer.

Linus was suggesting 2.6.15-rc4 because there's some debug there which
might have helped identify the offending driver: but your backtrace
had already showed us the offending driver.  Well, not proven: if a
page is doubly freed, the one that suffers is not necessarily the one
that's guilty; but it's a reasonable expectation.  I don't think his
debug would tell us anything more.

> I haven't played with -rc for ages, so
> I'm no longer sure which kernel I should start with (2.6.14 or
> 2.6.14.3?).

If you do want 2.6.15-rc4, then it's 2.6.14 + patch-2.6.15-rc4.

> Are the MPT-fusion performance fix patches in -rc4, or if
> not will they still apply?

I don't know it myself.  Is that the one about the module performing
much better than the builtin?  I'd expect that to be in.  If you have
it, suggest you look at your 2.6.15-rc4 source to see if it's there.

Hugh
