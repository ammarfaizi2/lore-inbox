Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbTDGDYf (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTDGDYe (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:24:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263217AbTDGDYZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:24:25 -0400
Message-ID: <33271.4.64.238.61.1049686559.squirrel@webmail.osdl.org>
Date: Sun, 6 Apr 2003 20:35:59 -0700 (PDT)
Subject: Re: Wanted: a limit on kernel log buffer size
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rddunlap@osdl.org>
In-Reply-To: <33182.4.64.238.61.1049683748.squirrel@webmail.osdl.org>
References: <200304062137_MC3-1-3346-A97E@compuserve.com>
        <33182.4.64.238.61.1049683748.squirrel@webmail.osdl.org>
X-Priority: 3
Importance: Normal
Cc: <76306.1226@compuserve.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  Some people (who will mercifully go unnamed) just will _not_
>> read the documentation, and set the kernel log buffer shift
>> to 31 on a 256MB machine.  This attempt to allocate 2GB of memory for the
>> buffer results in an unbootable kernel.
>>
>>  Suggestions?
>
> This is a multi-part answer.  Say, 5 parts.
>
> a.  If someone won't read the help text, how can we help them?
>
> b.  If we make a 2 GB log buffer size a compile-time error, will
> they read that?
>
> c.  If we make it a compile-time warning, will they read that?
>
> d.  What limit(s) do you suggest?  I can try to add some limits.
>
> e.  This kind of config limiting should be done in the config system IMO.
> I've asked Roman for that capability....


Here's a patch that limits kernel log buffer size to 1 MB max.
Comments?

I'm inserting it here via cut-and-paste, so it might not be all clean.
Patch is to 2.5.66-PV (plain vanilla).


patch_name:	logbuf-limit.patch
patch_version:	2003-04-06.20:28:43
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	limit kernel log buffer size to 1 MB
product:	Linux
product_versions: 2.5.66
diffstat:	=
 kernel/printk.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Naur ./kernel/printk.c%LBLIM ./kernel/printk.c
--- ./kernel/printk.c%LBLIM	2003-04-06 20:27:28.000000000 -0700
+++ ./kernel/printk.c	2003-04-06 20:27:53.000000000 -0700
@@ -34,6 +34,9 @@

 #define LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
+#if (CONFIG_LOG_BUF_SHIFT > 20)
+#error CONFIG_LOG_BUF_SHIFT is ridiculously large (more than 1 MB).
+#endif

 /* printk's without a loglevel use this.. */
 #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */




