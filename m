Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVHUJRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVHUJRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVHUJRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:17:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45530 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750888AbVHUJRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:17:42 -0400
Date: Sun, 21 Aug 2005 02:16:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: tony.luck@intel.com, linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
Message-Id: <20050821021616.6bbf2a14.akpm@osdl.org>
In-Reply-To: <20050821021322.3986dd4a.akpm@osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
	<20050821021322.3986dd4a.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> How about we give each arch a printk_clock()?

Which might be as simple as this..


--- devel/kernel/printk.c~printk_clock	2005-08-21 02:14:05.000000000 -0700
+++ devel-akpm/kernel/printk.c	2005-08-21 02:15:14.000000000 -0700
@@ -488,6 +488,11 @@ static int __init printk_time_setup(char
 
 __setup("time", printk_time_setup);
 
+__attribute__((weak)) unsigned long long printk_clock(void)
+{
+	return sched_clock();
+}
+
 /*
  * This is printk.  It can be called from any context.  We want it to work.
  * 
@@ -558,7 +563,7 @@ asmlinkage int vprintk(const char *fmt, 
 					loglev_char = default_message_loglevel
 						+ '0';
 				}
-				t = sched_clock();
+				t = printk_clock();
 				nanosec_rem = do_div(t, 1000000000);
 				tlen = sprintf(tbuf,
 						"<%c>[%5lu.%06lu] ",
_

