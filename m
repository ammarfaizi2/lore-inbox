Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWF1QyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWF1QyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWF1QyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:54:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29444 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751420AbWF1QyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:19 -0400
Date: Wed, 28 Jun 2006 18:54:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: [-mm patch] include/asm-i386/acpi.h should #include <asm/processor.h>
Message-ID: <20060628165418.GJ13915@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm1:
>...
> +cpu_relax-use-in-acpi-lock.patch
>...
>  ACPI stuff
>...

This patch fixes the following issue:

<--  snip  -->

...
  CC      arch/i386/mach-visws/mpparse.o
In file included from include/asm/fixmap.h:26,
                 from include/asm/smp.h:15,
                 from arch/i386/mach-visws/mpparse.c:6:
include/asm/acpi.h: In function ‘__acpi_acquire_global_lock’:
include/asm/acpi.h:70: warning: implicit declaration of function ‘cpu_relax’
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm2/include/asm-i386/acpi.h.old	2006-06-26 23:00:40.000000000 +0200
+++ linux-2.6.17-mm2/include/asm-i386/acpi.h	2006-06-26 23:01:04.000000000 +0200
@@ -31,6 +31,7 @@
 #include <acpi/pdc_intel.h>
 
 #include <asm/system.h>		/* defines cmpxchg */
+#include <asm/processor.h>
 
 #define COMPILER_DEPENDENT_INT64   long long
 #define COMPILER_DEPENDENT_UINT64  unsigned long long
