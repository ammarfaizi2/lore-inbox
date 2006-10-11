Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030734AbWJKAjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030734AbWJKAjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 20:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030738AbWJKAjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 20:39:12 -0400
Received: from gw.goop.org ([64.81.55.164]:16809 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030734AbWJKAjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 20:39:11 -0400
Message-ID: <452C3D36.7020306@goop.org>
Date: Tue, 10 Oct 2006 17:39:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stas Sergeev <stsp@aknet.ru>, Zachary Amsden <zach@vmware.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH 2.6.19-rc1-mm1] espfix Use scaling addressing mode rather
 than shifting in PER_CPU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the x86 scaling addressing mode rather than shifting to
multiplying by 4 in PER_CPU().

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Stas Sergeev <stsp@aknet.ru>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@muc.de>

diff -r ea4549dd86a4 include/asm-i386/percpu.h
--- a/include/asm-i386/percpu.h	Tue Oct 10 16:36:02 2006 -0700
+++ b/include/asm-i386/percpu.h	Tue Oct 10 16:37:59 2006 -0700
@@ -19,8 +19,7 @@
  */
 #ifdef CONFIG_SMP
 #define PER_CPU(var, cpu) \
-	shll $2, cpu; \
-	movl __per_cpu_offset(cpu), cpu; \
+	movl __per_cpu_offset(,cpu,4), cpu;	\
 	addl $per_cpu__/**/var, cpu;
 #else /* ! SMP */
 #define PER_CPU(var, cpu) \


