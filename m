Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUDOBxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 21:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUDOBxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 21:53:47 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:38076 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262873AbUDOBxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 21:53:44 -0400
Subject: Re: modules in 2.6 kernel - question for FAQ?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404142142.41137.arekm@pld-linux.org>
References: <200404142142.41137.arekm@pld-linux.org>
Content-Type: text/plain
Message-Id: <1081993968.17782.112.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 11:52:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 05:42, Arkadiusz Miskiewicz wrote:
> insmod: error inserting './Intel537.ko': -1 Invalid module format

They didn't use -fno-common.  The patch which adds in the warning got
lost a while back.

Here's a new one...
Rusty.

Name: Print Warning for Common Symbols
Status: Trivial

People still build modules wrong, particularly without -fno-common.
The resulting modules don't load, but we should at least warn about it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17714-linux-2.6.5-bk2/kernel/module.c .17714-linux-2.6.5-bk2.updated/kernel/module.c
--- .17714-linux-2.6.5-bk2/kernel/module.c	2004-04-15 09:24:16.000000000 +1000
+++ .17714-linux-2.6.5-bk2.updated/kernel/module.c	2004-04-15 10:32:39.000000000 +1000
@@ -1003,6 +1003,8 @@ static int simplify_symbols(Elf_Shdr *se
 			/* We compiled with -fno-common.  These are not
 			   supposed to happen.  */
 			DEBUGP("Common symbol: %s\n", strtab + sym[i].st_name);
+			printk("%s: please compile with -fno-common\n",
+			       mod->name);
 			ret = -ENOEXEC;
 			break;
 

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

