Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUEEUmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUEEUmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbUEEUmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 16:42:16 -0400
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:41733 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S264670AbUEEUmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 16:42:15 -0400
Date: Wed, 5 May 2004 22:42:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv.local
To: Andries.Brouwer@cwi.nl
cc: akpm@osdl.org, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] report size of printk buffer
In-Reply-To: <UTC200405041609.i44G9CH29412.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0405052236110.766-100000@serv.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 May 2004 Andries.Brouwer@cwi.nl wrote:

> In the old days the printk log buffer had a constant size,
> and dmesg asked for the 4096, later 8192, later 16384 bytes in there.
> These days the printk log buffer has variable size, and it is not
> easy for dmesg to do the right thing, especially when doing a
> "read and clear".

Why don't you simply change it into "read and clear read data"?
E.g. something like below.

bye, Roman

Index: kernel/printk.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.6/kernel/printk.c,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 printk.c
--- a/kernel/printk.c	11 Mar 2004 18:34:55 -0000	1.1.1.6
+++ b/kernel/printk.c	5 May 2004 20:39:05 -0000
@@ -305,7 +305,7 @@ int do_syslog(int type, char __user * bu
 		if (count > logged_chars)
 			count = logged_chars;
 		if (do_clear)
-			logged_chars = 0;
+			logged_chars -= count;
 		limit = log_end;
 		/*
 		 * __put_user() could sleep, and while we sleep

