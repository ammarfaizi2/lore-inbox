Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUJXXBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUJXXBk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUJXXBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 19:01:40 -0400
Received: from nevyn.them.org ([66.93.172.17]:59853 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261611AbUJXXBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 19:01:38 -0400
Date: Sun, 24 Oct 2004 19:01:38 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Unwind information fix for the vsyscall DSO
Message-ID: <20041024230138.GA22543@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Roland McGrath <roland@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When working on GDB support I found a typo.  I assume the comment is
correct.  If you step to this particular instruction and backtrace, GDB gets
lost.

I haven't tested the fixed version yet, but I'm pretty confident in this
patch :-)  Please apply.

--- arch/i386/kernel/vsyscall-sysenter.S.orig	2004-04-05 21:21:20.000000000 -0400
+++ arch/i386/kernel/vsyscall-sysenter.S	2004-10-24 18:50:54.000000000 -0400
@@ -84,7 +84,7 @@
 	.byte 0x04		/* DW_CFA_advance_loc4 */
 	.long .Lpop_ebp-.Lenter_kernel
 	.byte 0x0e		/* DW_CFA_def_cfa_offset */
-	.byte 0x12		/* RA at offset 12 now */
+	.byte 0x0c		/* RA at offset 12 now */
 	.byte 0xc5		/* DW_CFA_restore %ebp */
 	.byte 0x04		/* DW_CFA_advance_loc4 */
 	.long .Lpop_edx-.Lpop_ebp


-- 
Daniel Jacobowitz
