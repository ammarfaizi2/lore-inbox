Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbUDGN1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUDGN1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:27:48 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:22189 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263399AbUDGN1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:27:16 -0400
Date: Wed, 7 Apr 2004 15:27:13 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
In-Reply-To: <20040407123909.GZ27362@lug-owl.de>
Message-ID: <Pine.LNX.4.55.0404071506570.16119@jurand.ds.pg.gda.pl>
References: <20040404101241.A10158@flint.arm.linux.org.uk>
 <20040404111712.GE27362@lug-owl.de> <20040404122958.A14991@flint.arm.linux.org.uk>
 <20040404120051.GF27362@lug-owl.de> <Pine.LNX.4.55.0404071304170.5705@jurand.ds.pg.gda.pl>
 <20040407123909.GZ27362@lug-owl.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Jan-Benedict Glaw wrote:

> 	- Separate RX and TX interrupt. This part is tricky because on
> 	  VAX, the triggered IRQ needs to be ACKed twice. On the CPU and
> 	  on the vsbus controller, as it seems. That is, both VAX IRQ
> 	  handlers explicitely ACK their respective vsbus IRQ.

 But this is done by the platform-specific IRQ controller handler -- the
driver is not aware of the setup used.  For example on the DECstation
interrupts arriving from the TURBOchannel, depending on the system, may
come through three kinds of IRQ controllers, for which the following
handlers are used: kn02_irq_type, ioasic_irq_type and
mips_cpu_irq_controller (hmm, the latter should probably be renamed for
consistency).  None of the TC drivers cares.

> 	- Register offsets are offset_mips = offset_vax * 2.

 Yes, and this essentially means we want configuration-specific read and
write backends.  For the Alpha the rule could be yet different.  Note the
driver now incorrectly operates directly on virtual addresses, while it
should use physical ones and obtain a virtual mapping as appropriate.

> I'm not that familiar with the TC busses. Do you have the same register
> offsets on the TC chips compared to the onboard DZ11? (So are
> register offsets machine specific or bus specific?)

 I can't recall TC wiring off the head.  Certainly the offsets may be
different as they depend on how the address decoders are set up.  I
suspect registers are word-aligned as the TC has a 32-bit data path.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
