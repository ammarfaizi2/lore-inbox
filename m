Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUF3Esx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUF3Esx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 00:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUF3Esw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 00:48:52 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:56192 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266472AbUF3EsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 00:48:11 -0400
Date: Wed, 30 Jun 2004 00:50:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Greg KH <greg@kroah.com>
Cc: Harald Welte <laforge@gnumonks.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix different usb-serial oopses for 2.6.7
In-Reply-To: <20040629213756.GA21065@kroah.com>
Message-ID: <Pine.LNX.4.58.0406292106100.27856@montezuma.fsmlabs.com>
References: <20040607215451.GA7531@kroah.com> <10866458194180@kroah.com>
 <20040616091710.GS12494@sunbeam.de.gnumonks.org> <20040616170409.GK12494@sunbeam.de.gnumonks.org>
 <20040616175800.GB13937@kroah.com> <20040616192503.GL12494@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.58.0406230222090.3273@montezuma.fsmlabs.com> <20040623161044.GA25681@kroah.com>
 <Pine.LNX.4.58.0406231216270.3273@montezuma.fsmlabs.com> <20040629213756.GA21065@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004, Greg KH wrote:

> Ok, thanks to both of you posting bug reports that seemed quite
> different, I think I've finally fixed both of your issues.  The patch
> below is what I've just added to my trees and will send to Linus in a
> bit, and should solve both problems.
>
> Basically the issue was 2 things:
> 	- Zwane correctly found that we shouldn't have been calling the
> 	  usb_driver_release_interface() call on disconnect, but if you
> 	  didn't make this call, we leaked memory.  This was because of
> 	  the next piece...
> 	- Harald noticed that if you unloaded a usb-serial driver with
> 	  the device still plugged in, and then removed it, the kernel
> 	  oopsed.  He also noticed double calls to the disconnect
> 	  function.  This was because we were incorrectly binding the
> 	  device to the usb serial generic driver instead of the one
> 	  that was controlling it.
>
> So, by fixing the usb-serial generic issue, that fixed the fact that we
> shouldn't have been calling the release_interface() call, as it isn't
> necessary (the usb core will take care of it.)
>
> Thanks to everyone for helping out here, and if with this patch, you
> still have problems, please let me know...

Great, thanks Greg, this one works for me.

