Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265867AbUAKMJa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUAKMJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:09:23 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:60032 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S265867AbUAKMJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:09:08 -0500
Message-ID: <40013CE1.6070305@steudten.com>
Date: Sun, 11 Jan 2004 13:09:05 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Problems with kernel 2.6.1 on alpha (scsi, modules, unaligned trap)
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
X-Authenticated-Sender: user thomas from 192.168.1.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

After some trouble to port my linux kernel on alpha sx614 from kernel
2.4.21 to 2.6.1 i collect here my problems found. Sure, on some alpha
systems this problems aren´t there.

Kernel 2.6.1:
1. BUG: "unaligned trap" in kernel mode (patch there, but not in the 2.6.1 
mainline)
2. BUG: "Relocation overflow vs section" by trying to load some modules 
with modprobe or insmod (patch there, but not in the 2.6.1 mainline)
3. Kernel boot message "***WARNING*** No MII transceivers found" after
soft reboot (no power off/on).
4. Kernel boot message "Unable to reserve mem region #2:1000@a051000 for 
device 0000:00:07.0" "aic7xxx: I/O ports already in use, ignoring."
5. Some modules (floppy, lp, loop..) won´t be autoloaded any more since 
2.4.21. There´s no block-major aso. request in the kernel-ring buffer.
I have /etc/modules.conf and /etc/modprobe.conf with modutils-2.4.21-23.1
and depmod -V: module-init-tools 3.0-pre5. How i can track this down?

Else no major problems with this kernel until know.
(I think the ipt_unclean from netfilter and the kerneld (or whatever) are
gone in 2.6.x) Sorry, if i miss something to read.

---------------8<----8<--------------

To 3)
00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
         Flags: bus master, medium devsel, latency 32, IRQ 24
         I/O ports at 8800 [size=128]
         Memory at 000000000a053000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at 000000000a020000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1

To 4)
scsi0:A:2:0: Tagged Queuing enabled.  Depth 128
(scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
   Vendor: IBM       Model: DDYS-T18350N      Rev: SA2A
   Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:3:0: Tagged Queuing enabled.  Depth 128
PCI: Unable to reserve mem region #2:1000@a051000 for device 0000:00:07.0
PCI: Unable to reserve mem region #2:1000@a051000 for device 0000:00:07.0
aic7xxx: <Adaptec AHA-294X Ultra SCSI host adapter> at PCI 0/7/0
aic7xxx: I/O ports already in use, ignoring.
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back

00:07.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
         Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
         Flags: bus master, medium devsel, latency 32, IRQ 26
         I/O ports at 8400 [size=256]
         Memory at 000000000a051000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at 000000000a040000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 1
 From /proc/ioports:
8400-84ff : 0000:00:07.0

-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?



