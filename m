Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbUCYQkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUCYQkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:40:08 -0500
Received: from aun.it.uu.se ([130.238.12.36]:58614 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263322AbUCYQkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:40:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16483.2897.308540.252104@alkaid.it.uu.se>
Date: Thu, 25 Mar 2004 17:39:45 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, macro@ds2.pg.gda.pl
Subject: Re: apic errors and looping with 2.4, none with 2.2
In-Reply-To: <Pine.LNX.4.58.0403230420000.25095@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0403230420000.25095@potato.cts.ucla.edu>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Stromsoe writes:
 > I have one machine that won't run 2.4.  As soon as a 2.4 kernel boots, it
 > starts throwing APIC errors.
 > 
 > The machine is a dual CPU pIII 933MHz system with 512Mb ram on a
 > SuperMicro motherboard, either a P3TDLR or a 370DLR, with the ServerWorks
 > LE chipset.  I'm booting using lilo with append="noapic".
 > 
 > As soon as I boot into a 2.4 kernel, I start getting APIC errors on both
 > CPUs.  Varying combinations of:
 > 
 > Mar 23 00:40:45 dahlia kernel: APIC error on CPU0: 02(08)
 > Mar 23 00:40:45 dahlia kernel: APIC error on CPU1: 01(08)
...
 > After a few hours of uptime, the box stops responding to keyboard input.
 > It begins printing the above messages to console over and over.  I have
 > several other identical machines that I received in the same batch that
 > run 2.4 without any problems (though they do seem to require "noapic").
 > 
 > It runs fine with 2.2 and is running 2.2.26 right now.

Like Maciej wrote, the machine's local APIC bus corrupts messages.
The fact that your other supposedly-identical machines don't have
this problem indicates strongly that this particular box has a HW
problem. It could be a weak power-supply, inadequate cooling, a
bad CPU, or a bad motherboard.

I just checked the 2.2.25 kernel and it doesn't seem to enable
APIC_LVTERR. You're problably getting APIC bus errors with 2.2
too, you just won't see them logged anywhere.

(Regarding your other boxes that need "noapic": you have tried
w/o ACPI, right? acpi=off or pci=noacpi.)

/Mikael
