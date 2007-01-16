Return-Path: <linux-kernel-owner+w=401wt.eu-S1751828AbXAPQxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbXAPQxu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbXAPQxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:53:34 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:48043 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751700AbXAPQxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:53:21 -0500
Date: Tue, 16 Jan 2007 11:53:19 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] arch/i386/kernel/ptrace.c: trivial whitespace cleanup
Message-ID: <Pine.LNX.4.44L0.0701161152400.2276-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as838) makes some trivial whitespace fixes to the i386
ptrace.c file.  Along with some stylistic issues, an entire section of
code was indented by two extra spaces -- I blame it on stupid
automatic editor indentation!

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/arch/i386/kernel/ptrace.c
===================================================================
--- usb-2.6.orig/arch/i386/kernel/ptrace.c
+++ usb-2.6/arch/i386/kernel/ptrace.c
@@ -417,61 +417,61 @@ long arch_ptrace(struct task_struct *chi
 		   have to be selective about what portions we allow someone
 		   to modify. */
 
-		  ret = -EIO;
-		  if(addr >= (long) &dummy->u_debugreg[0] &&
-		     addr <= (long) &dummy->u_debugreg[7]){
-
-			  if(addr == (long) &dummy->u_debugreg[4]) break;
-			  if(addr == (long) &dummy->u_debugreg[5]) break;
-			  if(addr < (long) &dummy->u_debugreg[4] &&
-			     ((unsigned long) data) >= TASK_SIZE-3) break;
-			  
-			  /* Sanity-check data. Take one half-byte at once with
-			   * check = (val >> (16 + 4*i)) & 0xf. It contains the
-			   * R/Wi and LENi bits; bits 0 and 1 are R/Wi, and bits
-			   * 2 and 3 are LENi. Given a list of invalid values,
-			   * we do mask |= 1 << invalid_value, so that
-			   * (mask >> check) & 1 is a correct test for invalid
-			   * values.
-			   *
-			   * R/Wi contains the type of the breakpoint /
-			   * watchpoint, LENi contains the length of the watched
-			   * data in the watchpoint case.
-			   *
-			   * The invalid values are:
-			   * - LENi == 0x10 (undefined), so mask |= 0x0f00.
-			   * - R/Wi == 0x10 (break on I/O reads or writes), so
-			   *   mask |= 0x4444.
-			   * - R/Wi == 0x00 && LENi != 0x00, so we have mask |=
-			   *   0x1110.
-			   *
-			   * Finally, mask = 0x0f00 | 0x4444 | 0x1110 == 0x5f54.
-			   *
-			   * See the Intel Manual "System Programming Guide",
-			   * 15.2.4
-			   *
-			   * Note that LENi == 0x10 is defined on x86_64 in long
-			   * mode (i.e. even for 32-bit userspace software, but
-			   * 64-bit kernel), so the x86_64 mask value is 0x5454.
-			   * See the AMD manual no. 24593 (AMD64 System
-			   * Programming)*/
-
-			  if(addr == (long) &dummy->u_debugreg[7]) {
-				  data &= ~DR_CONTROL_RESERVED;
-				  for(i=0; i<4; i++)
-					  if ((0x5f54 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
-						  goto out_tsk;
-				  if (data)
-					  set_tsk_thread_flag(child, TIF_DEBUG);
-				  else
-					  clear_tsk_thread_flag(child, TIF_DEBUG);
-			  }
-			  addr -= (long) &dummy->u_debugreg;
-			  addr = addr >> 2;
-			  child->thread.debugreg[addr] = data;
-			  ret = 0;
-		  }
-		  break;
+		ret = -EIO;
+		if (addr >= (long) &dummy->u_debugreg[0] &&
+		    addr <= (long) &dummy->u_debugreg[7]) {
+
+			if (addr == (long) &dummy->u_debugreg[4]) break;
+			if (addr == (long) &dummy->u_debugreg[5]) break;
+			if (addr < (long) &dummy->u_debugreg[4] &&
+			    ((unsigned long) data) >= TASK_SIZE-3) break;
+
+			/* Sanity-check data. Take one half-byte at once with
+			 * check = (val >> (16 + 4*i)) & 0xf. It contains the
+			 * R/Wi and LENi bits; bits 0 and 1 are R/Wi, and bits
+			 * 2 and 3 are LENi. Given a list of invalid values,
+			 * we do mask |= 1 << invalid_value, so that
+			 * (mask >> check) & 1 is a correct test for invalid
+			 * values.
+			 *
+			 * R/Wi contains the type of the breakpoint /
+			 * watchpoint, LENi contains the length of the watched
+			 * data in the watchpoint case.
+			 *
+			 * The invalid values are:
+			 * - LENi == 0x10 (undefined), so mask |= 0x0f00.
+			 * - R/Wi == 0x10 (break on I/O reads or writes), so
+			 *   mask |= 0x4444.
+			 * - R/Wi == 0x00 && LENi != 0x00, so we have mask |=
+			 *   0x1110.
+			 *
+			 * Finally, mask = 0x0f00 | 0x4444 | 0x1110 == 0x5f54.
+			 *
+			 * See the Intel Manual "System Programming Guide",
+			 * 15.2.4
+			 *
+			 * Note that LENi == 0x10 is defined on x86_64 in long
+			 * mode (i.e. even for 32-bit userspace software, but
+			 * 64-bit kernel), so the x86_64 mask value is 0x5454.
+			 * See the AMD manual no. 24593 (AMD64 System
+			 * Programming) */
+
+			if (addr == (long) &dummy->u_debugreg[7]) {
+				data &= ~DR_CONTROL_RESERVED;
+				for (i = 0; i < 4; i++)
+					if ((0x5f54 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
+						goto out_tsk;
+				if (data)
+					set_tsk_thread_flag(child, TIF_DEBUG);
+				else
+					clear_tsk_thread_flag(child, TIF_DEBUG);
+			}
+			addr -= (long) &dummy->u_debugreg;
+			addr = addr >> 2;
+			child->thread.debugreg[addr] = data;
+			ret = 0;
+		}
+		break;
 
 	case PTRACE_SYSEMU: /* continue and stop at next syscall, which will not be executed */
 	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */

