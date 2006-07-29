Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWG2OJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWG2OJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 10:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWG2OJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 10:09:50 -0400
Received: from 83-216-141-215.markhi700.adsl.metronet.co.uk ([83.216.141.215]:31250
	"EHLO mx.hindley.org.uk") by vger.kernel.org with ESMTP
	id S932150AbWG2OJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 10:09:50 -0400
Date: Sat, 29 Jul 2006 15:09:42 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.6.17.7 BUG] bonding + wifi -> BUG: scheduling while atomic
Message-ID: <20060729140942.GA11083@hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Mark Hindley <mark@hindley.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following BUG: scheduling while atomic when I remove my wifi
pccard (madwifi) which is bonded to the wired interface in active-backup
mode.

I think this is bonding related, as there is no BUG logged when the wifi
interface is standalone.

This is 2.6.17.7, but has certainly existed with all 2.6.17. 
System: Acer Aspire 1350, preempt kernel, both bonding and madwifi
drivers are modular.

Let me know if you need more info, or if I should take this somewhere else.

Thanks

Mark



Jul 29 10:38:54 mercury kernel: pccard: card ejected from slot 0
Jul 29 10:38:55 mercury kernel: bonding: bond0: link status definitely down for interface ath0, disabling it
Jul 29 10:38:55 mercury kernel: BUG: scheduling while atomic: pccardd/0x00000102/1675
Jul 29 10:38:55 mercury kernel:  <c0269f49> schedule+0x43/0x531 <c012786a> autoremove_wake_function+0x18/0x3a
Jul 29 10:38:55 mercury kernel:  <c01149c1> __wake_up_common+0x2b/0x4e <c026b458> __down+0x86/0xed
Jul 29 10:38:55 mercury kernel:  <c0114984> default_wake_function+0x0/0x12  <c0269edf> __down_failed+0x7/0xc
Jul 29 10:38:55 mercury kernel:  <ccb1ef00> .text.lock.if_ath+0x8b/0xb3 [ath_pci]  <ccb8f70b> bond_update_speed_duplex+0xa6/0xed [bonding]
Jul 29 10:38:55 mercury kernel:  <c0114a05> __wake_up+0x21/0x44 <c01182f5> printk+0xe/0x11
Jul 29 10:38:55 mercury kernel:  <ccb90f6e> bond_mii_monitor+0x32e/0x3e1 [bonding]  <c011f399> run_timer_softirq+0x13c/0x19c
Jul 29 10:38:55 mercury kernel:  <ccb90c40> bond_mii_monitor+0x0/0x3e1 [bonding]  <c011be84> __do_softirq+0x34/0x7d
Jul 29 10:38:55 mercury kernel:  <c011beef> do_softirq+0x22/0x26 <c011bf89> irq_exit+0x29/0x34
Jul 29 10:38:55 mercury kernel:  <c01051ae> do_IRQ+0x1e/0x24  <c0103b0a> common_interrupt+0x1a/0x20
Jul 29 10:38:55 mercury kernel:  <c010c1ea> delay_pmtmr+0xd/0x15 <c01adbcc> __delay+0xc/0xe
Jul 29 10:38:55 mercury kernel:  <ccaad650> zz002dca0b+0x3c/0x5c [ath_hal]  <ccaad63f> zz002dca0b+0x2b/0x5c [ath_hal]
Jul 29 10:38:55 mercury kernel:  <ccb1ccad> ath_draintxq+0x20/0xda [ath_pci]  <ccb181db> ath_stop_locked+0xc4/0xf4 [ath_pci]
Jul 29 10:38:55 mercury kernel:  <ccb18229> ath_stop+0x1e/0xa3 [ath_pci] <ccb17a82> ath_detach+0x37/0x82 [ath_pci]
Jul 29 10:38:55 mercury kernel:  <ccb1f27d> ath_pci_remove+0x12/0x71 [ath_pci]  <c01b28d6> pci_device_remove+0x19/0x2c
Jul 29 10:38:55 mercury kernel:  <c01ffea3> __device_release_driver+0x58/0x85  <c01ffee7> device_release_driver+0x17/0x26
Jul 29 10:38:55 mercury kernel:  <c01ff715> bus_remove_device+0x52/0x65 <c01fe9ae> device_del+0x39/0x65
Jul 29 10:38:55 mercury kernel:  <c01fe9e5> device_unregister+0xb/0x16 <c01b0b05> pci_destroy_dev+0x1f/0xa0
Jul 29 10:38:55 mercury kernel:  <c01b0c48> pci_remove_behind_bridge+0x22/0x36  <cc89484f> socket_shutdown+0x8f/0x100 [pcmcia_core]
Jul 29 10:38:55 mercury kernel:  <cc894d24> socket_detect_change+0x3b/0x52 [pcmcia_core]  <cc894e56> pccardd+0x11b/0x1b9 [pcmcia_core]
Jul 29 10:38:55 mercury kernel:  <c0114984> default_wake_function+0x0/0x12  <c0102a46> ret_from_fork+0x6/0x20
Jul 29 10:38:55 mercury kernel:  <c0114984> default_wake_function+0x0/0x12  <cc894d3b> pccardd+0x0/0x1b9 [pcmcia_core]
Jul 29 10:38:55 mercury kernel:  <c01012f5> kernel_thread_helper+0x5/0xb 

