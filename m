Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUDAI0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUDAI0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:26:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:954 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262068AbUDAIZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:25:56 -0500
Date: Thu, 1 Apr 2004 00:25:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] multiple namespaces
Message-Id: <20040401002549.4e124592.akpm@osdl.org>
In-Reply-To: <1080800087.1490.14.camel@cube>
References: <1080800087.1490.14.camel@cube>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
>  This patch lets a task have access to multiple namespaces.
>  You can create extra namespaces with the included SUBST command.
>  Then, from the bash prompt, you can switch from one namespace
>  to another by typing commands like "C" or "D". The default
>  namespace is "C" for compatibility reasons.

Applied, thanks.   But you missed this bit:


 25-akpm/kernel/printk.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

diff -puN kernel/printk.c~a kernel/printk.c
--- 25/kernel/printk.c~a	2004-04-01 00:24:07.036691080 -0800
+++ 25-akpm/kernel/printk.c	2004-04-01 00:24:41.266487360 -0800
@@ -459,7 +459,7 @@ static void call_console_drivers(unsigne
 	_call_console_drivers(start_print, end, msg_level);
 }
 
-static void emit_log_char(char c)
+static void __emit_log_char(char c)
 {
 	LOG_BUF(log_end) = c;
 	log_end++;
@@ -471,6 +471,13 @@ static void emit_log_char(char c)
 		logged_chars++;
 }
 
+static void emit_log_char(char c)
+{
+	if (c == '\n')
+		__emit_log_char('\r');
+	__emit_log_char(c);
+}
+
 /*
  * This is printk.  It can be called from any context.  We want it to work.
  * 

_

