Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263190AbTCSWFV>; Wed, 19 Mar 2003 17:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTCSWFV>; Wed, 19 Mar 2003 17:05:21 -0500
Received: from sarge.hbedv.com ([217.11.63.11]:33682 "EHLO sarge.hbedv.com")
	by vger.kernel.org with ESMTP id <S263190AbTCSWFM>;
	Wed, 19 Mar 2003 17:05:12 -0500
Date: Wed, 19 Mar 2003 23:16:08 +0100
From: Wolfram Schlich <lists@schlich.org>
To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared IRQs
Message-ID: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org>
Mail-Followup-To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Axis of Weasel(s)
X-Accept-Language: de, en, fr
X-GPG-Key: 0xCD4DF205 (http://wolfram.schlich.org/wschlich.asc, x-hkp://wwwkeys.de.pgp.net)
X-GPG-Fingerprint: 39EC 98CA 4130 E59A 1041  AD06 D3A1 C51D CD4D F205
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled Mar 24 2002 15:02:51)
X-Face: |P()Q^fx-{=,K-3g?5@Id4o|o{Xf_5v:z3WIhR3fOW-$,*=[#[Qq<,@P!OsXbR|i6n=]B<3mzGC++F@K#wvoLEnIZuTR6wPCMQfxq!';9w[TiP3Bhz"r&$7eGFq7us@Z5Qd$3W[3W3:U7biTNZgf"<]LqwS
X-Operating-System: Linux prometheus 2.4.21-pre5-grsec-1.9.9c #2 SMP Tue Mar 18 02:03:09 CET 2003 i686 unknown
X-Uptime: 10:55pm up 7 min, 1 user, load average: 1.80, 1.29, 0.62
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.9; AVE: 6.18.0.2; VDF: 6.18.0.15; host: mx.bla.fasel.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am experiencing system hardlocks under the following conditions:
- Hardware:
  - Tyan Thunder K7 w/ 2x Athlon MP 1.2GHz (5x PCI)
  - 2x Onboard Adaptec 7899P SCSI adapter
	IRQ 16, IRQ 17
  - 2x Onboard 3Com 3C982 100Mb 32bit PCI NIC
  	IRQ 18, IRC 19
  - 1x National Semiconductor DP83820 1000Mb 64bit PCI NIC
	IRQ 16
  - 2x Promise Ultra 133TX2 PDC20269
    IRQ 16, IRQ 17
- Software:
  - Linux 2.4.21-pre5:
  	CONFIG_IDE=y
	CONFIG_BLK_DEV_IDEDISK=y
	CONFIG_BLK_DEV_IDEPCI=y
	CONFIG_BLK_DEV_GENERIC=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	CONFIG_BLK_DEV_IDEDMA_PCI=y
	CONFIG_IDEDMA_PCI_AUTO=y
	CONFIG_BLK_DEV_IDEDMA=y
	CONFIG_BLK_DEV_ADMA=y
	CONFIG_BLK_DEV_PDC202XX_NEW=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	CONFIG_IDEDMA_IVB=y
	CONFIG_BLK_DEV_PDC202XX=y
	CONFIG_BLK_DEV_IDE_MODES=y

When one of the Promise controllers is sharing the same IRQ with one of
the NICs (don't matter which, I tried all) and data is copied *to* the
machine over the network, the system deadlocks. When data is copied
*from* the system over the network, it works all ok. Unfortunately the
system BIOS doesn't give me any possibility of setting the IRQ
channels by hand, so all I can do is put the cards into other slots.

Ah, at boot time the kernel spits out this message:
--8<--
I/O APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.
--8<--
I've not yet tried that, but will do now.
-- 
Wolfram Schlich; Friedhofstr. 8, D-88069 Tettnang; +49-(0)178-SCHLICH
