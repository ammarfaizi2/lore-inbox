Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281453AbRKMDEw>; Mon, 12 Nov 2001 22:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281465AbRKMDEn>; Mon, 12 Nov 2001 22:04:43 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:2289 "HELO
	pobox.com") by vger.kernel.org with SMTP id <S281466AbRKMDE0>;
	Mon, 12 Nov 2001 22:04:26 -0500
Subject: [PATCH] Re: 2.4.15-pre4 compile error
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Mon, 12 Nov 2001 19:05:00 -0800 (PST)
Cc: louisg00@bellsouth.net (Louis Garcia), linux-kernel@vger.kernel.org
In-Reply-To: <20011112173318.H32099@mikef-linux.matchmail.com> from "Mike Fedyk" at Nov 12, 2001 05:33:18 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011113030500.766F989A86@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch, (from RML) will fix it.
> 
> It's already been posted...
[snip]

FWIW, this is Linus' fix, turned into a patch...

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.4.15-pre4/arch/i386/kernel/setup.c linux-2.4.15-pre4-bkn1/arch/i386/kernel/setup.c
--- linux-2.4.15-pre4/arch/i386/kernel/setup.c	Mon Nov 12 12:39:56 2001
+++ linux-2.4.15-pre4-bkn1/arch/i386/kernel/setup.c	Mon Nov 12 13:04:24 2001
@@ -2788,7 +2788,7 @@
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos < NR_CPUS ? &cpu_data[*pos] : NULL;
+	return *pos < NR_CPUS ? cpu_data+*pos : NULL;
 }
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
diff -ruN linux-2.4.15-pre4/include/asm-i386/processor.h linux-2.4.15-pre4-bkn1/include/asm-i386/processor.h
--- linux-2.4.15-pre4/include/asm-i386/processor.h	Mon Nov 12 12:43:21 2001
+++ linux-2.4.15-pre4-bkn1/include/asm-i386/processor.h	Mon Nov 12 13:33:01 2001
@@ -76,7 +76,7 @@
 extern struct cpuinfo_x86 cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #else
-#define cpu_data &boot_cpu_data
+#define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
 #endif
 
