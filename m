Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTLWR4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTLWR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:56:30 -0500
Received: from CPE-24-163-213-80.mn.rr.com ([24.163.213.80]:14223 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S262063AbTLWR41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:56:27 -0500
Subject: reiser4 breaks vmware
From: Shawn <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1072202167.8127.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 11:56:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive my line-wraps, but the following (among other do_mmap_pgoff
related snippets) break vmware.

Couple questions out of this:
1. Does anyone care enough to produce a patch for vmware's module?
2. What does this change accomplish for reiser4?

diff -ruN linux-2.6.0-test9/arch/i386/kernel/sys_i386.c
linux-2.6.0-test9-reiser4/arch/i386/kernel/sys_i386.c 
--- linux-2.6.0-test9/arch/i386/kernel/sys_i386.c       Sat Oct 25
22:44:51 2003 
+++ linux-2.6.0-test9-reiser4/arch/i386/kernel/sys_i386.c       Thu Nov
13 15:39:47 2003 
@@ -56,7 +56,7 @@ 
        } 

        down_write(&current->mm->mmap_sem); 
-       error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff); 
+       error = do_mmap_pgoff(current->mm, file, addr, len, prot, flags,
pgoff); 
        up_write(&current->mm->mmap_sem); 

        if (file)
