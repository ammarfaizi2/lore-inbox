Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVLOXQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVLOXQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 18:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVLOXQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 18:16:28 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:14560 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751125AbVLOXQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 18:16:27 -0500
Date: Thu, 15 Dec 2005 15:15:10 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: William Cohen <wcohen@nc.rr.com>
Cc: William Cohen <wcohen@redhat.com>, perfctr-devel@lists.sourceforge.net,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] 2.6.15-rc5-git3 perfmon2 new code base + libpfm available
Message-ID: <20051215231510.GC18796@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051215104604.GA16937@frankl.hpl.hp.com> <43A1DE94.8050105@redhat.com> <20051215215921.GJ18331@frankl.hpl.hp.com> <43A1ECDF.9040200@nc.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <43A1ECDF.9040200@nc.rr.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Will,

Ok, I found the two bugs you ran into. I also found
a third one somewhat similar.

Could you try the attached patch on top of what
you have?

I will check all the copy_from/to() tomorrow.

Thanks.

On Thu, Dec 15, 2005 at 05:23:27PM -0500, William Cohen wrote:
> >>>I have released a new version of the perfmon base package.
> >>>This release is relative to 2.6.15-rc5-git3.
> >>>
> >>>I have also updated the library, libpfm-3.2, to match the kernel
> >>>level changes. 
> >>
> >>I downloaded the new version of perfmon and the matching libpfm. I built 
> >>everything on a p6 based machine. The kernel booted fine. I tried the 
> >>task_smpl_user in the libpfm examples. That crashed the kernel. What was 
> >>on the xterm:
> >>
> >>$ ./task_smpl_user ls
> >>measuring at plm=0x8
> >>programming 2 PMCS and 2 PMDS
> >>Segmentation fault
> >>
> >
> >I have not tried this particular test program in a long time. I nfact, I 
> >would
> >like to remove it from the suite because it does not make any real sense.
> >In any case, it should not crash the kernel. I will investigate this.
> >I don't think it it related to you using a P6. This is more the case of
> >an error in the cleanup code in case the context cannot be created 
> >properly.
> 
> If it just seg faulted the user space program I wouldn't care either, 
> but when it crashed the kernel I thought that you might like to know 
> about that.
> 
> >Does task_smpl work properly?
> 
> task_smpl gave data, but appeared to get a kernel oops. Output from xterm:
> 
> Dec 15 17:13:00 trek kernel: perfmon_p6: family=6 x86_model=8
> Dec 15 17:13:00 trek kernel: P6 core PMU detected
> Dec 15 17:13:00 trek kernel: perfmon: Intel P6 Family Processor PMU 
> detected, 2 PMCs, 2 PMDs, 2 counters (31 bits) RW_max:2
> Dec 15 17:13:00 trek kernel: Intel P6 Family Processor PMU installed
> Dec 15 17:13:22 trek kernel: Debug: sleeping function called from 
> invalid context at arch/i386/lib/usercopy.c:607
> Dec 15 17:13:22 trek kernel: in_atomic():0, irqs_disabled():1
> Dec 15 17:13:22 trek kernel:  [<c020e4e3>] copy_to_user+0x23/0x90
> Dec 15 17:13:22 trek kernel:  [<c0205129>] pfm_read+0xa9/0x320
> Dec 15 17:13:22 trek kernel:  [<c0121180>] default_wake_function+0x0/0x10
> Dec 15 17:13:22 trek kernel:  [<c0205080>] pfm_read+0x0/0x320
> Dec 15 17:13:22 trek kernel:  [<c01713e8>] vfs_read+0xb8/0x170
> Dec 15 17:13:22 trek kernel:  [<c0171771>] sys_read+0x41/0x70
> Dec 15 17:13:22 trek kernel:  [<c010569d>] syscall_call+0x7/0xb
> Dec 15 17:13:22 trek kernel: Unable to handle kernel paging request at 
>
> Dec 15 17:13:22 trek kernel: EIP is at pfm_smpl_fmt_put+0x11/0x60
> Dec 15 17:13:22 trek kernel: eax: d61afab0   ebx: 6b6b6b6b   ecx: 
> d8b3d7a0   edx: d8b3d900
> Dec 15 17:13:22 trek kernel: esi: d1852000   edi: 00000001   ebp: 
> 00000001   esp: d1f37ee0
> Dec 15 17:13:22 trek kernel: ds: 007b   es: 007b   ss: 0068
> Dec 15 17:13:22 trek kernel: Process task_smpl (pid: 2799, 
> threadinfo=d1f37000 task=d61afab0)
> Dec 15 17:13:22 trek kernel: Stack: 00000001 c0205803 c0156569 6b000246 
> c13163a4 d1f935a0 d1f93614 d22ebb78
> Dec 15 17:13:22 trek kernel:        00000286 00000000 00000010 00000010 
> d1f93614 d1f57d3c d22ebb78 c0172475
> Dec 15 17:13:22 trek kernel:        00000000 d1f935a0 d7f8fb68 d1f57d3c 
> d1e1011c d2789bcc d7e45dbc 00000001
> Dec 15 17:13:22 trek kernel: Call Trace:
> Dec 15 17:13:22 trek kernel:  [<c0205803>] pfm_close+0x113/0x3d0
> Dec 15 17:13:22 trek kernel:  [<c0156569>] poison_obj+0x29/0x60
> Dec 15 17:13:22 trek kernel:  [<c0172475>] __fput+0xb5/0x1a0
> Dec 15 17:13:22 trek kernel:  [<c01625e9>] remove_vma+0x39/0x50
> Dec 15 17:13:22 trek kernel:  [<c016477b>] exit_mmap+0xab/0x100
> Dec 15 17:13:22 trek kernel:  [<c0123423>] mmput+0x33/0xa0
> Dec 15 17:13:22 trek kernel:  [<c0128816>] do_exit+0xf6/0x3d0
> Dec 15 17:13:22 trek kernel:  [<c0109da8>] do_syscall_trace+0x218/0x22a
> Dec 15 17:13:22 trek kernel:  [<c0128b67>] do_group_exit+0x37/0xa0
> Dec 15 17:13:22 trek kernel:  [<c010569d>] syscall_call+0x7/0xb

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="perfmon-2.6.15-rc5-git3-will.diff"

