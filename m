Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTHYD7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbTHYD7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:59:39 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.36.231]:1973 "EHLO
	ms-smtp-03.texas.rr.com") by vger.kernel.org with ESMTP
	id S261409AbTHYD7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:59:37 -0400
Message-ID: <3F4989A7.2000104@austin.rr.com>
Date: Sun, 24 Aug 2003 22:59:35 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: via rhine network failure on 2.6.0-test4
References: <3F491E69.5090206@austin.rr.com> <3F497614.4090600@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff is probably right - /proc/interrupts is similar on both the failing 
(test4) and working (test3) except for the eth0 entry (the via rhine 
chipset on the motherboard) assigned to IRQ11 in test3 and IRQ5 in test4.

Differences in the boot.msg between test3 and test4 start with an entry 
"PM Adding info for No Bus: legacy" in the working one which is not 
found in the failing (test4) boot.msg.   There are differences in the 
"ACPI Subsystem revision" number that is logged.  Various ACPI related 
messages are found in the failing boot.msg before "ACPI interpreter 
enabled"    In the good one (test3) following the PCI: Probing PCI 
hardware line are a series of "PM: Adding info for ..". messages which 
look like they are finding  various PCI devices (these are not found in 
the failing test4 case).

I am experimenting with disabling ACPI on test4 to see if that bypasses 
the problem.


Jeff Garzik wrote:

> Steve French wrote:
>
>> The via rhine driver fails to get a dhcp address on my test system on 
>> 2.6.0-test4.   ethereal shows no dhcp request leaving the box but 
>> ifconfig does show the device and it is detected in /proc/pci.   
>> Switching from the test3 vs.  test4 snapshots built with equivalent 
>> configure options on the same system (SuSE 8.2) - test3 works but 
>> test4 does not.   This is using essentially the default config for 
>> both the test3 and test4 cases - the only changes are SMP disabled, 
>> scsi devices disabled, Athlon, via-rhine enabled in network devices 
>> and a handful of additional filesystems enabled, debug memory 
>> allocations enabled.   This is the first time in many months that I 
>> have seen problems with the via-rhine driver on 2.6
>>
>> Analyzing the code differences between 2.6.0-test3 and test4 (in 
>> via-rhine.c) is not very promising since the only line that has 
>> changed (kfree to free_netdev) is in the routine via_rhine_remove_one 
>> that seems unlikely to cause problems sending data on the network.
>>
>> Ideas as to what could have caused the regression?
>
>
>
> Does /proc/interrupts show any interrupts being received on your eth 
> device?  Does dmesg report any irq assignment problems, or similar?
>
> This sounds like ACPI or irq routing related.
>
>     Jeff
>
>
>
>


