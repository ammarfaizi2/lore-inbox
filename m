Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWAPMFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWAPMFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWAPMFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:05:34 -0500
Received: from wildsau.enemy.org ([193.170.194.34]:51078 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1750725AbWAPMFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:05:34 -0500
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200601161203.k0GC3awd019159@wildsau.enemy.org>
Subject: Q on SATA: 16bit post linux problem
To: linux-kernel@vger.kernel.org
Date: Mon, 16 Jan 2006 13:03:36 +0100 (MET)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good day,

I have a question relating to serial ATA, and do not know where to
start lookign for information. I hope to find useful tips here in lkml.

(1) machine boot:

  the machine boots in 16 bit mode and gets its data via bios int 0x13
  from the harddisk - even if the drive is a SATA drive. this tells me
  that there is some kind of emulation mode. this emulation mode is,
  methinks, not bios related, but this seems to be a chip-thing, similar
  to making a usb-mouse or usb-keyboard perform like a ps2-protocol-mouse
  on a ps2-port. "chip-thing" means e.g. chipsets like ICH6 or similar.

(2) linux boot:

  linux goes in 32bit protected mode and repograms the chip. the
  "sata-emulation-mode" is gone.

(3) return to 16 bit mode:

  there's a call in the linux-kernel which allows to switch the CPU
  to 16bit real mode (and never return, but that's not important here).

  however, alltough most of the BIOS works, the int 0x13 does not work
  anymore in combination with SATA drives. (it _does_ work with PATA)
  if what I've guessed in (1) is right (emulation-mode done by chipset),
  then there must be some way to reprogram the chipset. that's what the
  BIOS does anyway when doing a "jmp far 0xffff:0". But reverse engineering
  the BIOS of the machine in question is beyond the scopt of the project.

so, my question:

  does anyone which values to write at which IO-adresses to reset
  the SATA subsystem? the chip in question is an intel ICH6:
  vendor 0x8086 and prodId 0x2653

kind regards,
herbert "herp" rosmanith



  