diff -ur /tmp/linux-2.6.15-rc5-git3.orig/perfmon/perfmon_file.c linux-2.6.15-rc5-git3/perfmon/perfmon_file.c
--- /tmp/linux-2.6.15-rc5-git3.orig/perfmon/perfmon_file.c	2005-12-15 15:10:36.000000000 -0800
+++ linux-2.6.15-rc5-git3/perfmon/perfmon_file.c	2005-12-15 15:06:54.000000000 -0800
@@ -247,7 +247,7 @@
 			loff_t *ppos)
 {
 	struct pfm_context *ctx;
-	pfm_msg_t *msg;
+	pfm_msg_t *msg, msg_buf;
 	ssize_t ret;
 	unsigned long flags;
   	DECLARE_WAITQUEUE(wait, current);
@@ -274,6 +274,10 @@
 	if (size > sizeof(pfm_msg_t))
 		size = sizeof(pfm_msg_t);
 
+	/*
+	 * we must masks interrupts to avoid a race condition
+	 * with the PMU interrupt handler.
+	 */
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 
 	if(PFM_CTXQ_EMPTY(ctx) == 0)
@@ -348,17 +352,27 @@
 	if (unlikely(msg == NULL))
 		goto retry;
 
-	DPRINT(("type=%d size=%zu\n", msg->type, size));
+	/*
+	 * we must make a local copy before we unlock
+	 * to ensure that the message queue cannot fill
+	 * (overwriting our message) up before
+	 * we do copy_to_user() which cannot be done
+	 * with interrupts masked.
+	 */
+	msg_buf = *msg;
 
+	DPRINT(("type=%d size=%zu\n", msg->type, size));
 
 	/*
 	 * message can be truncated when size < sizeof(pfm_msg_t)
 	 * The leftover is systematically lost
 	 */
-	ret = -EFAULT;
-  	if(copy_to_user(buf, msg, size) == 0) ret = size;
 abort_locked:
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	ret = -EFAULT;
+  	if(copy_to_user(buf, &msg_buf, size) == 0)
+		ret = size;
 abort:
 	return ret;
 }
diff -ur /tmp/linux-2.6.15-rc5-git3.orig/perfmon/perfmon_fmt.c linux-2.6.15-rc5-git3/perfmon/perfmon_fmt.c
--- /tmp/linux-2.6.15-rc5-git3.orig/perfmon/perfmon_fmt.c	2005-12-15 15:10:36.000000000 -0800
+++ linux-2.6.15-rc5-git3/perfmon/perfmon_fmt.c	2005-12-15 15:04:38.000000000 -0800
@@ -67,7 +67,7 @@
 	if (fmt == NULL)
 		return;
 	spin_lock(&pfm_smpl_fmt_lock);
-	module_put(fmt->owner);
+	if (fmt->owner) module_put(fmt->owner);
 	spin_unlock(&pfm_smpl_fmt_lock);
 }
 
diff -ur /tmp/linux-2.6.15-rc5-git3.orig/perfmon/perfmon_pmu.c linux-2.6.15-rc5-git3/perfmon/perfmon_pmu.c
--- /tmp/linux-2.6.15-rc5-git3.orig/perfmon/perfmon_pmu.c	2005-12-15 15:10:36.000000000 -0800
+++ linux-2.6.15-rc5-git3/perfmon/perfmon_pmu.c	2005-12-15 15:06:34.000000000 -0800
@@ -286,7 +286,7 @@
 	if (pfm_pmu_conf == NULL)
 		return;
 	spin_lock(&pfm_pmu_conf_lock);
-	module_put(pfm_pmu_conf->owner);
+	if (pfm_pmu_conf->owner) module_put(pfm_pmu_conf->owner);
 	spin_unlock(&pfm_pmu_conf_lock);
 }
 

--envbJBWh7q8WU6mo--
