Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267719AbTBKMWw>; Tue, 11 Feb 2003 07:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbTBKMWw>; Tue, 11 Feb 2003 07:22:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:21236 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267719AbTBKMWu>; Tue, 11 Feb 2003 07:22:50 -0500
Date: Tue, 11 Feb 2003 18:18:07 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [2.5.60] dcachebench sleeps
Message-ID: <20030211181807.A1261@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.5.60, dcachebench no more completes. All threads
go to sleep as below. Last time I tested was with an intermediated BK diff 
(diff-bk-030204-2.5.59) and it was working fine. 

I tried "./dcachebench -p 4 -b junk" on a 4-way SMP with pre-epmtion ON.

dcachebench is available at 
http://www-124.ibm.com/developerworks/opensource/linuxperf/dcachebench/dcachebench.html

dcachebench   S 00000082 2336648  1082    952  1083               (NOTLB)
Call Trace:
 [<c011f327>] sys_wait4+0x237/0x270
 [<c0118710>] default_wake_function+0x0/0x20
 [<c014ae31>] sys_llseek+0xb1/0xd0
 [<c0118710>] default_wake_function+0x0/0x20
 [<c010aa0f>] syscall_call+0x7/0xb

dcachebench   S 00000086 4500872  1083   1082          1084       (NOTLB)
Call Trace:
 [<c0128084>] sys_pause+0x14/0x20
 [<c010aa0f>] syscall_call+0x7/0xb

dcachebench   S 00000082 4286241224  1084   1082          1085  1083 (NOTLB)
Call Trace:
 [<c0114113>] smp_apic_timer_interrupt+0x113/0x140
 [<c0128084>] sys_pause+0x14/0x20
 [<c010aa0f>] syscall_call+0x7/0xb

dcachebench   S 00000086 4287956936  1085   1082          1086  1084 (NOTLB)
Call Trace:
 [<c0128084>] sys_pause+0x14/0x20
 [<c010aa0f>] syscall_call+0x7/0xb

dcachebench   S 00000086 4287513032  1086   1082                1085 (NOTLB)
Call Trace:
 [<c0128084>] sys_pause+0x14/0x20
 [<c010aa0f>] syscall_call+0x7/0xb


Regards,
Maneesh



-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
