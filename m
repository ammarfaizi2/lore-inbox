Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUF1Ezh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUF1Ezh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 00:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUF1Ezh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 00:55:37 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:16513 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264002AbUF1Ezf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 00:55:35 -0400
Date: Mon, 28 Jun 2004 05:55:25 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: showing locked vms in /proc/pid/maps..
Message-ID: <Pine.LNX.4.58.0406280552110.29652@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wanted to know if my VMs were being locked correctly so I through
together this patch for /proc/pid/maps it overloads the read bit with a
capital R for read/locked and an l for non-read/locked..

I'm not sure if this or something like it could be included maybe I'd be
better off overloading the p/s bit with P/S .. or adding a locked field
(didn't like that idea as it might mess up the layout..)..

Dave.

--- ../linux-2.6.4/fs/proc/task_mmu.c	2004-03-15 14:16:06.000000000 +1100
+++ fs/proc/task_mmu.c	2004-06-28 14:45:10.000000000 +1000
@@ -94,7 +94,7 @@
 	seq_printf(m, "%08lx-%08lx %c%c%c%c %08lx %02x:%02x %lu %n",
 			map->vm_start,
 			map->vm_end,
-			flags & VM_READ ? 'r' : '-',
+			flags & VM_LOCKED ? (flags & VM_READ ? 'R' : 'l') : (flags & VM_READ ? 'r' : '-'),
 			flags & VM_WRITE ? 'w' : '-',
 			flags & VM_EXEC ? 'x' : '-',
 			flags & VM_MAYSHARE ? 's' : 'p',
