Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265621AbUBPOUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUBPOUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:20:25 -0500
Received: from aun.it.uu.se ([130.238.12.36]:2228 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265915AbUBPOUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:20:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16432.53658.676333.134293@alkaid.it.uu.se>
Date: Mon, 16 Feb 2004 15:20:10 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Will Cohen <wcohen@redhat.com>
Cc: Philippe Elie <phil.el@wanadoo.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] oprofile add Pentium Mobile support
In-Reply-To: <4030CBC3.6060605@redhat.com>
References: <20040212224152.GE316@zaniah>
	<16432.39480.817800.21083@alkaid.it.uu.se>
	<4030CBC3.6060605@redhat.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Cohen writes:
 > Mikael Pettersson wrote:
 > > Philippe Elie writes:
 > >  > From: Will Cohen <wcohen@redhat.com>
 > >  > 
 > >  > Add oprofile support for Pentium Mobile (P6 core). Pentium Mobile needs
 > >  > to unmask LVPTC vector, since it doesn't hurt other P6 core based cpus
 > >  > we do it unconditionally for all these.
 > > 
 > > [Patch talking about the Pentium-M.]
 > > 
 > > I can find no support in Intel's documentation (IA32 Volume 3,
 > > 25366813.pdf) that Pentium-M:s need to unmask LVTPC.
 > > 
 > > How certain are you of this? Is this an undocumented hardware
 > > quirk? If it is documented, please indicate where.
 > 
 > I have tested it on a Pentium M machine. Without the unmask LVTPC the 
 > nmi handler collected precisely one interrupt. With the LVTPC unmask the 
 > OProfile data collection worked normally.
 > 
 > > It's my theory that P4 added the auto-masking to help PEBS
 > > buffer overflow situations, but since P-M doesn't have PEBS,
 > > they shouldn't have had to change this on P-M as well.
 > > OTOH, it's certainly possible they changed it by accident.
 > 
 > My theory is that the Pentium M uses same bus interface and local apic 
 > as the Pentium M. Thus, the Pentium M shares the Pentium 4 need to 
 > unmask LVTPC.

Sounds reasonable and is consistent with other P-M vs P6 changes.

 > > One way of testing this would be to run a P-M with
 > > nmi_watchdog=2. If the NMI counter keeps ticking, then
 > > LVTPC does not need unmasking.
 > 
 > Yes, I tested the nmi watchdog and it currently does not work on the 
 > Pentium M. It doesn't get the later interrupts and states it is stuck.

That confirms the "undocumented HW quirk" theory. Thanks. I'll fix
the (in-kernel) NMI watchdog and (out-of-kernel) perfctr drivers.

/Mikael
