Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTLVUzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 15:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTLVUzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 15:55:24 -0500
Received: from [141.154.95.10] ([141.154.95.10]:62424 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S264488AbTLVUzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 15:55:18 -0500
Subject: Re: atomic copy_from_user?
From: Rob Love <rml@ximian.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031222182637.GA2659@rudolph.ccur.com>
References: <1072054100.1742.156.camel@cube>
	 <20031222150026.GD27687@holomorphy.com>
	 <20031222182637.GA2659@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1072126506.3318.31.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 15:55:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 13:26, Joe Korty wrote:

> Shouldn't the dec_prempt_count() in kunmap_atomic() be followed
> by a preempt_check_resched()???

Probably.

Actually, dec_preempt_count() ought to call preempt_check_resched()
itself.  In the case of !CONFIG_PREEMPT, that call would simply optimize
away.

Attached patch is against 2.6.0.

	Rob Love


 linux/preempt.h |    1 +
 1 files changed, 1 insertion(+)

diff -urN include/linux/preempt.h.orig include/linux/preempt.h
--- include/linux/preempt.h.orig	2003-12-22 15:53:11.329113296 -0500
+++ include/linux/preempt.h	2003-12-22 15:53:51.314034664 -0500
@@ -18,6 +18,7 @@
 #define dec_preempt_count() \
 do { \
 	preempt_count()--; \
+	preempt_check_resched(); \
 } while (0)
 
 #ifdef CONFIG_PREEMPT


