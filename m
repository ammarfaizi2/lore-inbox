Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283190AbRLHRhb>; Sat, 8 Dec 2001 12:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283012AbRLHRhH>; Sat, 8 Dec 2001 12:37:07 -0500
Received: from colorfullife.com ([216.156.138.34]:32012 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S283009AbRLHRg6>;
	Sat, 8 Dec 2001 12:36:58 -0500
Message-ID: <000801c1800e$f25af7f0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
Date: Sat, 8 Dec 2001 18:36:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> x86_udelay_tsc wont have been set at that point so the main timer is still
> being used.

No. x86_udelay_tsc is initialized by time_init(), and time_init() is called before
smp_init(). The udelay implementation only multiplies with loops_per_jiffy,
therefore there is no oops on i386.

But could oops if the bios disables the TSC instruction - the first printk on
the secondary cpu happens before

     clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE)

--
    Manfred

