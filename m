Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266654AbSLJHFU>; Tue, 10 Dec 2002 02:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSLJHFU>; Tue, 10 Dec 2002 02:05:20 -0500
Received: from p0022.as-l043.contactel.cz ([194.108.242.22]:4850 "EHLO
	SnowWhite.janik.cz") by vger.kernel.org with ESMTP
	id <S266654AbSLJHFS> convert rfc822-to-8bit; Tue, 10 Dec 2002 02:05:18 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt>
	<m3fztrcinh.fsf@Janik.cz>
	<20021124114307.A25408@flint.arm.linux.org.uk>
	<m3vg2naupr.fsf@Janik.cz> <20021125094828.GA6016@pazke.ipt>
	<m3hee55qc6.fsf@Janik.cz>
	<20021201110202.E24114@flint.arm.linux.org.uk>
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Tue, 10 Dec 2002 08:07:46 +0100
In-Reply-To: <20021201110202.E24114@flint.arm.linux.org.uk> (Russell King's
 message of "Sun, 1 Dec 2002 11:02:02 +0000")
Message-ID: <m3vg22pd19.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Sun, 1 Dec 2002 11:02:02 +0000

Hi Russell,

   > Looking at all information in this thread so far, I think that you want
   > to use the existing pbn_b2_bt_2_115200 entry rather than creating an
   > additional entry for a card:
   > 
   >    { SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 115200 }, /*
   >    pbn_b2_bt_2_115200 */
   > 
   > -> Two ports, one at BASE2 the other at BASE3 running at a max baud of
   >    115200.

yes, this is it:

--- linux-2.4.19.orig/drivers/char/serial.c	Tue Dec  3 08:50:21 2002
+++ linux-2.4.19/drivers/char/serial.c	Tue Dec  3 08:53:38 2002
@@ -4672,6 +4678,10 @@
 		PCI_SUBVENDOR_ID_KEYSPAN,
 		PCI_SUBDEVICE_ID_KEYSPAN_SX2, 0, 0,
 		pbn_panacom },
+// PJ: New entry
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+		0xd841, 0x0200, 0, 0,
+		pbn_b2_bt_2_115200 },
 	{	PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_QUADMODEM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_panacom4 },

On the other hand, that card worked only with "IRQ" 0, ie. polling. We
could not got it running with the IRQ the PCI bus told us (there was only
one PCI card in the machine, no peripherals, no interrupt conflict...).

   > Your bios appears to have assigned the ports so that your patch will work,
   > but only if your bios keeps the (base3 = base2 + 8) relationship (which
   > isn't guaranteed.)

Yes, in the other machine, the difference was different.
-- 
Pavel Janík

Don't stop with your first draft.
                  --  The Elements of Programming Style (Kernighan & Plaugher)
