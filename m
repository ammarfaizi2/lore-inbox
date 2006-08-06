Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWHFUex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWHFUex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 16:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWHFUex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 16:34:53 -0400
Received: from xenotime.net ([66.160.160.81]:13191 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750707AbWHFUex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 16:34:53 -0400
Date: Sun, 6 Aug 2006 13:37:29 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][Doc] Fix kerneldoc comments in kernel/timer.c
Message-Id: <20060806133729.b389f1be.rdunlap@xenotime.net>
In-Reply-To: <200608011631.40189.eike-kernel@sf-tec.de>
References: <200608011631.40189.eike-kernel@sf-tec.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 16:31:39 +0200 Rolf Eike Beer wrote:

> Some of the kerneldoc comments in this file are ignored since the lead-in is
> malformed, using either "/*" or "/***" instead of "/**".
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

> @@ -401,7 +405,7 @@ static int cascade(tvec_base_t *base, tv
>  	return index;
>  }
>  
> -/***
> +/**
>   * __run_timers - run all expired timers (if any) on this CPU.
>   * @base: the timer vector to be processed.
>   *

Thanks for the patch, Eike.  I noticed that __run_timers needs
some help.  Patch below.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Fix function description + definition so that a #macro does
not come between them and interfere with the kernel-doc.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 kernel/timer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2618-rc3g2.orig/kernel/timer.c
+++ linux-2618-rc3g2/kernel/timer.c
@@ -405,6 +405,8 @@ static int cascade(tvec_base_t *base, tv
 	return index;
 }
 
+#define INDEX(N) ((base->timer_jiffies >> (TVR_BITS + (N) * TVN_BITS)) & TVN_MASK)
+
 /**
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
@@ -412,8 +414,6 @@ static int cascade(tvec_base_t *base, tv
  * This function cascades all vectors and executes all expired timer
  * vectors.
  */
-#define INDEX(N) ((base->timer_jiffies >> (TVR_BITS + (N) * TVN_BITS)) & TVN_MASK)
-
 static inline void __run_timers(tvec_base_t *base)
 {
 	struct timer_list *timer;
