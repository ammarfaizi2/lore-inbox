Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVALUBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVALUBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVALUAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:00:04 -0500
Received: from lucidpixels.com ([66.45.37.187]:46210 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261342AbVALTwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:52:15 -0500
Date: Wed, 12 Jan 2005 14:52:14 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Question regarding ERR in /proc/interrupts.
In-Reply-To: <41E57B0C.30905@osdl.org>
Message-ID: <Pine.LNX.4.61.0501121447040.11524@p500>
References: <Pine.LNX.4.61.0501121410360.11524@p500> <41E57B0C.30905@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is 2.6.10.

The patch would effectively increment the ERR counter for each ERR 
correct?

Is there anyway to trace the path or cause of an ERR?

For instance, I know I can make one occur like this:

I have 3 promise boards in a box, when I am doing multiple transfers 
across 2-3 drives and doing an NFS transfer, I may hear the IBM or Hitachi 
disk click and the ERR will incremement or just a long pause.  Also, I 
have used the IBM drive for 4-5+ yrs, never had any data corruption.  The 
disks themselves are not bad.  It would just be nice to understand why 
such spurious interrupts occur.

Dell Setup:

  PCI SLOT 1 = PCI1

  The PCI slots are on a riser board (Dell GX1p)

  PCI1 = Closest to motherboard.

  PCI1 = Intel GigE Nic
  PCI2 = Promise ATA/100
  PCI3 = Maxtor Promise ATA/133
  PCI4 = Maxtor Promise ATA/133
  PCI5 = 4 Port 10/100 NIC
  ISA1 = Empty
  ISA2 = Empty
  ISA3 = Empty

  Note: Nothing is attached to the system's IDE ports, they are disabled.
        I also turned off ACPI/stuff I do not use.



  On Wed, 12 Jan 2005, Randy.Dunlap 
wrote:

> Justin Piszcz wrote:
>> Is there anyway to log each ERR to a file or way to find out what caused 
>> each ERR?
>> 
>> For example, I know this is the cause of a few of them:
>> spurious 8259A interrupt: IRQ7.
>> 
>> But not all 20, is there any available option to do this?
>
> Are you sure about that?
>
> MOTD:  what kernel version?
>
> 2.6.10 (and probably all) prints such message one time for each
> "spurious" IRQ, sets a flag for that IRQ, and then doesn't
> print such message for that IRQ any more (i.e., so that
> log isn't spammed).  Each distinct spurious IRQ should be
> logged (one time).  If you want more, you'll need to patch
> a source file and rebuild the kernel (attached, for i8259
> PIC, not for APIC, since that's what you seem to have).
>
>> $ cat /proc/interrupts
>>            CPU0
>>   0:  887759057          XT-PIC  timer
>>   1:       3138          XT-PIC  i8042
>>   2:          0          XT-PIC  cascade
>>   5:       5811          XT-PIC  Crystal audio controller
>>   9:  265081861          XT-PIC  ide4, eth1, eth2
>>  10:    9087912          XT-PIC  ide6, ide7
>>  11:     837707          XT-PIC  ide2, ide3
>>  12:      13854          XT-PIC  i8042
>>  14:   63373075          XT-PIC  eth0
>> NMI:          0
>> ERR:         20
>
> -- 
> ~Randy
>
