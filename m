Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKUSGu>; Tue, 21 Nov 2000 13:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbQKUSGk>; Tue, 21 Nov 2000 13:06:40 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:20629 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129231AbQKUSGb>; Tue, 21 Nov 2000 13:06:31 -0500
Date: Tue, 21 Nov 2000 18:35:33 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Benjamin Monate <Benjamin Monate" <Benjamin.Monate@lri.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <14874.41589.359267.717984@sun-demons>
Message-ID: <Pine.GSO.3.96.1001121175618.28403A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Benjamin Monate <Benjamin Monate wrote:

> About the 8254, the kernel log contains :
> 
> Nov 20 17:15:15 pc8-118 kernel: MP-BIOS bug: 8254 timer 
> 				not connected to IO-AP
> IC
> Nov 20 17:15:15 pc8-118 kernel: ...trying to set up timer (IRQ0)
> 						 through the 8259A ...  
> Nov 20 17:15:15 pc8-118 kernel: ..... (found pin 0) ...works.
> 
> But this does not seem to annoy the kernel.

 But this message is printed when a workaround for certain early SMP EISA
boards gets activated.  You shouldn't normally get it for anything newer
than P5/66 unless your MP-table is broken.  Can you send me a dump of your
MP-table (just issue `dmesg -s 32768' after a bootstrap -- the table is at
the top). 

> Is there anyway to restore the 8254 to a valid state without rebooting ?

 Well, in this specific configuration, it may be either the 8254 timer or
the 8259 legacy PIC as when the workaround gets activated both timer IRQs
and NMIs go through the latter.  It is certainly possible to reprogram
the chips but maybe we can find a way to avoid the lockup.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
