Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264646AbUEaOoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbUEaOoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 10:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUEaOoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 10:44:07 -0400
Received: from host29-34.pool8251.interbusiness.it ([82.51.34.29]:10219 "EHLO
	alpt.dyndns.org") by vger.kernel.org with ESMTP id S264640AbUEaOn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 10:43:58 -0400
Date: Mon, 31 May 2004 16:43:53 +0200
From: Alpt <alpt@freaknet.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Sonypi mess up the IRQ
Message-ID: <20040531144353.GA5826@darkalpt.freaknet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: hahaSRY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I was happily using my Linux box when the network went down.
Dmesg told me that was:
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000000 00000260
I've seen that it is an old issue for old kernel, but I'm using the 2.6.6 version.
I've also tried with the 2.6.5. Disabling the ACPI, rmmodding and insmodding 
the sis900 modules was useless.
Checking the syslog I've also seen that this problem happened the 5th of May.
But, without my notice, it was auto magically resolved! I don't know what happened, and that
day I didn't notice it because I thought that it was my fault.

When I tried my wifi pcmcia card I've got this from the hostap drivers:
hostap_cs: 0.2.0 - 2004-02-15 (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_cs: Registered netdevice wifi0
hostap_cs: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f
wifi0: NIC: id=0x800c v1.0.0
wifi0: PRI: id=0x15 v1.1.0
wifi0: STA: id=0x1f v1.4.9
wifi0: interrupt delivery does not seem to work
eth0: Media Link Off
wifi0: interrupt delivery does not seem to work
wifi0: could not get own MAC address
wifi0: Port type setting to 6 failed
wifi0: interrupt delivery does not seem to work
wlan0: interrupt delivery does not seem to work
hostap_cs: Shutdown failed
t[821]: remove event not handled
t[830]: remove event not handled
hostap_cs: Driver unloaded
Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c0173926>] remove_proc_entry+0xfa/0x134
 [<e1950a6b>] hostap_exit+0x30/0x69 [hostap]
 [<c0128290>] sys_delete_module+0x143/0x17b
 [<c013b859>] do_munmap+0x146/0x183
 [<c0103f33>] syscall_call+0x7/0xb

Then the high brightness of the monitor illuminated me.
It was the sonypi module! Every time that I load or unload the module,
the pcmcia receives his signal, but only that time. So the solution is
to never load the sonypi module or I have to reboot.

Cya
-- 
:wq!
"I don't know nothing" The One Who reached the Thinking Matter   '.'

[ Alpt --- Freaknet Medialab ]
[ GPG Key ID 441CF0EE ]
[ Key fingerprint = 8B02 26E8 831A 7BB9 81A9  5277 BFF8 037E 441C F0EE ]
