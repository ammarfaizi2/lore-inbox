Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271618AbTGQXSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271622AbTGQXSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:18:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:29095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271618AbTGQXSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:18:23 -0400
Date: Thu, 17 Jul 2003 16:31:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: asm (lidt) question
Message-Id: <20030717163103.40d4c96e.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
	<Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
	<Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 16:18:06 -0700 (PDT) Davide Libenzi <davidel@xmailserver.org> wrote:

| On Thu, 17 Jul 2003, Davide Libenzi wrote:
| 
| > On Thu, 17 Jul 2003, Randy.Dunlap wrote:
| >
| > >
| > > In arch/i386/kernel, inline asm for loading IDT (lidt) is used a few
| > > times, but with slightly different constraints and output/input
| > > definitions.  Are these OK, equivalent, or what?
| > >
| > > [rddunlap@dragon kernel]$ findc lidt
| > > ./cpu/common.c:484: __asm__ __volatile__("lidt %0": "=m" (idt_descr));
| > > ./traps.c:783:	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
| > >
| > > vs.
| > >
| > > ./reboot.c:186:	__asm__ __volatile__ ("lidt %0" : : "m" (real_mode_idt));
| > > ./reboot.c:261:	__asm__ __volatile__("lidt %0": :"m" (no_idt));
| > > ./suspend.c:95:	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));
| >
| > I'd have said no looking at the syntax (input/output), but they indeed
| > generate the same code (just checked).
| 
| Randy, I'd say that this :
| 
| __asm__ __volatile__("lidt %0": "=m" (var));
| 
| is better then :
| 
| __asm__ __volatile__("lidt %0": :"m" (var));
| 
| IMHO, since "var" is really an output parameter.

Yes, I agree, var is output and should be listed after the first ':'
IMHO also.

Thanks for checking that they generate the same code, though.

I'll buy you a beer...  No, wait, I already did that.  :)

--
~Randy
