Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbTGTTBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267712AbTGTTBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:01:47 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:15885
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S267765AbTGTTBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:01:46 -0400
Subject: [PATCH] (resend) support for 900MHz Pentium M for
	speedstep-centrino.c
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       cpufreq list <cpufreq@www.linux.org.uk>
Content-Type: text/plain
Message-Id: <1058728605.5980.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 12:16:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 900MHz Pentium M has two spaces before the frequency:
"Intel(R) Pentium(R) M processor  900MHz"

This patch adds a 2nd CPU macro (_CPU) which also takes the
stringified speed so that extra spacing can be added.

	J

 i386/kernel/cpu/cpufreq/speedstep-centrino.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~centrino-900MHz
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
---
local-2.5/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~centrino-900MHz	2003-07-12 16:38:45.000000000 -0700
+++
local-2.5-jeremy/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2003-07-13 00:37:31.000000000 -0700
@@ -156,14 +156,15 @@ static struct cpufreq_frequency_table op
 };
 #undef OP
 
-#define CPU(max)	\
-	{ "Intel(R) Pentium(R) M processor " #max "MHz", (max)*1000, op_##max
}
+#define _CPU(max, name)	\
+	{ "Intel(R) Pentium(R) M processor " name "MHz", (max)*1000, op_##max
}
+#define CPU(max)	_CPU(max, #max)
 
 /* CPU models, their operating frequency range, and freq/voltage
    operating points */
 static const struct cpu_model models[] = 
 {
-	CPU( 900),
+       _CPU( 900, " 900"),
 	CPU(1100),
 	CPU(1200),
 	CPU(1300),

_


