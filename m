Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTJSRRH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTJSRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:17:07 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:6558 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S261824AbTJSRRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:17:00 -0400
Message-ID: <40464.192.168.9.10.1066583818.squirrel@ncircle.nullnet.fi>
In-Reply-To: <006501c39660$cf306cf0$0514a8c0@HUSH>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>
    <48236.192.168.9.10.1066565636.squirrel@ncircle.nullnet.fi>
    <006501c39660$cf306cf0$0514a8c0@HUSH>
Date: Sun, 19 Oct 2003 20:16:58 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I have tested the kernel hpt374 drivers with all possible kernel
>> configurations with and without ACPI/APM, local apic, io-apic and
>> they don't seem to change anything in my case. I just get the following
>> error message sooner or later and the whole system hangs.
>>
>> Sep 26 23:07:42 alderan kernel: blk: queue c0466908, I/O limit 4095Mb
>> (mask 0xffffffff)
>> Sep 26 23:07:42 alderan kernel: hde: dma_timer_expiry: dma status ==
>> 0x20
>> Sep 26 23:07:42 alderan kernel: hde: timeout waiting for DMA
>> Sep 26 23:07:42 alderan kernel: hde: timeout waiting for DMA
>
> This is the EXACT same things I see in my logs.

Very interesting. The other type of errors I have received (the last time
with 2.4.23-pre4) were:

Sep 14 14:29:49 alderan kernel: hde: set_drive_speed_status: status=0xff {
Busy }
Sep 14 14:29:49 alderan kernel: blk: queue c0492188, I/O limit 4095Mb
(mask 0xffffffff)
Sep 14 14:29:49 alderan kernel: hde: set_drive_speed_status: status=0xff {
Busy }
Sep 14 14:29:49 alderan kernel: hde: dma_timer_expiry: dma status == 0x21
Sep 14 14:29:49 alderan kernel: hde: error waiting for DMA
Sep 14 14:29:49 alderan kernel: hde: dma timeout retry: status=0x50 {
DriveReady SeekComplete }
Sep 14 14:29:49 alderan kernel:
Sep 14 14:29:49 alderan kernel: hdg: set_drive_speed_status: status=0xff {
Busy }
Sep 14 14:29:49 alderan kernel: blk: queue c04925dc, I/O limit 4095Mb
(mask 0xffffffff)
Sep 14 14:29:49 alderan kernel: hdg: dma_timer_expiry: dma status == 0x00
Sep 14 14:29:49 alderan kernel: hdg: timeout waiting for DMA
Sep 14 14:29:49 alderan kernel: hdg: timeout waiting for DMA
Sep 14 14:29:49 alderan kernel: hdg: (__ide_dma_test_irq) called while not
waiting
Sep 14 14:29:49 alderan kernel: blk: queue c0492a30, I/O limit 4095Mb
(mask 0xffffffff)
Sep 14 14:29:49 alderan kernel: hdk: set_drive_speed_status: status=0xff {
Busy }
Sep 14 14:29:49 alderan kernel: blk: queue c0492e84, I/O limit 4095Mb
(mask 0xffffffff)
Sep 14 14:29:49 alderan kernel: hdk: dma_timer_expiry: dma status == 0x01
Sep 14 14:29:49 alderan kernel: hdk: set_drive_speed_status: status=0xff {
Busy }
Sep 14 14:29:49 alderan kernel: hdk: error waiting for DMA
Sep 14 14:29:49 alderan kernel: hdk: dma timeout retry: status=0x50 {
DriveReady SeekComplete }


>>
>> It might be that my problems are somehow related to the motherboards
>> I've been using, as the first one is "Epox 8K9A3+ (Via KT400 chipset)"
>> while the another one is "Epox 4PCA3+ (Intel 875p chipset)". But they
>> are 100% reproduceble with multiple brands of disk-drives.
>
> Mine is an Asus CUSL2, Pentium III motherboard with 512 Mb.

Ok, so it doesn't sound that the fault is only with Epox mb's.
I sincerely hope that someone with more knowledge about ide-stuff
could figure out something to overcome this particular problem ...
Currently my disk-drivers are made by 2*samsung (SV8004H) and
2*Samsung(SV1604N), in case that changes anything.

BTW. Have you noticed in what situation the lock up happens ?
As all my drivers are mirrored in pairs (ie. Raid1) the system
might run stable for 2-3 days before a lockup unless there is
some heavy transfers going on. In case any of the mirrors required
syncing when bootingg up the system, the system will lockup immediately.

What does /proc/interrupts show in your case ?
Mine is:
/proc/interrupts:

           CPU0
  0:  138788842    IO-APIC-edge  timer
  1:     328481    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:   21357900    IO-APIC-edge  rtc
 14:      14205    IO-APIC-edge  ide0
 16:  104139080   IO-APIC-level  radeon@PCI:1:0:0
 17:  136188388   IO-APIC-level  ide2, ide3, hpt374
 19:   98331044   IO-APIC-level  eth0
 21:   70689058   IO-APIC-level  ehci_hcd, usb-uhci, usb-uhci, usb-uhci
 22:   10181857   IO-APIC-level  VIA8233
NMI:          0
LOC:  138780432
ERR:          0
MIS:     109612

And have you tried with ACPI on/off and io-apic on/off ?

Regards,
Tomi Orava

-- 
Tomi.Orava@ncircle.nullnet.fi
