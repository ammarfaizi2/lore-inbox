Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280991AbRKLUpt>; Mon, 12 Nov 2001 15:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280992AbRKLUpg>; Mon, 12 Nov 2001 15:45:36 -0500
Received: from zero.tech9.net ([209.61.188.187]:46866 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280991AbRKLUpD>;
	Mon, 12 Nov 2001 15:45:03 -0500
Subject: Re: 2.4.15-pre4 compile problem
From: Robert Love <rml@tech9.net>
To: slomosnail@gmx.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011112203335Z280980-17408+13686@vger.kernel.org>
In-Reply-To: <200111121939.fACJdX309798@danapple.com> 
	<20011112203335Z280980-17408+13686@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 12 Nov 2001 15:45:05 -0500
Message-Id: <1005597905.814.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-12 at 15:34, Slo Mo Snail wrote:
> I have exactly the same problem...
> Strange, that nobody else has reported it, yet ;)
> I use gcc-2.95.3 and binutils 2.11.92.0.7 on a LFS
> I'll send you my .config but I don't think it's a config-specific problem

The patch below will solve the problem ...

diff -u linux-2.4.15-pre4/include/asm-i386/processor.h linux/include/asm-i386/processor.h 
--- linux-2.4.15-pre4/include/asm-i386/processor.h	Mon Nov 12 15:17:47 2001+++ linux/include/asm-i386/processor.h	Mon Nov 12 15:40:32 2001
@@ -76,7 +76,7 @@
 extern struct cpuinfo_x86 cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #else
-#define cpu_data &boot_cpu_data
+#define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
 #endif
 
	Robert Love

