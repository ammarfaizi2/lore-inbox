Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270705AbTGNRxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270708AbTGNRxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:53:04 -0400
Received: from mail-6.tiscali.it ([195.130.225.152]:43405 "EHLO
	mail-6.tiscali.it") by vger.kernel.org with ESMTP id S270705AbTGNRwT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:52:19 -0400
Date: Mon, 14 Jul 2003 20:03:37 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: scott.feldman@intel.com
Subject: [2.5.75] Slab corruption
Message-ID: <20030714180337.GA918@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I got  a slab corruption under  2.5.75. I was browsing with  mozilla 1.4
and this  was the only  network load. Kernel is UP  with CONFIG_PREEMPT.
Full .config is here: web.tiscali.it/kronoz/config-2.5.75

This is the first error:

Slab corruption: start=ef1962f4, expend=ef196af3, problemat=ef196503
Last user: [kfree_skbmem+20/48](kfree_skbmem+0x14/0x30)
Data: ***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************FF *******01 *******04 *******07 *******04 *******FE *******FA *******F9 *******************************************************************************************************************************************************************************************************08 *******06 *******04 *******04 *******03 *******01 *******00 *******01 *********************************************************************************************************************
Next: 71 F0 2C .44 23 2F C0 A5 C2 0F 17 ..................20 A0 
slab error in check_poison_obj(): cache `size-2048': object was modified after freeing
Call Trace:
 [check_poison_obj+363/432] check_poison_obj+0x16b/0x1b0
 [__kmalloc+361/464] __kmalloc+0x169/0x1d0
 [alloc_skb+72/240] alloc_skb+0x48/0xf0
 [alloc_skb+72/240] alloc_skb+0x48/0xf0
 [_end+945553231/1068985560] e100_rx_srv+0x197/0x530 [e100]
 [_end+945552455/1068985560] e100intr+0x1bf/0x200 [e100]
 [handle_IRQ_event+59/112] handle_IRQ_event+0x3b/0x70
 [do_IRQ+321/928] do_IRQ+0x141/0x3a0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [acpi_processor_idle+346/495] acpi_processor_idle+0x15a/0x1ef
 [default_idle+0/48] default_idle+0x0/0x30
 [acpi_processor_idle+0/495] acpi_processor_idle+0x0/0x1ef
 [default_idle+0/48] default_idle+0x0/0x30
 [cpu_idle+49/64] cpu_idle+0x31/0x40
 [rest_init+0/240] _stext+0x0/0xf0
 [start_kernel+432/528] start_kernel+0x1b0/0x210
 [unknown_bootoption+0/256] unknown_bootoption+0x0/0x100

It  seems e100  fault... after  that I  saw other  (maybe related)  slab
corruptions. Full log is here: web.tiscali.it/kronoz/slab-2.5.75.txt

The CPU is quite cool and the system survived memtest some time ago.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
