Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUEFVNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUEFVNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUEFVNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:13:35 -0400
Received: from fmr04.intel.com ([143.183.121.6]:65245 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263037AbUEFVN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:13:27 -0400
Date: Thu, 6 May 2004 14:13:13 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: pj@sgi.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: cpumask cleanup patches dont build
Message-ID: <20040506141312.A14209@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

Appears that some changes are still missed.

i ran into sched.c the following seems to fix it 


---
 
 linux-2.6.6-rc3-mm2-root/kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
 
diff -puN kernel/sched.c~pj_cpus_complement kernel/sched.c
--- linux-2.6.6-rc3-mm2/kernel/sched.c~pj_cpus_complement       2004-05-06 14:03:14.853689716 -0700
+++ linux-2.6.6-rc3-mm2-root/kernel/sched.c     2004-05-06 14:09:40.786504501 -0700
@@ -3666,7 +3666,7 @@ static void migrate_all_tasks(int src_cp
                        dest_cpu = any_online_cpu(tsk->cpus_allowed);
                if (dest_cpu == NR_CPUS) {
                        cpus_clear(tsk->cpus_allowed);
-                       cpus_complement(tsk->cpus_allowed);
+                       cpus_complement(tsk->cpus_allowed, tsk->cpus_allowed);
                        dest_cpu = any_online_cpu(tsk->cpus_allowed);
  
                        /* Don't tell them about moving exiting tasks

