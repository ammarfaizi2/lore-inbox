Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUJVSPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUJVSPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUJVSJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:09:04 -0400
Received: from fmr06.intel.com ([134.134.136.7]:56714 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267354AbUJVSFQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:05:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 11:04:36 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6003287DC8@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Thread-Index: AcS4W0Ek6c7O5rMkR72J/ckbwTzgTwABKL+w
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       <stefandoesinger@gmx.at>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Oct 2004 18:04:37.0781 (UTC) FILETIME=[982F9450:01C4B861]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Jon Smirl [mailto:jonsmirl@gmail.com] 
>Sent: Friday, October 22, 2004 10:19 AM
>To: Pallipadi, Venkatesh
>Cc: Matthew Garrett; stefandoesinger@gmx.at; 
>linux-kernel@vger.kernel.org
>Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer 
>driver and Video card BOOT?
>
>On Fri, 22 Oct 2004 09:36:40 -0700, Pallipadi, Venkatesh
><venkatesh.pallipadi@intel.com> wrote:
>> Actually I sent the kernel patch to call some userlevel 
>vgapost utility
>> on this same thread around a week back. I am sending it here again.
>
>It is more complex to restart the VGA system when there are multiple
>cards. You have to disable all of the other VGA devices before
>reseting one otherwise you will end up with two enabled VGA devices
>and address ownership conflicts. You also have to move the PCI bus
>routing around so that it points to the correct card.
>
>There is a pending patch in mm, bk-pci, that exposes video ROMs via
>sysfs. That makes writing the reset program cleaner. You should not
>play with the ROM or the PIC bus routine from user space, that needs
>to be done in the kernel.
>

Yes. I looked at that patch which exposes video ROM through sysfs. 
But, we will also need either a kernel or user level x86 emulator, 
to use this ROM for things like vgapost. Right? 
I was using the video ROM exposed through sysfs for my userlevel 
emulation, until I found out the vgapost calls also uses some other 
things outside video ROM as it makes other INT calls internally.
That's when I moved out to use the X approach of mapping /dev/mem.

I agree with you on all the things about multiple VGA card and 
their initializations. But, I am more concerned about the more 
common single video card systems, which doesn't get video back after 
S3 suspend and resume, just because the kernel doesn't do vgapost 
at proper time. With thousands of such systems being used already, 
I feel we need to have some working solution for that sooner.

Thanks,
Venki


