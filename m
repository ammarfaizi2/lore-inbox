Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTJCIis (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTJCIis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:38:48 -0400
Received: from firewall.indigita.com ([65.211.227.66]:12522 "EHLO
	control2.indigita.com") by vger.kernel.org with ESMTP
	id S263642AbTJCIiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:38:46 -0400
Date: Fri, 3 Oct 2003 01:38:43 -0700
From: David Caldwell <david+kernel@porkrind.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG?] lost interrupt (was: SIS IDE DMA errors)
Message-ID: <20031003083837.GA5036@indigita.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x7k3vlokf.fsf@users.sourceforge.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With all 2.6.0 versions so far, I get these errors when writing lots
> of data to the disk:

I am getting these same errors with 2.6.0-test6. The difference is,
I'm not using a SiS IDE controller. I have a Promise 20276 on my
motherboard which was the controller getting the lost interrupt
error. I am running RAID5 using disks on this controller and on a
Promise 20267 PCI card (note: 67 not 76!). I seemed to start getting
the error when my disks started going with lots of activity.

I had booted with "noapic" at the time. Without "noapic" my
motherboard wouldn't boot at all (it seemed to hang right after
detecting the IDE devices, but I don't know if that is relevant).

> Losing too many ticks!
> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> Falling back to a sane timesource.

I was definitely getting this same error.

> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt

I was definitely getting this error, except it was on hdg (my promise
20276).

> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hda: drive not ready for command

I don't remember if I was getting this error or not.

Here is my lspci output:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:08.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 04)
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
00:0a.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 04)
00:0b.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:0f.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:14.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:14.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:14.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/6326 (rev 92)

I didn't have the forethought to save my dmesg output. This screwed up
my RAID pretty bad, so I'm a little reticent about making it happen
again...

I just wanted to let it known that it wasn't just happening to SiS IDE
controllers.

-David
