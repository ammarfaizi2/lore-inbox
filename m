Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbULAPNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbULAPNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbULAPNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:13:42 -0500
Received: from fmr13.intel.com ([192.55.52.67]:36543 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261270AbULAPNj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:13:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: setting up EFI on x86
Date: Wed, 1 Dec 2004 07:13:26 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00870F00E@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: setting up EFI on x86
Thread-Index: AcTXsmiERPUOmkm2SfmedeJIZGXgjwAAL7Fg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Daniel Dickman" <didickman@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>, "Matt Domsch" <Matt_Domsch@dell.com>
X-OriginalArrivalTime: 01 Dec 2004 15:13:29.0286 (UTC) FILETIME=[50359660:01C4D7B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I just got an older x86 desktop system and I wanted to learn about EFI
>by booting the kernel using this instead of the older MBR-style boot
>process. Does anyone know how I can set up such a system on x86?
>Specifically, what tools can I use to create a GPT disk? Do I need a
>special BIOS to do this?

None of the mainline distributions currently support installation from
EFI on x86.  I've heard rumors that Debian includes some support for
EFI, but I don't know specifics.  Thus, there are several contortions 
required to set it up.  

Typically, I would start with an installation of your favorite distro.  
The difference is that I also include a vfat partition as this serves as
your EFI system partition.  Onto this, I copy the EFI bootloader and
kernels so that they are visible from EFI.   As for the GPT partioning, 
Matt Domsch added GPT support into parted, so that should work for 
creating a GPT disk.  

EFI is the top-most interface to the firmware, whether that's a
traditional BIOS, or the Framework that Intel has been promoting.   
Given that your older system doesn't have EFI in the flash, you'll
need to download the EFI sample implementation from 
http://developer.intel.com/technology/efi/main_sample.htm.  The EFI
website include pre-built binaries of the sample implementation 
source that is also available.  You can dd this onto a
floppy.  This permits one to bootstrap EFI from a floppy on top 
of your existing BIOS.  You'll see it come up to the boot manager 
and eventually the EFI shell.  

>From there, you'll need to use the ELILO bootloader, which is
downloadable either in source or binary form from here:
http://elilo.sourceforge.net/cgi-bin/blosxom.  Also in there
are various READMEs and guides for use.

Finally, make sure you build the kernel with CONFIG_EFI enabled.  

I've been meaning to post more detailed instructions on a website
for this.  I'll try to get something posted soon.  Let me
know if you have further questions Daniel.

matt



