Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271591AbTGQWRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271583AbTGQWQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:16:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:34434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271585AbTGQWPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:15:39 -0400
Date: Thu, 17 Jul 2003 15:28:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: asm (lidt) question
Message-Id: <20030717152819.66cfdbaf.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In arch/i386/kernel, inline asm for loading IDT (lidt) is used a few
times, but with slightly different constraints and output/input
definitions.  Are these OK, equivalent, or what?

[rddunlap@dragon kernel]$ findc lidt
./cpu/common.c:484: __asm__ __volatile__("lidt %0": "=m" (idt_descr));
./traps.c:783:	__asm__ __volatile__("lidt %0": "=m" (idt_descr));

vs.

./reboot.c:186:	__asm__ __volatile__ ("lidt %0" : : "m" (real_mode_idt));
./reboot.c:261:	__asm__ __volatile__("lidt %0": :"m" (no_idt));
./suspend.c:95:	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));


Thanks,
--
~Randy  [yes, i've looked at the inline asm docs]
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
