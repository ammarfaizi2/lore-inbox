Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSKVGOj>; Fri, 22 Nov 2002 01:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSKVGOj>; Fri, 22 Nov 2002 01:14:39 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:30705
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265736AbSKVGOi>; Fri, 22 Nov 2002 01:14:38 -0500
Date: Fri, 22 Nov 2002 01:15:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ian Morgan <imorgan@webcon.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: p4-clockmod doing the Right Thing[tm]?
In-Reply-To: <Pine.LNX.4.44.0211190948110.2942-100000@light.webcon.net>
Message-ID: <Pine.LNX.4.44.0211220113330.1639-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Ian Morgan wrote:

> # cat /proc/cpufreq
>           minimum CPU frequency  -  maximum CPU frequency  -  policy
> CPU  0     2405487 kHz ( 100 %)  -    2706165 kHz (112 %)  -  powersave

Can you try this patch?

Index: linux-2.4.20-rc1-ac4/arch/i386/kernel/p4-clockmod.c
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/arch/i386/kernel/p4-clockmod.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 p4-clockmod.c
--- linux-2.4.20-rc1-ac4/arch/i386/kernel/p4-clockmod.c	18 Nov 2002 01:39:49 -0000	1.1.1.1
+++ linux-2.4.20-rc1-ac4/arch/i386/kernel/p4-clockmod.c	22 Nov 2002 06:12:11 -0000
@@ -209,7 +209,7 @@
 	if (number_states)
 		return;
 
-	policy->max = (stock_freq / 8) * (((unsigned int) ((policy->max * 8) / stock_freq)) + 1);
+	policy->max = ((stock_freq / 8) * (((unsigned int) ((policy->max * 80) / stock_freq)))/10);
 	return;
 }
 

> On the other hand, some short (<1 min) cpu-bound processes for benchmarking
> each took the same amount of time to run when the clock was at 12%, 100%,
> and 112%, so I'm not sure the clock was really being changed at all.

I can look into that.

-- 
function.linuxpower.ca

