Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVKOMvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVKOMvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVKOMvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:51:21 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:56821 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932459AbVKOMvU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:51:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W/7ppvSOt/ALtkSGw51ita6VorYTju8y4TZqcWsiOt2ZD85IbSoqri+tdPrzkqvp4pAqf7WTcwIRsQXCGBEJCY8UcunnPoPBnoGcXeCFhWekNYQavVaHu5UUvu98hXo6JP3jByu7Dx1pccif73T+mATq3v3DPj3vG841MZZvys4=
Message-ID: <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
Date: Tue, 15 Nov 2005 14:51:16 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Subject: Re: Linuv 2.6.15-rc1
Cc: Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
In-Reply-To: <20051115115657.GA30489@gemtek.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org>
	 <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zilvinas,

On 11/15/05, Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
> Eventually kernel will freeze (I can trigger this reliably, tried 3
> times and it "worked" 3 times as well). Although I've seen no error message
> printed to console - sysrq-T always shows the same stack trace (in
> wpa_supplicant context:

[snip]

> http://www.gemtek.lt/~zilvinas/backtrace.jpg

Would be helpful to see the oops message... If you don't have serial
console handy, you can do the below to disable the call trace.

                         Pekka

Index: 2.6/arch/i386/kernel/traps.c
===================================================================
--- 2.6.orig/arch/i386/kernel/traps.c
+++ 2.6/arch/i386/kernel/traps.c
@@ -185,8 +185,10 @@ void show_stack(struct task_struct *task
 			printk("\n       ");
 		printk("%08lx ", *stack++);
 	}
+#if 0
 	printk("\nCall Trace:\n");
 	show_trace(task, esp);
+#endif
 }

 /*
