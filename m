Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270354AbTHLN5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270352AbTHLN5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:57:51 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:23457 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S270354AbTHLN5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:57:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16184.62018.545010.839328@gargle.gargle.HOWL>
Date: Tue, 12 Aug 2003 15:57:22 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dave Jones <davej@codemonkey.org.uk>, torvalds@transmeta.com,
       fxkuehl@gmx.de, linux-kernel@vger.kernel.org, willy@w.ods.org
Subject: Re: [PATCH][2.6.0-test3] Disable APIC on reboot.
In-Reply-To: <Pine.GSO.3.96.1030812154705.7029B-100000@delta.ds2.pg.gda.pl>
References: <16184.10167.743824.668791@gargle.gargle.HOWL>
	<Pine.GSO.3.96.1030812154705.7029B-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 > On Tue, 12 Aug 2003, Mikael Pettersson wrote:
 > 
 > > @@ -249,6 +250,14 @@
 > >  	 * other OSs see a clean IRQ state.
 > >  	 */
 > >  	smp_send_stop();
 > > +#elif CONFIG_X86_LOCAL_APIC
 > > +	if (cpu_has_apic) {
 > > +		local_irq_disable();
 > > +		disable_local_APIC();
 > > +		local_irq_enable();
 > > +	}
 > > +#endif
 > > +#ifdef CONFIG_X86_IO_APIC
 > >  	disable_IO_APIC();
 > >  #endif
 > 
 >  You obviously want to disable I/O APICs first.

This follows the same order that the SMP reboot code has been using
for ages. I did check disable_IO_APIC(), and it does not depend on
the BP's local APIC being enabled.

I don't think there is a bug, but if there is, it's in the original
code too (simply trace what an SMP kernel on UP_IOAPIC HW would do).

/Mikael
