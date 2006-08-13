Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWHMGrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWHMGrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 02:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWHMGrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 02:47:19 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:16339 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750715AbWHMGrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 02:47:18 -0400
Message-ID: <44DECAF1.8020902@bonetmail.com>
Date: Sun, 13 Aug 2006 08:47:13 +0200
From: Jani Aho <jani.aho@bonetmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org, stable@kernel.org, i2c@lm-sensors.org
Subject: Re: Sensors broke between 2.6.16.16 and 2.6.16.17 - SOLVED
References: <44DE0DCE.4090305@bonetmail.com> <44DE4EC8.8090404@gmail.com>
In-Reply-To: <44DE4EC8.8090404@gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Jani Aho wrote:
>> Hi
>>
>> The sensors on my motherboard stopped working between 2.6.16.16 and
>> 2.6.16.17. The latest kernel version I have tried is 2.6.17.8 and it
>> still has the same problem.
>>
>> The motherboard is an ASUS P4PE and it uses the asb100 and i2c-i801
>> modules to get sensor information.
>>
>> A diff in /sys between a bad (2.6.17.8) and a good (2.6.16.16) kernel
>> gives:
>
> And is there any diff in dmesgs of those 2 kernels?
>
Problem solved.

The only related message in the dmesg diff was:

--- dmesg.bad   2006-08-13 08:21:21.000000000 +0200
+++ dmesg.good  2006-08-13 08:17:53.000000000 +0200
+PCI: Enabled i801 SMBus device

Looking at the changelog for 2.6.16.17, I found this patch:

commit a9cacd682ed7c031fa05b1d1367a3b3221813932
Author: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Date:   Mon May 15 09:44:33 2006 -0700

    [PATCH] smbus unhiding kills thermal management
    
    Do not enable the SMBus device on Asus boards if suspend is used.  We do
    not reenable the device on resume, leading to all sorts of undesirable
    effects, the worst being a total fan failure after resume on Samsung P35
    laptop.
    
    This fixes bug #6449 at bugzilla.kernel.org.


For some strange reason I had ACPI Sleep States enabled, so I disabled
it, recompiled the kernel and hey presto, the sensors are back.

Thanks for taking your time on this none problem

Jani
