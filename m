Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUDYORi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUDYORi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 10:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUDYORh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 10:17:37 -0400
Received: from corpeumxic1.corp.emc.com ([152.62.121.25]:2571 "EHLO
	corpeumxic1.corp.emc.com") by vger.kernel.org with ESMTP
	id S262476AbUDYORf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 10:17:35 -0400
Message-ID: <206992158A64DC41A6CFBC58327CE94C1F6604@inba1mx1.corp.emc.com>
From: Swamy_Gautham@emc.com
To: linux-kernel@vger.kernel.org
Subject: Help in debugging Memory corruption issue on Hugemem kernel
Date: Sun, 25 Apr 2004 15:17:26 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me when replying, thanks.

The issue is with a Multipathing driver on RH-AS-3.0
(2.4.21-9.0.1.ELhugemem) kernel.
The driver is corrupting memory which leads to a panic at a later point in
time when a "tar" or "cp" command is run. This happens only on hugemem
kernels and not on SMP kernels.

Happens only with machines that have at least 6GB of physical memory.

Here is a panic stack trace.

****************************************************************************
********************************************************
invalid operand: 0000

CPU: 0
EIP: 0060:[<02155c9d>] Tainted: P 
EFLAGS: 00010006

EIP is at rmqueue [kernel] 0x1fd (2.4.21-9.0.1.ELhugemem/i686)
eax: 00000000 ebx: 00000020 ecx: 000f6000 edx: 001797e0
esi: 023a2514 edi: 023a1300 ebp: 088798ac esp: ea2b9e74
ds: 0068 es: 0068 ss: 0068
Process tar (pid: 24913, stackpage=ea2b9000)
Stack: e8a7a740 06d280a8 000f6000 0213e921 00000005 000837e0 00083400
00000202 
00000000 023a1300 023a2624 00000000 000001d2 00000000 02155ff7 00000000 
00000fff ea86b200 00000000 f5300fff ea2b9f24 00000001 0215f03b f5301000 
Call Trace: [<0213e921>] follow_page [kernel] 0x1b1 (0xea2b9e80)
[<02155ff7>] __alloc_pages [kernel] 0x97 (0xea2b9eac)
[<0215f03b>] get_user_size [kernel] 0x4b (0xea2b9ecc)
[<021492e8>] do_generic_file_write [kernel] 0x168 (0xea2b9ef0)
[<021498ef>] generic_file_write [kernel] 0x13f (0xea2b9f48)
[<0213402b>] update_process_times_statistical [kernel] 0x7b (0xea2b9f5c)
[<f88bce89>] ext3_file_write [ext3] 0x39 (0xea2b9f74)
[<02161523>] sys_write [kernel] 0xa3 (0xea2b9f94)

Code: Bad EIP value.

CPU#3 is frozen.
CPU#1 is frozen.
****************************************************************************
*************************************************************

Any ideas as to how to debug this memory corruption issue ?

I have turned on "Debug High Memory Support" and "Debug Memory allocations"
via kdb, I do not know how to use this feature. Has anyone used this
debugging support.

Thanks 
Gautham

