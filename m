Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQJ3LQe>; Mon, 30 Oct 2000 06:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQJ3LQY>; Mon, 30 Oct 2000 06:16:24 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:41883 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129244AbQJ3LQE>; Mon, 30 Oct 2000 06:16:04 -0500
Date: Mon, 30 Oct 2000 12:12:16 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        mj@suse.cz
Subject: Re: Questions on lack of piix4 usb interrupts
In-Reply-To: <200010301014.CAA05591@adam.yggdrasil.com>
Message-ID: <Pine.GSO.3.96.1001030120306.11987B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Adam J. Richter wrote:

> 	My question is: could I get a slightly more detailed
> explanation of what exactly the quirk_piix3usb routine was
> trying to fix so I can better understand if I am bumping into
> the same problem?  Do I understand correctly that the piix3 fixup
> makes the current uhci drivers unusable on the effected hardware?

 It disables the HC's IRQ as it's stuck asserted otherwise.  With another
device sharing the IRQ you receive a never-ending storm of interrupts,
which is wrong and also hurts performance badly -- basically after an EOI
you receive another interrupt as soon as an IRQ controller can feed it. 
The USB driver is expected to reenable the IRQ and handle it.  If no USB
driver gets installed the IRQ remains disabled as expected.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
