Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVCOMJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVCOMJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVCOMJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:09:16 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:8404 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261184AbVCOMJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:09:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Wkef/KKjf4rovwn4G+QE8jfzCCyeBUkBY4GgBMCd3A7fAQqtQ0J+fKCnmrv2pCo2053nVG5epkGTZ9hOG/EcBA23O+U1jKMOINDyNUMYUhbZgZfpz8ZMUgZDj4q90l2Gj+tAonjCytbGfmZoIB6ONlH1YhJhXQ3rgdkIdC7Zh1E=
Message-ID: <5a2cf1f6050315040956a512a6@mail.gmail.com>
Date: Tue, 15 Mar 2005 13:09:03 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: enabling IOAPIC on C3 processor?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a VIA Epia M10000 board that crashes very badly (and pretty
often, especially when using DMA). I want to fix that.

Serial console + magic SysRQ didn't help so I am going the nmi
watchdog way. But in order to have nmi watchdog I need APIC, right?

The C3 processor seems to support IOAPIC.
(http://www.via.com.tw/en/products/processors/c3/specs.jsp)

But:
- I don't see anything in the BIOS related to APIC. 
- grep APIC /lib/modules/`uname -r`/build/.config shows me that all
APIC options are 'y'.
- dmesg | grep APIC tells me "no local APIC present or hardware disabled".
- adding lapic kernel parameter doesn't change that. 
- and of course, nmi_watchdog=1 or 2 gives me NMI count 0 in /proc/interrupts.

Did I miss something when it comes to enabling IOAPIC support on C3 processor?

Note: I also see a lot an increasing ERR count in /proc/interrupts,
especially when I put my box in conditions that make it also more
unstable (i.e. sending files on the network while using the PVR-350
using mythtv). Not sure if it is related.

Jerome

medios@medios:~$ dmesg | grep APIC
No local APIC present or hardware disabled
mapped APIC to ffffd000 (013c1000)

medios@medios:~$ grep APIC /lib/modules/`uname -r`/build/.config 
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

Grub options
[...]
kernel          /vmlinuz-2.6.11-medios1 root=/dev/hda1 ro 
console=ttyS0,57600n8 console=tty0 nmi_watchdog=1 lapic
[...]
