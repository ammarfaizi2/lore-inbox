Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUQS3>; Wed, 21 Feb 2001 11:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBUQSU>; Wed, 21 Feb 2001 11:18:20 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:4335 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129051AbRBUQSD>; Wed, 21 Feb 2001 11:18:03 -0500
Date: Wed, 21 Feb 2001 17:16:56 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Matthias Kleine <Kleine_Matthias@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe a bug
In-Reply-To: <01021922344107.10203@orka>
Message-ID: <Pine.GSO.3.96.1010221170212.4012B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Matthias Kleine wrote:

> The problem appears on a machine using the pretty new ASUS CUVX-D Dual Socket 
> 370 Motherboard, so there may be a chance for an unknown bug ;-). With NMI 
> watchdog activated, a 2.4.x Kernel is not willing to boot on this machine, it 
> just stops booting at a very early time, giving the latest message 
> "activating NMI watchdog ..." and then blocking completely. Therefore, I set 

 Hmm, you state the watchdog works from time to time and the log you
provided confirms the statement -- it reports: 

> ..TIMER: vector=49 pin1=2 pin2=0
> activating NMI Watchdog ... done.

What chipset do you use (check with lspci)?

 In any case the code should not hang there in any case -- it the watchdog
appears stuck, it reports it and goes on.  A hang almost surely means
hardware locked up. 

> nmi_watchdog = 0, when the system boots properly, but leaves some crucial 
> message in /var/log/messages:
> 
> Feb 19 19:37:17 delphin kernel: testing the IO APIC.......................
> Feb 19 19:37:17 delphin kernel: 
> Feb 19 19:37:17 delphin kernel:  WARNING: unexpected IO-APIC, please mail
> Feb 19 19:37:17 delphin kernel:           to linux-smp@vger.kernel.org
> Feb 19 19:37:17 delphin kernel: .................................... done.

 No need to worry.  The code finds an unknown bit set in the version
register (well, the bit is unknown to the code -- the bit is documented
and we should mark it as such in the code soon, probably as a part of P4
support).

> Let me say, that the system seems to be usable after the boot, but when 
> starting X, some strange drawings hush over the screen. Afterwards, X is 
> running properly. Using a 2.2.x kernel this behaviour doesn't appear, with a 
> 2.4.x kernel, it is reproducable.

 Various reports seem to indicate XFree86 cannot cope with 2.4 SMP as it
should.  It's possible they do not handle synchronization well. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


