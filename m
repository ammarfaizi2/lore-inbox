Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129681AbRBBEHr>; Thu, 1 Feb 2001 23:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbRBBEH2>; Thu, 1 Feb 2001 23:07:28 -0500
Received: from pedigree.cs.ubc.ca ([142.103.6.50]:30650 "EHLO
	pedigree.cs.ubc.ca") by vger.kernel.org with ESMTP
	id <S129681AbRBBEHV>; Thu, 1 Feb 2001 23:07:21 -0500
From: Patrice Belleville <patrice@cs.ubc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.12918.926146.84389@poirot.cs.ubc.ca>
Date: Thu, 1 Feb 2001 20:07:18 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: Re: e2fs corruption with 2.4.0-ac12
In-Reply-To: <200102012259.XAA02016@noefs.ping.de>
In-Reply-To: <200102012259.XAA02016@noefs.ping.de>
X-Mailer: VM 6.75 under 21.2  (beta41) "Polyhymnia" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 1, Wolfgang Wegner <wolfgang@leila.ping.de> writes:

 > just for the records, as I saw some reports about  fs corruption: I had
 > a case of e2fs corruption  under 2.4.0-ac12 on  an IDE drive (Intel  BX
 > chipset) yesterday.

I  also had    such problems twice    on my  Sony    VAIO PCGF-430,  using
2.4.1-test10 + the  ACPI  patch "acpi-20010125.diff". In both  cases,  the
system locked up tight (X wasn't responding, and I was unable to switch to
a different  virtual console), a  cold  boot was  required, and there  was
filesystem corruption  that forced me  to  run fsck  manually. Luckily, no
essential file was destroyed. 

As the files involved were certainly  not in the  process of being updated
when the system locked  up [in one case   it involved man pages],  I don't
believe the corruption was caused  directly by the  lockup. I include  the
relevant part of the output from /sbin/lspci below.

I  went back  to 2.4.0,  which  works perfectly apart  from  the fact that
kacpid oopses  on startup, and has not  seen  any corruption since. Please
let me know if  there's any additional information  that I can provide  to
help track the problem down.

                                                                   Patrice

---
**------------------------------------------------------------------------
** Patrice Belleville (patrice@cs.ubc.ca)                   (604) 822-9870
** Instructor and Departmental advisor,     Department of Computer Science
**------------------------------------------------------------------------

---
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
     Subsystem: Sony Corporation: Unknown device 806f
     Flags: bus master, medium devsel, latency 64
     Memory at 40000000 (32-bit, prefetchable) [size=16M]
     Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
     Flags: bus master, 66Mhz, medium devsel, latency 128
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
     Memory behind bridge: fe800000-fecfffff
     Prefetchable memory behind bridge: fd000000-fdffffff

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	 Flags: bus master, medium devsel, latency 64
	 I/O ports at fc90 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	 Flags: medium devsel, IRQ 9
	 I/O ports at fca0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Flags: medium devsel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
