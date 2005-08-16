Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVHPEjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVHPEjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVHPEjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:39:15 -0400
Received: from ozlabs.org ([203.10.76.45]:60614 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965098AbVHPEjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:39:14 -0400
Subject: Re: obsolete modparam change busted.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050813182748.GG26633@redhat.com>
References: <20050808184955.GA18779@redhat.com>
	 <1123560076.13481.37.camel@localhost.localdomain>
	 <20050813182748.GG26633@redhat.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 14:39:10 +1000
Message-Id: <1124167150.6292.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 14:27 -0400, Dave Jones wrote:
> We're now munching the end of the boot command line it seems.

Wow, if we had testcases in the kernel source, I would not have to keep
rewriting them (badly) every time I touched this code.

Throw away that stupid patch, apply this stupid patch.


Name: Ignore trailing whitespace on kernel parameters correctly: Fixed version
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Dave Jones says:

... if the modprobe.conf has trailing whitespace, modules fail to load
with the following helpful message..

	snd_intel8x0: Unknown parameter `'

Previous version truncated last argument.

Index: linux-2.6.13-rc6-git7-Module/kernel/params.c
===================================================================
--- linux-2.6.13-rc6-git7-Module.orig/kernel/params.c	2005-08-10 16:12:45.000000000 +1000
+++ linux-2.6.13-rc6-git7-Module/kernel/params.c	2005-08-16 14:31:16.000000000 +1000
@@ -80,8 +80,6 @@
 	int in_quote = 0, quoted = 0;
 	char *next;
 
-	/* Chew any extra spaces */
-	while (*args == ' ') args++;
 	if (*args == '"') {
 		args++;
 		in_quote = 1;
@@ -121,6 +119,9 @@
 		next = args + i + 1;
 	} else
 		next = args + i;
+
+	/* Chew up trailing spaces. */
+	while (*next == ' ') next++;
 	return next;
 }
 
@@ -134,6 +135,9 @@
 	char *param, *val;
 
 	DEBUGP("Parsing ARGS: %s\n", args);
+	
+	/* Chew leading spaces */
+	while (*args == ' ') args++;
 
 	while (*args) {
 		int ret;

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

