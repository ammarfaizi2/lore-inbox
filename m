Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWBKEjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWBKEjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 23:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBKEjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 23:39:32 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:890 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932234AbWBKEjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 23:39:31 -0500
Date: Fri, 10 Feb 2006 22:41:08 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Support HDIO_GETGEO on device-mapper volumes
In-reply-to: <5EN4d-3ZP-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43ED6AE4.6050302@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Evqz-3kK-9@gated-at.bofh.it> <5EHUJ-4sa-1@gated-at.bofh.it>
 <5EIeb-55n-33@gated-at.bofh.it> <5EN4d-3ZP-21@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> Phillip Susi wrote:
>> Yes, I think this could also be fixed on grub's end.  It seems that
>> fdisk assumes usable default values for the geometry but grub has
>> different defaults that cause it problems.  I think that the defaults
>> could be modified in grub so that it will work when HDIO_GETGEO fails.
> 
> It would be better to make the decision once and for all, in one place.
> 
> It would be even better for the HDIO_GETGEO call to return the same
> geometry that the BIOS uses, so that Grub is handed numbers that
> actually mean *something*.

The numbers don't really mean anything in any case, it's a matter of 
choosing one fiction over another. I don't know that there would be any 
easy way for the kernel to know which BIOS drive corresponds to the 
device, and the device may be one that's not recognized by the BIOS at 
all and therefore has no BIOS device (ex: Linux software RAID).

There were problems with this that surfaced sometime after the release 
of the 2.6 kernel, where installing Fedora Core 2 on a dual-boot system 
with Windows would render Windows unbootable. As I recall, it seems that 
even though it doesn't really use CHS, the Windows boot loader somehow 
cares that the CHS geometry in the partition table and/or MBR matches 
the BIOS reported geometry and chokes if it doesn't. As I see it, the 
solution to that would be to not touch the existing geometry if there's 
already one there, and if not, then try to find out the BIOS geometry 
for the drive somehow and put that in.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

