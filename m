Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTLQLwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTLQLwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:52:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:27339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264410AbTLQLwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:52:18 -0500
Date: Wed, 17 Dec 2003 03:52:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test11-mm1
Message-Id: <20031217035246.32adbf87.akpm@osdl.org>
In-Reply-To: <20031217014350.028460b2.akpm@osdl.org>
References: <20031217014350.028460b2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test11/2.6.0-test11-mm1/
> 
> 
>  A fair number of new fixes

And new breakage too!


In file included from arch/i386/kernel/cpu/intel.c:14:
include/asm-i386/mach-default/mach_apic.h:8: error: syntax error before "target_cpus"
include/asm-i386/mach-default/mach_apic.h:9: warning: return type defaults to `int'


Fix:


diff -puN arch/i386/kernel/cpu/intel.c~cpu_sibling_map-fixes-fix arch/i386/kernel/cpu/intel.c
--- 25/arch/i386/kernel/cpu/intel.c~cpu_sibling_map-fixes-fix	2003-12-17 03:31:56.000000000 -0800
+++ 25-akpm/arch/i386/kernel/cpu/intel.c	2003-12-17 03:46:25.000000000 -0800
@@ -8,9 +8,11 @@
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
+#include <asm/mpspec.h>
+#include <asm/apic.h>
 
 #include "cpu.h"
-#include "mach_apic.h"
+#include <mach_apic.h>
 
 extern int trap_init_f00f_bug(void);
 

_

