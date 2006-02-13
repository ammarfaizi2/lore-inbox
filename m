Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWBMRsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWBMRsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBMRsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:48:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46262 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932369AbWBMRsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:48:22 -0500
Date: Mon, 13 Feb 2006 12:46:58 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
Subject: Re: 2.6.16-rc3: more regressions
Message-ID: <20060213174658.GC23048@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:35:30AM -0800, Linus Torvalds wrote:

 > > Subject    : Xorg freezes 2.6.16-rc1
 > > References : http://lkml.org/lkml/2006/1/26/97
 > > Submitter  : Mauro Tassinari <mtassinari@cmanet.it>
 > > Status     : unknown
 > 
 > For this one, it would be interesting to see more info about the working 
 > setup. Notably
 > 
 >  - what modules are loaded by the time X is running
 >  - any differences in 'dmesg' output from 2.6.15 to 16-rc1 (PCI allocation 
 >    issues should show up there)
 > 
 > Of course, in a perfect world, we'd have serial or network console 
 > output.. X crashes are nastier than most, if only because the console is 
 > mostly gone.
 
I think this is the Radeon DRM bug I hit.  (rc1 had a big drm update iirc)

Unless I patch with this..

--- linux-2.6.15.noarch/drivers/char/drm/drm_pciids.h~  2006-02-09 19:26:06.000000000 -0500
+++ linux-2.6.15.noarch/drivers/char/drm/drm_pciids.h   2006-02-09 19:26:56.000000000 -0500
@@ -85,7 +85,6 @@
        {0x1002, 0x5969, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
        {0x1002, 0x596A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
        {0x1002, 0x596B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
-       {0x1002, 0x5b60, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350}, \
        {0x1002, 0x5c61, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280|CHIP_IS_MOBILITY}, \
        {0x1002, 0x5c62, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
        {0x1002, 0x5c63, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280|CHIP_IS_MOBILITY}, \

I get a machine check exception, triple fault, or NMI watchdog lockup.

		Dave

