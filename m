Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTKTPRC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 10:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTKTPRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 10:17:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:36256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261903AbTKTPQ7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 10:16:59 -0500
Date: Thu, 20 Nov 2003 07:22:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Frank Dekervel <kervel@drie.kotnet.org>
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Message-Id: <20031120072236.68327dca.akpm@osdl.org>
In-Reply-To: <200311201137.55553.kervel@drie.kotnet.org>
References: <200311191749.28327.kervel@drie.kotnet.org>
	<20031119165928.70a1d077.akpm@osdl.org>
	<200311201134.04050.kervel@drie.kotnet.org>
	<200311201137.55553.kervel@drie.kotnet.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Dekervel <kervel@drie.kotnet.org> wrote:
>
> Op Thursday 20 November 2003 11:34, schreef Frank Dekervel:
> > pnpbios says something like this:
> >  found installation structure 0xc00f5560
> >  version 1.0 entry 0xf0000:0x6149 dseg 0xf0000
> >
> > i'm going to try without pnpbios i think.
> >
> > my working 2.6.0test9 also has pnpbios setup:
> > kervel@bakvis:~$ cat /boot/config-2.6.0-test9 | grep -i pnpbios
> > CONFIG_PNPBIOS=y
> 
> ok, replying to myself to be more specific:
> 
> working pnpbios gives this:
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f5560
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x614a, dseg 0xf0000
> PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
> SCSI subsystem initialized
> 
> mm4 pnpbios gives the same numbers, but never says 
> PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
> instead it says general protection fault
> 

There are three pnpbios patches in -mm:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-1.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-2.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-3.patch

It would help if you could determine which (if any) of these are causing
the problem.  You can remove the patches with

	cd /usr/src/linux
	patch -p1 -R < ~/pnp-fix-3.patch

etcetera.


Thanks.
