Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271619AbTGQXKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271625AbTGQXKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:10:30 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:11970 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S271619AbTGQXK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:10:29 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 17 Jul 2003 16:18:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: asm (lidt) question
In-Reply-To: <Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
 <Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, Davide Libenzi wrote:

> On Thu, 17 Jul 2003, Randy.Dunlap wrote:
>
> >
> > In arch/i386/kernel, inline asm for loading IDT (lidt) is used a few
> > times, but with slightly different constraints and output/input
> > definitions.  Are these OK, equivalent, or what?
> >
> > [rddunlap@dragon kernel]$ findc lidt
> > ./cpu/common.c:484: __asm__ __volatile__("lidt %0": "=m" (idt_descr));
> > ./traps.c:783:	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
> >
> > vs.
> >
> > ./reboot.c:186:	__asm__ __volatile__ ("lidt %0" : : "m" (real_mode_idt));
> > ./reboot.c:261:	__asm__ __volatile__("lidt %0": :"m" (no_idt));
> > ./suspend.c:95:	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));
>
> I'd have said no looking at the syntax (input/output), but they indeed
> generate the same code (just checked).

Randy, I'd say that this :

__asm__ __volatile__("lidt %0": "=m" (var));

is better then :

__asm__ __volatile__("lidt %0": :"m" (var));

IMHO, since "var" is really an output parameter.



- Davide

