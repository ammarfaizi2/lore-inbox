Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287855AbSBCWsk>; Sun, 3 Feb 2002 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSBCWs3>; Sun, 3 Feb 2002 17:48:29 -0500
Received: from turing.cs.hmc.edu ([134.173.42.99]:8859 "EHLO turing.cs.hmc.edu")
	by vger.kernel.org with ESMTP id <S287855AbSBCWsQ>;
	Sun, 3 Feb 2002 17:48:16 -0500
Date: Sun, 3 Feb 2002 14:48:27 -0800 (PST)
From: Nathan Field <nathan@cs.hmc.edu>
To: <davej@suse.de>, <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [patch] kernel/ptrace.c, kernel 2.4.17 Fix for PTRACE_POKETEXT
Message-ID: <Pine.GSO.4.32.0202031437480.1115-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	When access_process_vm is used in kernel/ptrace.c to write memory
to a debugged we were not correctly incrementing an address used to handle
memory faults. This meant that in some cases modifying memory in a child
process of a fork modified the memory of the parent as well. This patch
applies to version 2.4.17.

--- ptrace.c.orig	Fri Feb  1 20:17:18 2002
+++ ptrace.c	Sat Feb  2 00:53:43 2002
@@ -173,6 +173,7 @@
 		put_page(page);
 		len -= bytes;
 		buf += bytes;
+		addr += bytes;
 	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);

