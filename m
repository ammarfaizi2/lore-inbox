Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWAPNmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWAPNmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAPNmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:42:04 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:32056 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750756AbWAPNmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:42:01 -0500
Date: Mon, 16 Jan 2006 22:42:04 +0900
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] changes about Call Trace:
Message-ID: <20060116134204.GC6707@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com> <200601161322.12209.ak@suse.de> <20060116134109.GA6707@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116134109.GA6707@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove symbolsize, and change offset format from hexadecimal to
decimal in print_symbol()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6-git/kernel/kallsyms.c.orig	2006-01-16 22:06:16.000000000 +0900
+++ 2.6-git/kernel/kallsyms.c	2006-01-16 22:09:52.000000000 +0900
@@ -237,7 +237,7 @@ int __print_symbol(const char *fmt, unsi
 	const char *name;
 	unsigned long offset, size;
 	char namebuf[KSYM_NAME_LEN+1];
-	char buffer[sizeof("%s+%#lx/%#lx [%s]") + KSYM_NAME_LEN +
+	char buffer[sizeof("%s+%ld [%s]") + KSYM_NAME_LEN +
 		    2*(BITS_PER_LONG*3/10) + MODULE_NAME_LEN + 1];
 
 	name = kallsyms_lookup(address, &size, &offset, &modname, namebuf);
@@ -246,10 +246,9 @@ int __print_symbol(const char *fmt, unsi
 		sprintf(buffer, "0x%lx", address);
 	else {
 		if (modname)
-			sprintf(buffer, "%s+%#lx/%#lx [%s]", name, offset,
-				size, modname);
+			sprintf(buffer, "%s+%ld [%s]", name, offset, modname);
 		else
-			sprintf(buffer, "%s+%#lx/%#lx", name, offset, size);
+			sprintf(buffer, "%s+%ld", name, offset);
 	}
 	return printk(fmt, buffer);
 }
