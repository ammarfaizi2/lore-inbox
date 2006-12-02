Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWLBLIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWLBLIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162131AbWLBK7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:63718 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759456AbWLBK7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fLGQmeD3QIa0JvgIgBbsy8LDCP3YEfLD6KEJRO9ZfTa/zuK0y8NDMMa0UGEB+b6JYGLytVH35zn5/dq7FPEHQtjIeFoEsZ90GJbVZGxtl/9nV5mRbJmAojc4/1YG8iFaayyJm3I9Yrn9Z+zPAv0cI9CitBVgbg7qIKZdpWooYkk=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/26] Dynamic kernel command-line - alpha
Date: Sat, 2 Dec 2006 12:48:54 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021248.55310.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/alpha/kernel/setup.c linux-2.6.19/arch/alpha/kernel/setup.c
--- linux-2.6.19.org/arch/alpha/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/alpha/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -122,7 +122,7 @@ static void get_sysnames(unsigned long, 
 			 char **, char **);
 static void determine_cpu_caches (unsigned int);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * The format of "screen_info" is strange, and due to early
@@ -547,7 +547,7 @@ setup_arch(char **cmdline_p)
 	} else {
 		strlcpy(command_line, COMMAND_LINE, sizeof command_line);
 	}
-	strcpy(saved_command_line, command_line);
+	strcpy(boot_command_line, command_line);
 	*cmdline_p = command_line;
 
 	/* 
@@ -589,7 +589,7 @@ setup_arch(char **cmdline_p)
 	}
 
 	/* Replace the command line, now that we've killed it with strsep.  */
-	strcpy(command_line, saved_command_line);
+	strcpy(command_line, boot_command_line);
 
 	/* If we want SRM console printk echoing early, do it now. */
 	if (alpha_using_srm && srmcons_output) {
