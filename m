Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbSLKUuY>; Wed, 11 Dec 2002 15:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbSLKUuX>; Wed, 11 Dec 2002 15:50:23 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:14220 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S267311AbSLKUuV>; Wed, 11 Dec 2002 15:50:21 -0500
Message-ID: <3DF7A706.3020600@verizon.net>
Date: Wed, 11 Dec 2002 15:58:46 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.51 - Strange UP APIC / 8139too / USB issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [64.223.83.18] at Wed, 11 Dec 2002 14:58:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I have a system with an Abit AT7 motherboard:  VIA KT333, single Athlon, 
512M RAM, onboard RTL8139 network, USB, USB2, 1394.  *NO* onboard PS/2 
keyboard or mouse ports.
Other:  IDE HD, CD-RW, and DVD.  Radeon 8500DV (will try getting that 
working later :)

I have used the system successfully with 2.4, and have been trying to 
get 2.5 to work.  Until now, I haven't been able to get the USB keyboard 
to work.  It is initialized by the BIOS, and is usable by GRUB for 
selecting boot images.

I finally found the culprit - "Local APIC Support on Uniprocessors" and 
"IO-APIC on uniprocessors".  If both items are enabled, the network 
functions, but USB doesn't work.  If not both are enabled (neither, or 
Local APIC but not IO-APIC), then the USB system works, but the network 
doesn't.  :(

I am not using modules.

these are the only differences in .config:

multimedia linux-2.5.51 # diff -u working_network 
working_usbkeyboard_config3
--- working_network     2002-12-11 15:43:31.000000000 -0500
+++ working_usbkeyboard_config3 2002-12-11 15:15:53.000000000 -0500
@@ -63,9 +63,8 @@
 # CONFIG_SMP is not set
 # CONFIG_PREEMPT is not set
 CONFIG_X86_UP_APIC=y
-CONFIG_X86_UP_IOAPIC=y
+# CONFIG_X86_UP_IOAPIC is not set
 CONFIG_X86_LOCAL_APIC=y
-CONFIG_X86_IO_APIC=y
 CONFIG_X86_MCE=y
 CONFIG_X86_MCE_NONFATAL=y
 # CONFIG_X86_MCE_P4THERMAL is not set

I can send complete configs, lspci / lsusb / whatever else anyone wants.

Thanks
- Steve



