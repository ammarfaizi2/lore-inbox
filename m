Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUBFWol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUBFWol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:44:41 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:46871 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265649AbUBFWoe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:44:34 -0500
X-BrightmailFiltered: true
Date: Fri, 6 Feb 2004 23:44:32 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040206224432.GA23794@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205203840.GA13114@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> ha scritto:
> On Thu, Feb 05, 2004 at 05:24:27PM +0000, Murilo Pontes wrote:
>> I have same problems since of 2.6.0, now I running 2.6.2 stock kernel
>> I run XFree86-4.3.0 and still with problems, anyone try XFree86-4.4.0 devel snapshots???
>> 
>> I try kernel with/without  preempty/acpi/apic make all possibilities, 
>> then may be error is not in kernel, but in XFree86-4.3.0 which not support big changes in input system
>> of 2.6.x, I tried compile XFree86 with linux-2.6.{0,1,2} kernel headers was 100% fail, sounds binary 
>> and source incompatibilites,  
> 
> Hey, guys, could you possibly try to figure out what your machines have
> in common? I've switched all my computers to PS/2 mice so that I have a
> bigger chance to reproduce the problem, but it is not happening on any
> of them.

I see also this messages (other than XFree being buggy):

psmouse.c: bad data from KBC - bad parity
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.

They seem totaly random, this one happened while the system was almost
idle (was talking to a friend of mine using licq, under X). DMA is
turned on (but disks were idle).

I tried to reproduce under heavy disk and network load but without
success. However, it seems that the problem often happens when switching
from console to X (can't reproduce...).

This is the mouse:

root@dreamland:~# cat /proc/bus/input/devices
I: Bus=0011 Vendor=0002 Product=0005 Version=0000
N: Name="ImPS/2 Generic Wheel Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

and lspci:

root@dreamland:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 40)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro]
01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 9500 Pro] (Secondary)

kernel is 2.6.2 UP with preempt (I'm sorry but I'm preparing some exams
so don't have much free time to test other configuration). 2.6.1 works
fine.

HTH,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non capisco tutta questa eccitazione per il Multitasking: 
io sono anni che leggo in bagno.
