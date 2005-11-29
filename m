Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVK2UsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVK2UsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVK2UsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:48:04 -0500
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:27533 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932395AbVK2UsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:48:03 -0500
Date: Tue, 29 Nov 2005 22:48:22 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20051129203112.GD6326@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.63.0511292239070.5739@kai.makisara.local>
References: <20051129092432.0f5742f0.akpm@osdl.org>
 <Pine.LNX.4.63.0511292147120.5739@kai.makisara.local>
 <20051129203112.GD6326@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2005, Ryan Richter wrote:

> On Tue, Nov 29, 2005 at 10:04:39PM +0200, Kai Makisara wrote:
> > I looked at the driver and it seems that there is a bug: st_write calls 
> > release_buffering at the end even when it has started an asynchronous 
> > write. This means that it releases the mapping while it is being used!
> > (I wonder why this has not been noticed earlier.)
> > 
> > The patch below (against 2.6.15-rc2) should fix this bug and some others 
> > related to buffering. It is based on the patch "[PATCH] SCSI tape direct 
> > i/o fixes" I sent to linux-scsi on Nov 21. The patch restores setting 
> > pages dirty after reading and clears number of s/g segments when the 
> > pointers are not valid any more.
> > 
> > The patch has been lightly tested with AMD64.
> 
> This applies cleanly to 2.6.14.2, do you forsee any problems using it
> with that kernel?  I'd like to not change too many things at once.
> 
No, I don't see any potential problems applying this patch to 2.6.14.2. 
There is nothing specific to 2.6.15-rc2.

If someone sees that there is something wrong, please yell. The 
main purpose of the patch is not to call release_buffering() at the end of 
st_write() when starting asynchronous write and call it in 
write_behind_check() instead.

> If it should be OK, I'll boot this tonight or tomorrow - the backups run
> every other night, so it won't get any testing until tomorrow night.
> 
> Thanks a lot,
> -ryan
> 
Thanks for reporting the problem and thanks in advance for testing.

-- 
Kai
