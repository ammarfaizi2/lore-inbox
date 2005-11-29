Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVK2UbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVK2UbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVK2UbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:31:16 -0500
Received: from solarneutrino.net ([66.199.224.43]:59652 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932382AbVK2UbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:31:15 -0500
Date: Tue, 29 Nov 2005 15:31:12 -0500
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051129203112.GD6326@tau.solarneutrino.net>
References: <20051129092432.0f5742f0.akpm@osdl.org> <Pine.LNX.4.63.0511292147120.5739@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511292147120.5739@kai.makisara.local>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 10:04:39PM +0200, Kai Makisara wrote:
> I looked at the driver and it seems that there is a bug: st_write calls 
> release_buffering at the end even when it has started an asynchronous 
> write. This means that it releases the mapping while it is being used!
> (I wonder why this has not been noticed earlier.)
> 
> The patch below (against 2.6.15-rc2) should fix this bug and some others 
> related to buffering. It is based on the patch "[PATCH] SCSI tape direct 
> i/o fixes" I sent to linux-scsi on Nov 21. The patch restores setting 
> pages dirty after reading and clears number of s/g segments when the 
> pointers are not valid any more.
> 
> The patch has been lightly tested with AMD64.

This applies cleanly to 2.6.14.2, do you forsee any problems using it
with that kernel?  I'd like to not change too many things at once.

If it should be OK, I'll boot this tonight or tomorrow - the backups run
every other night, so it won't get any testing until tomorrow night.

Thanks a lot,
-ryan
