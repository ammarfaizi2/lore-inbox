Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUHZDWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUHZDWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 23:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHZDWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 23:22:55 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:9106 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267380AbUHZDWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 23:22:53 -0400
Message-ID: <005401c48b1b$fae38890$6401a8c0@novustelecom.net>
From: "Zarakin" <zarakin@hotpop.com>
To: <linux-kernel@vger.kernel.org>
References: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net> <20040825160107.GA562@zaniah>
Subject: Re: nmi_watchdog=2 - Oops with 2.6.8
Date: Wed, 25 Aug 2004 20:22:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> try this patch please.
>
> --- linux-2.5/arch/i386/kernel/nmi.c~ 2004-06-15 10:52:00.000000000 +0200
> +++ linux-2.5/arch/i386/kernel/nmi.c 2004-08-25 17:33:45.000000000 +0200
> @@ -376,7 +376,13 @@
>   clear_msr_range(0x3F1, 2);
>   /* MSR 0x3F0 seems to have a default value of 0xFC00, but current
>      docs doesn't fully define it, so leave it alone for now. */
> - clear_msr_range(0x3A0, 31);
> + if (boot_cpu_data.x86_model >= 0x3) {
> + /* MSR_P4_IQ_ESCR0/1 (0x3ba/0x3bb) removed */
> + clear_msr_range(0x3A0, 26);
> + clear_msr_range(0x3BC, 3);
> + } else {
> + clear_msr_range(0x3A0, 31);
> + }
>   clear_msr_range(0x3C0, 6);
>   clear_msr_range(0x3C8, 6);
>   clear_msr_range(0x3E0, 2);

It worked, my machine boots now fine with nmi_watchdog=2.

I can also confirm that oprofile is broken due to the missing
MSR_P4_IQ_ESCR0/1:
http://marc.theaimsgroup.com/?l=oprofile-list&m=109323108114060&w=2


