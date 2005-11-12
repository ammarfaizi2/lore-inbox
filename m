Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVKLUYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVKLUYK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVKLUYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:24:10 -0500
Received: from nexus1.tmp.com.br ([200.244.88.12]:25926 "EHLO nexus.tmp.com.br")
	by vger.kernel.org with ESMTP id S932501AbVKLUYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:24:09 -0500
Date: Sat, 12 Nov 2005 18:23:55 -0200
From: Durval Menezes <jm139@tmp.com.br>
To: linux-kernel@vger.kernel.org
Cc: Durval Menezes <jm139@tmp.com.br>
Subject: [2.6.13.4 patch] kernel/audit.c: changing audit loglevel
Message-ID: <20051112182355.A796@tmp.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

Here's a (very simple) patch to change the loglevel of messages
produced by the audit facility.

I was getting sick of the console polution the default loglevel
(KERNEL_WARN) was producing; I investigated and found out that 
kernel/audit.c simply wasn't setting the loglevel of most messages,
so they were getting tagged with the default (KERNEL_WARN) in
kernel/printk.c

I know I could have set the default console logging level to KERN_ERR
or lower, but it seems much more reasonable to set the audit loglevel
to KERN_NOTICE instead.

I'm submiting this in hope it could be useful to someone else.
Please Cc: any comments to me directly (durval AT tmp DOT com DOT br).

Best regards,
--
  Durval Menezes (durval AT tmp DOT com DOT br)

--- linux-2.6.13.4/kernel/audit.c.orig-20051111        2005-10-10 15:54:29.000000000 -0300
+++ linux-2.6.13.4-dm/kernel/audit.c      2005-11-12 16:43:39.000000000 -0200
@@ -673,7 +673,7 @@

        audit_get_stamp(ab->ctx, &t, &serial);

-       audit_log_format(ab, "audit(%lu.%03lu:%u): ",
+       audit_log_format(ab, KERN_NOTICE "audit(%lu.%03lu:%u): ",
                         t.tv_sec, t.tv_nsec/1000000, serial);  
        return ab;
 }

==Eof==
