Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUHKXwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUHKXwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268412AbUHKXo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:44:26 -0400
Received: from fmr05.intel.com ([134.134.136.6]:33928 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268349AbUHKX2F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:28:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] add PCI ROMs to sysfs
Date: Wed, 11 Aug 2004 16:27:29 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600296D33C@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] add PCI ROMs to sysfs
Thread-Index: AcR/6vj0jjYayN92RJuhV/IZpZopWgAD0EiA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jon Smirl" <jonsmirl@yahoo.com>, "Greg KH" <greg@kroah.com>,
       "Jesse Barnes" <jbarnes@engr.sgi.com>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "Martin Mares" <mj@ucw.cz>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Petr Vandrovec" <VANDROVE@vc.cvut.cz>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
X-OriginalArrivalTime: 11 Aug 2004 23:27:30.0783 (UTC) FILETIME=[C5A716F0:01C47FFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One issue with x86 quirk in this patch.
The actual sysfs entries are created during the PCI bus scan.
But, pci_fixup_video() gets called later during device_initcalls.
So, PCI_ROM_SHADOW is kind of ineffective now. 

Thanks,
Venki

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jon Smirl
>Sent: Wednesday, August 11, 2004 12:24 PM
>To: Greg KH; Jesse Barnes; Benjamin Herrenschmidt
>Cc: Martin Mares; linux-pci@atrey.karlin.mff.cuni.cz; Alan 
>Cox; Linux Kernel Mailing List; Petr Vandrovec; Benjamin Herrenschmidt
>Subject: Re: [PATCH] add PCI ROMs to sysfs
>
>I can put together a new patch later tonight that reverts to the old
>size scheme. It was more complicated since you need to allocate each
>attribute.
>
>I'll attach a newer version that incorporates a little feedback about
>creating a function to remove the attribute for devices that don't want
>to expose the ROM.
>
>Alan Cox had concerns about copying the ROMs for those devices that
>don't implement full address decoding. I'm using kmalloc for 40-60KB.
>Would vmalloc be a better choice? Very few drivers will use the copy
>option, mostly old hardware.
>
>BenH said he would check it out on ppc but I haven't heard from him
>yet.
>
>Jesse, did you notice that the quirk for tracking the boot video device
>is x86 only? I believe this needs to run on ia64 and x86_64 too. How do
>we want to do that? It will do the wrong thing on architectures that
>don't shadow video ROMs to C0000.
>
>
