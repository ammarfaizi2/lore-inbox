Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292688AbSCET4r>; Tue, 5 Mar 2002 14:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310183AbSCET4h>; Tue, 5 Mar 2002 14:56:37 -0500
Received: from mms1.broadcom.com ([63.70.210.58]:45828 "HELO mms1.broadcom.com")
	by vger.kernel.org with SMTP id <S292688AbSCET42>;
	Tue, 5 Mar 2002 14:56:28 -0500
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Message-ID: <3C8522EA.2A00E880@broadcom.com>
Date: Tue, 05 Mar 2002 11:56:26 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
cc: linux-mips@sgi.com, kwalker@broadcom.com
Subject: init_idle reaped before final call
X-WSS-ID: 109BFD5C2689615-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working with a (approximately) 2.4.17 kernel from the mips-linux
tree (oss.sgi.com).

I'd like to propose removing the "__init" designation from init_idle in
kernel/sched.c, since this is called from rest_init via cpu_idle. 
Notice that rest_init isn't in an init section, and explicitly mentions
that it's avoiding a race with free_initmem.  In my kernel (an SMP
kernel running on a system with only 1 available CPU), cpu_idle isn't
getting called until after free_initmem().

My CPU is MIPS, but it looks like x86 could experience the same problem.

Kip

Index: kernel/sched.c
===================================================================
RCS file:
/projects/bbp/cvsroot/systemsw/linux/src/kernel/kernel/sched.c,v
retrieving revision 1.10
diff -u -r1.10 sched.c
--- kernel/sched.c      2002/01/15 04:13:43     1.10
+++ kernel/sched.c      2002/03/05 19:40:14
@@ -1304,7 +1304,7 @@
 
 extern unsigned long wait_init_idle;
 
-void __init init_idle(void)
+void init_idle(void)
 {
        struct schedule_data * sched_data;
        sched_data = &aligned_data[smp_processor_id()].schedule_data;

