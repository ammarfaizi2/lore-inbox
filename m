Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271080AbTHCNQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 09:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271177AbTHCNQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 09:16:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10983 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271080AbTHCNQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 09:16:36 -0400
Date: Sun, 3 Aug 2003 15:16:30 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.22-pre10: fix circular dependency
Message-ID: <20030803131630.GW16426@fs.tum.de>
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 01:19:11PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.22-pre9 to v2.4.22-pre10
> ============================================
>...
> Marc-Christian Petersen:
>...
>   o Fix irq handling of IO-APIC edge IRQs on UP
>...

This patch adds for no good reason two #include's to 
include/asm-i386/hw_irq.h resulting in a circular dependency between 
headers.

The patch below removes these #include's again.

I've tested the compilation with 2.4.22-pre10.

cu
Adrian

--- linux-2.4.22-pre10-full/include/asm-i386/hw_irq.h.old	2003-08-03 01:34:22.000000000 +0200
+++ linux-2.4.22-pre10-full/include/asm-i386/hw_irq.h	2003-08-03 01:34:57.000000000 +0200
@@ -13,10 +13,8 @@
  */
 
 #include <linux/config.h>
-#include <linux/smp_lock.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
-#include <asm/current.h>
 
 /*
  * IDT vectors usable for external interrupt sources start
