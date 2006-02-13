Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWBMTfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWBMTfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWBMTfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:35:13 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:13361 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932435AbWBMTfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:35:11 -0500
Message-ID: <43F0DF32.8060709@cfl.rr.com>
Date: Mon, 13 Feb 2006 14:34:10 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Seewer Philippe <philippe.seewer@bfh.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch>
In-Reply-To: <43F0D7AD.8050909@bfh.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 19:36:02.0892 (UTC) FILETIME=[B96F58C0:01C630D4]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--19.900000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seewer Philippe wrote:
> ...Thats why I said i didn't want to start another geometry war. But
> then again, I did write RFC too, yes?
>
> Yes, geometry is a fiction. And a bad one at that. To be honest I'd
> rather get rid of it completely. But you said it: The geometry still
> exists for the sake of backward compatibility. If it is still there, why
> not export it? That's what sysfs is for...
>   

Because AFAIK, the kernel does not know the geometry.  To find out you 
have to ask the bios, and calling the bios is a no-no.  That's assuming 
the disk is even visible to the bios. 
> Additionally have a look at libata-scsi.c which is part of the SATA
> implementation. Theres CHS code in there...
>
> Personally I want the geometry information in sysfs because debugging
> partition tables not written by linux tools becomes just that tad more
> easier...
>
>   
The geometry expressed in the partition table by whatever utility 
created it will be the geometry that the bios reported the disk had at 
the time the tool created the MBR, which can change if you plug the disk 
into another machine with different bios.  If there is already geometry 
in the MBR, then you should use those values and take them at face value.

> I did not say I'd implement it for _all_ devices. In fact I indent to
> make geometry available only for devices whose drivers provide the
> getgeo function.
>
>   
AFAIK, most drivers do provide a getgeo function... but do they get the 
information from the bios at boot time, or do they make it up?  If it is 
just made up anyhow, then why bother?  I am not sure how it could even 
be possible to get the information from the bios at boot time, and 
figure out the correct mapping between bios devices and the real 
hardware, which the driver is talking to.  Since the geometry is 
entirely made up anyhow why bother asking the driver to make it up when 
that can be done in user space just as easily?
> Exactly. I don't want the kernel to fix BIOS problems. But i want to
> give userland the opportunity to overwrite what the kernel thinks (as in
> /proc/ide/hdx/settings).
> One example where this might be usable is connecting a PATA drive using
> an Adapter to SATA. PATA returns the drive's geometry. SATA defaults to
> x/255/63...
But neither one is any more correct than the other.  Both are bogus 
values, so what does it matter which is used?  What good would having 
this value stored in the kernel do?  The kernel itself does not use it.  
User mode tools that for some reason need to talk about it can just use 
the values stored in the MBR. 



