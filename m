Return-Path: <linux-kernel-owner+w=401wt.eu-S1751034AbXANBZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXANBZb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbXANBZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:25:31 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:56456 "EHLO
	pd5mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbXANBZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:25:30 -0500
Date: Sat, 13 Jan 2007 19:23:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ahci_softreset prevents acpi_power_off
In-reply-to: <fa.kpxGqupQMKJxBBFrktFUzuoKc7c@ifi.uio.no>
To: Faik Uygur <faik@pardus.org.tr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>
Message-id: <45A9860D.5080506@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
References: <fa.enjQgtLFPdSkeJjKv6eOjULTovQ@ifi.uio.no>
 <fa.1s/e9SHVR6LQC2HgdZRykrqlV5Q@ifi.uio.no>
 <fa.kpxGqupQMKJxBBFrktFUzuoKc7c@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Faik Uygur wrote:
>> What happens when you try to shutdown?  
> 
> Does not shutdown and freezes.
> 
> Hand copied last messages seen on console:
> 
> Synchronizing SCSI cache for disk sda:
> ACPI: PCI Interrupt for device 0000:06:08.0 disabled
> Power down.
> acpi_power_off called
>   hwsleep-0285 [01] enter_sleep_state    : Entering sleep state [S5]

Since you're getting to this point I think this has to be some kind of 
BIOS interaction causing this. The only thing that happens after the 
"Entering sleep state" is that the kernel writes to some ACPI registers 
to tell the hardware to power down. I think some laptop BIOSes do things 
on ACPI power down like try to park the drive heads, etc. and maybe this 
change that you found from git bisecting is somehow interfering with it 
doing this?

Might want to check for a BIOS update first of all..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

