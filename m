Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVD2Ndx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVD2Ndx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVD2Ndx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:33:53 -0400
Received: from fsmlabs.com ([168.103.115.128]:55979 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262583AbVD2Ndp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:33:45 -0400
Date: Fri, 29 Apr 2005 07:36:25 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
In-Reply-To: <20050429061825.36f98cc0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0504290734220.30771@montezuma.fsmlabs.com>
References: <20050421111346.GA21421@elf.ucw.cz> <20050429061825.36f98cc0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005, Andrew Morton wrote:

> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > 
> > Without this patch, Linux provokes emergency disk shutdowns and
> > similar nastiness. It was in SuSE kernels for some time, IIRC.
> > 
> 
> With this patch when running `halt -p' my ia64 Tiger (using
> tiger_defconfig) gets a stream of badnesses in iosapic_unregister_intr()
> and then hangs up.
> 
> Unfortunately it all seems to happen after the serial port has been
> disabled because nothing comes out.  I set the console to a squitty font
> and took a piccy.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02505.jpg
> 
> I guess it's an ia64 problem.  I'll leave the patch in -mm for now.

Could you cat /proc/interrupts during runtime? It looks like the device 
being suspended never went through pci_device_enable() (e.g. ethernet 
interface wasn't up). It's harmless right now.

Thanks,
	Zwane

