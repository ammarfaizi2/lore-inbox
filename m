Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUJ3VO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUJ3VO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUJ3VO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:14:56 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:10099 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261324AbUJ3VOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:14:50 -0400
Date: Sun, 31 Oct 2004 01:15:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2.6.10-rc1] Include useful absolute symbols in kallsyms
Message-ID: <20041030231538.GD9592@mars.ravnborg.org>
Mail-Followup-To: Keith Owens <kaos@sgi.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <19397.1099042621@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19397.1099042621@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 07:37:01PM +1000, Keith Owens wrote:
> Some absolute symbols are useful, they can even appear in back traces.
> Tweak kallsyms to retain the useful absolute symbols.
> 
> Signed-off-by: Keith Owens <kaos@sgi.com>
> 
> ---
> 
> This list is from ia64, add absolute symbols from other architectures
> as required.

I've applied the following patch (clash with some arm changes):
===== scripts/kallsyms.c 1.14 vs edited =====
--- 1.14/scripts/kallsyms.c	2004-10-08 17:34:20 +02:00
+++ edited/scripts/kallsyms.c	2004-10-31 01:12:45 +02:00
@@ -132,7 +132,17 @@
 		_sinittext = s->addr;
 	else if (strcmp(str, "_einittext") == 0)
 		_einittext = s->addr;
-	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U' ||
+	else if (toupper(s->type) == 'A')
+	{
+		/* Keep these useful absolute symbols */
+		if (strcmp(str, "__kernel_syscall_via_break") &&
+		    strcmp(str, "__kernel_syscall_via_epc") &&
+		    strcmp(str, "__kernel_sigtramp") &&
+		    strcmp(str, "__gp"))
+			return -1;
+
+	}
+	else if (toupper(s->type) == 'U' ||
 		 is_arm_mapping_symbol(str))
 		return -1;
 

