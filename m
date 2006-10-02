Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWJBOPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWJBOPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 10:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWJBOPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 10:15:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:10248 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932445AbWJBOPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 10:15:18 -0400
Date: Mon, 2 Oct 2006 10:15:13 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] usb hubc build fix.patch prefix
In-Reply-To: <20061002023720.9780.85391.sendpatchset@v0>
Message-ID: <Pine.LNX.4.44L0.0610021003330.6651-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006, Paul Jackson wrote:

> From: Paul Jackson <pj@sgi.com>
> 
> The patch series 2.6.18-mm2-broken-out does not apply to 2.6.18,
> for me anyway.
> 
> The 'quilt push' of this series fails with:
> 
>     Applying patch usb-hubc-build-fix.patch
>     patching file drivers/usb/core/hub.c
>     Hunk #1 FAILED at 1831.
>     Hunk #2 succeeded at 1904 (offset -2 lines).
>     Hunk #3 FAILED at 1946.
>     2 out of 3 hunks FAILED -- rejects in file drivers/usb/core/hub.c
>     Patch usb-hubc-build-fix.patch does not apply (enforce with -f)

There is no patch labelled usb-hubc-build-fix.patch anywhere in 
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/broken-out/
This suggests that the quilt archive is indeed messed up.

> If I apply the following patch *just before* the failing
> usb-hubc-build-fix.patch, everything applies cleanly from there on
> down the patch set.
> 
> I don't know what's right here.  I'm just blindly pushing code.
> 
> But it seems obvious to me that the 2.6.18-mm2 broken-out patch set
> is borked:
> 
>   The first patch in the series: origin.patch, definitely places these
>   two hub_* defines just before the usb_resume_root_hub() routine.

That is in fact where they belong.  Furthermore, that's where the 
origin.patch file from the URL above puts them.  It sounds like the 
contents of the archive don't match the contents of the directory.

>   But then the patch usb-hubc-build-fix.patch clearly expects to find
>   those two hub_* defines just before the hub_suspend() routine.

That is wrong.  The module won't compile properly when CONFIG_PM is set 
and CONFIG_USB_SUSPEND isn't if the defines are placed there.

Alan Stern

