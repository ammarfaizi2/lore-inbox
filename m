Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUHaIP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUHaIP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUHaIP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:15:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:37076 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267404AbUHaIPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:15:16 -0400
Date: Tue, 31 Aug 2004 01:13:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: eric.valette@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 : compilation error in kernel/wait.c
Message-Id: <20040831011310.27e4c221.akpm@osdl.org>
In-Reply-To: <41343136.6080208@free.fr>
References: <41343136.6080208@free.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette <eric.valette@free.fr> wrote:
>
> kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
>  include/linux/wait.h:143: error: previous declaration of '__wait_on_bit' 
>  was here
>  kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
>  include/linux/wait.h:143: error: previous declaration of '__wait_on_bit' 
>  was here
>  kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
>  include/linux/wait.h:144: error: previous declaration of 
>  '__wait_on_bit_lock' was here
>  kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
>  include/linux/wait.h:144: error: previous declaration of 
>  '__wait_on_bit_lock' was here

Try this:



diff -puN kernel/wait.c~__wait_on_bit-fix kernel/wait.c
--- linux-bix/kernel/wait.c~__wait_on_bit-fix	2004-08-31 01:11:02.279382800 -0700
+++ linux-bix-akpm/kernel/wait.c	2004-08-31 01:12:33.856460968 -0700
@@ -150,9 +150,9 @@ EXPORT_SYMBOL(wake_bit_function);
  * waiting, the actions of __wait_on_bit() and __wait_on_bit_lock() are
  * permitted return codes. Nonzero return codes halt waiting and return.
  */
-int __sched __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
-			void *word,
-			int bit, int (*action)(void *), unsigned mode)
+int __sched fastcall
+__wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
+		void *word, int bit, int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
 
@@ -164,9 +164,9 @@ int __sched __wait_on_bit(wait_queue_hea
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
-int __sched __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
-			void *word, int bit,
-			int (*action)(void *), unsigned mode)
+int __sched fastcall
+__wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
+		void *word, int bit, int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
 
_

