Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUG0Xfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUG0Xfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266727AbUG0Xfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:35:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:18132 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266725AbUG0XfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:35:21 -0400
Message-ID: <4106A27C.3060306@austin.ibm.com>
Date: Tue, 27 Jul 2004 13:44:12 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux ppc64; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulus@samba.org, anton@samba.org, akpm@osdl.org
CC: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64 SMT bugfix
Content-Type: multipart/mixed;
 boundary="------------010602020806050208060703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010602020806050208060703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is fairly straightforward.  maxcpus should be per SMT thread 
and not per physical processor.  SUSE picked this up back in May (was 
discussed on ppc64 mailing list) and has had no trouble with it.


Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

--------------010602020806050208060703
Content-Type: text/plain;
 name="smtjul27.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smtjul27.patch"

diff -Nru a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	Tue Jul 27 13:44:45 2004
+++ b/arch/ppc64/kernel/smp.c	Tue Jul 27 13:44:45 2004
@@ -422,7 +422,11 @@
 	}
 
 	maxcpus = ireg[num_addr_cell + num_size_cell];
-	/* DRENG need to account for threads here too */
+
+	/* Double maxcpus for processors which have SMT capability */
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		maxcpus *= 2;
+
 
 	if (maxcpus > NR_CPUS) {
 		printk(KERN_WARNING

--------------010602020806050208060703--

