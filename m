Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUINXlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUINXlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUINXlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:41:32 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:57730 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265800AbUINXl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:41:28 -0400
Message-ID: <9e47339104091416416b9ae310@mail.gmail.com>
Date: Tue, 14 Sep 2004 19:41:28 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH] DRM: add missing pci_enable_device()
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, dri-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Evan Paul Fletcher <evanpaul@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409150008130.23838@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409131651.05059.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0409140026430.15167@skynet>
	 <200409140845.59389.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0409150008130.23838@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that the kernel bk tree is lagging behind the DRM CVS
source. Allow more DRM updates into the kernel and these things will
be fixed. If you want more up to date drivers get them directly from
DRM CVS.

pci_enable/disable_device are correct in the dyn-minor patch. They
also appear to correct in the currently checked in DRM cvs. If fbdev
is loaded DRM does not do pci_enable/disable_device. It is assumed
that these calls are handled by the fbdev device.

You must follow the order rules if using them together.
modprobe fbdev
modprobe DRM
rmmod DRM
rmmod fbdev

You cannot remove these modules out of order or things will break.


On Wed, 15 Sep 2004 00:12:01 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> >
> > OK, I'll assume you understand the issue and will resolve it.  In the
> > meantime, users of DRM will have to supply "pci=routeirq".
> >
> 
> is this -mm only or is it mainline kernel stuff now?
> 
> I'll throw an enable in to the bk tree later on....
> 
> Dave.
> 
> --
> David Airlie, Software Engineer
> http://www.skynet.ie/~airlied / airlied at skynet.ie
> pam_smb / Linux DECstation / Linux VAX / ILUG person
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
> Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
> Camcorder. More prizes in the weekly Lunch Hour Challenge.
> Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
> 
> 
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 



-- 
Jon Smirl
jonsmirl@gmail.com
