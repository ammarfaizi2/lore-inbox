Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966808AbWKOMkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966808AbWKOMkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 07:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966805AbWKOMkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 07:40:40 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:9409 "HELO pxy2nd.nifty.com")
	by vger.kernel.org with SMTP id S966808AbWKOMkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 07:40:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=nifty.com;
  b=MoQsQHD1uxu/vu8wqILCvkqkQs3LhtjhAnfWgMFaK0JtMkU2eMHiOK5k9EfXX19jLz+PNwio20LjgVrgEqSWeg==  ;
Message-ID: <11129007.324261163594437361.komurojun-mbn@nifty.com>
Date: Wed, 15 Nov 2006 21:40:37 +0900 (JST)
From: Komuro <komurojun-mbn@nifty.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Use delayed disable mode of ioapic edge triggered interrupts
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Komuro <komurojun-mbn@nifty.com>, tglx@linutronix.de,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: @nifty Webmail 2.0
References: <m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	<1162985578.8335.12.camel@localhost.localdomain>
	<Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<7813413.118221162987983254.komurojun-mbn@nifty.com>
	<11940937.327381163162570124.komurojun-mbn@nifty.com>
	<Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	<m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
	<1163450677.7473.86.camel@earth>
	<m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
	<1163492040.28401.76.camel@earth>
	<Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried the Eric's patch instead of Ingo's
with 2.6.19-rc5.


The interrupt is generated properly.

Thanks!

Best Regards
Komuro


>
>Hopefully this is the trivial patch that solves the problem.
>
>Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
>diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
>index ad84bc2..3b7a63e 100644
>--- a/arch/i386/kernel/io_apic.c
>+++ b/arch/i386/kernel/io_apic.c
>@@ -1287,9 +1287,11 @@ static void ioapic_register_intr(int irq
> 			trigger == IOAPIC_LEVEL)
> 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> 					 handle_fasteoi_irq, "fasteoi");
>-	else
>+	else {
>+		irq_desc[irq].status |= IRQ_DELAYED_DISABLE;
> 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> 					 handle_edge_irq, "edge");
>+	}
> 	set_intr_gate(vector, interrupt[irq]);
> }
> 
>diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
>index 41bfc49..14654e6 100644
>--- a/arch/x86_64/kernel/io_apic.c
>+++ b/arch/x86_64/kernel/io_apic.c
>@@ -790,9 +790,11 @@ static void ioapic_register_intr(int irq
> 			trigger == IOAPIC_LEVEL)
> 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> 					      handle_fasteoi_irq, "fasteoi");
>-	else
>+	else {
>+		irq_desc[irq].status |= IRQ_DELAYED_DISABLE;
> 		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> 					      handle_edge_irq, "edge");
>+	}
> }
> 
> static void __init setup_IO_APIC_irqs(void)
>

