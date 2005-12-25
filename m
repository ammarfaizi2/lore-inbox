Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVLYAhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVLYAhf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 19:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVLYAhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 19:37:35 -0500
Received: from lucidpixels.com ([66.45.37.187]:28354 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750763AbVLYAhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 19:37:34 -0500
Date: Sat, 24 Dec 2005 19:37:34 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
cc: apiszcz@lucidpixels.com
Subject: Re: Using Intel ICH5 IDE+SATA Under 2.6.15-rc6 - Cannot find DVD-RW?
In-Reply-To: <Pine.LNX.4.64.0512241935380.5009@p34>
Message-ID: <Pine.LNX.4.64.0512241937230.5009@p34>
References: <Pine.LNX.4.64.0512241837120.2700@p34> <Pine.LNX.4.64.0512241935380.5009@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Impressive:

http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux

DVD drive not recognized

The ata_piix SATA driver grabs ownership over the IDE ports when it is 
loaded, but (by default) does not support PATA ATAPI devices such as the 
Ultrabay optical drives. Thus, if the ide driver is compiled as a module 
and loaded after ata_piix, the DVD drive will not be recognized by either 
driver.

Either of the following configurations will work:

     * For kernel 2.6.14 and newer: enable ATAPI support in the SATA system 
using libata.atapi_enabled=1 (see below; this is experimental).
     * Compile IDE into the kernel (non-module).
     * Compile both IDE and SATA as modules and make sure IDE is loaded 
first (the module is called 'ide_generic').

Note that the optical drive must be in the Ultrabay during system boot 
(Ultrabay device swapping is currently unsupported).

On Sat, 24 Dec 2005, Justin Piszcz wrote:

> http://www.ussg.iu.edu/hypermail/linux/kernel/0407.0/0362.html
>
> This is the same problem I am having (no OOPS but I cannot see the DVD drive 
> either)--
>
> Justin.
>
> On Sat, 24 Dec 2005, Justin Piszcz wrote:
>
>> The BIOS see's my drive without any issues.
>> 
>> My config: [AUTO, allow for up to 6 devices on IDE/SATA total]
>> 
>> p34:~# cat /dev/hdc
>> cat: /dev/hdc: No such device or address
>> p34:~# cat /dev/sdc
>> cat: /dev/sdc: No such device or address
>> p34:~#
>> 
>> p34:~# dmesg | grep NEC
>> p34:~#
>> 
>> CONFIG =
>> 
>> SATA1 -> RAPTOR
>> SATA2 -> SEAGATE
>> IDE0 -> NOTHING
>> IDE1 -> MASTER (DVDRW/CDRW)
>> 
>> But for some reason the kernel is not seeing it?
>> 
>> 
>> 
>
