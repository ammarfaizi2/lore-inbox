Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUF2VsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUF2VsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266088AbUF2VsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:48:06 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:35115 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S266085AbUF2VsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:48:02 -0400
Message-ID: <40E1E37C.4030603@travellingkiwi.com>
Date: Tue, 29 Jun 2004 22:47:40 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm4 compile buglet
References: <40E1DCD0.7090604@travellingkiwi.com> <20040629142929.14e1b746.akpm@osdl.org>
In-Reply-To: <20040629142929.14e1b746.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hamie <hamish@travellingkiwi.com> wrote:
>  
>
>>drivers/built-in.o(.init.text+0x90ed): In function `do_wrlvtpc':
>>: undefined reference to `apic_write'
>>    
>>
>
>You'll need to disable CONFIG_PERFCTR or apply the below patch.
>
>
>
>
>--- linux-2.6.7-mm4/drivers/perfctr/x86_tests.c.~1~	2004-06-29 12:43:27.000000000 +0200
>+++ linux-2.6.7-mm4/drivers/perfctr/x86_tests.c	2004-06-29 13:26:26.000000000 +0200
>@@ -44,6 +44,11 @@
> #define CR4MOV	"movl"
> #endif
> 
>+#ifndef PERFCTR_INTERRUPT_SUPPORT
>+#undef apic_write
>+#define apic_write(reg,vector)			do{}while(0)
>+#endif
>+
> static void __init do_rdpmc(unsigned pmc, unsigned unused2)
> {
> 	unsigned i;
>  
>
Ah right... I didn't trace it back to what was calling it sorry, or else 
I might (maybe... honest) have realised that.

TIA
Hamish.

