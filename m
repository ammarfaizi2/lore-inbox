Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWATQYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWATQYD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWATQYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:24:03 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:7098 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751051AbWATQYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:24:02 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Fri, 20 Jan 2006 17:23:18 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "David S.Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Iptables error [Was: 2.6.16-rc1-mm2]
In-reply-to: <20060120031555.7b6d65b7.akpm@osdl.org>
Message-Id: <20060120162317.5F70722B383@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>Changes since 2.6.16-rc1-mm1:
>
>
> linus.patch
Hello,

Commit 4f2d7680cb1ac5c5a70f3ba2447d5aa5c0a1643a (Linus' 2.6 git tree) breaks my
iptables (1.3.4):
# iptables -L
execve("/sbin/iptables", ["iptables", "-L"], [/* 24 vars */]) = 0
brk(0)                                  = 0x8056000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fdb000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=71332, ...}) = 0
old_mmap(NULL, 71332, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fc9000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\364\273"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=16164, ...}) = 0
old_mmap(0x4103b000, 12408, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4103b000
old_mmap(0x4103d000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x4103d000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0|\236\360"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1432592, ...}) = 0
old_mmap(0x4fef5000, 1162204, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4fef5000
old_mmap(0x5000b000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x116000) = 0x5000b000
old_mmap(0x5000f000, 7132, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x5000f000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fc8000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7fc86c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0x4103d000, 4096, PROT_READ)   = 0
mprotect(0x5000b000, 8192, PROT_READ)   = 0
mprotect(0x4fef1000, 4096, PROT_READ)   = 0
munmap(0xb7fc9000, 71332)               = 0
socket(PF_INET, SOCK_RAW, IPPROTO_RAW)  = 3
getsockopt(3, SOL_IP, 0x40 /* IP_??? */, "filter\0\0\0\0\0\0l\216\4\10\364\317\0PL!\0\0\330\320\0"..., [84]) = 0
brk(0)                                  = 0x8056000
brk(0x8077000)                          = 0x8077000
getsockopt(3, SOL_IP, 0x41 /* IP_??? */, "filter\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., [656]) = 0
write(2, "ERROR: 0 not a valid target)\n", 29ERROR: 0 not a valid target)
) = 29
rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
gettid()                                = 3468
tgkill(3468, 3468, SIGABRT)             = 0
--- SIGABRT (Aborted) @ 0 (0) ---
+++ killed by SIGABRT +++

This is it:
[NETFILTER] x_tables: Make XT_ALIGN align as strictly as necessary.

Or else we break on ppc32 and other 32-bit platforms.

Based upon a patch from Harald Welte.

Signed-off-by: David S. Miller <davem@davemloft.net>
--- include/linux/netfilter/x_tables.h
+++ include/linux/netfilter/x_tables.h
@@ -19,7 +19,7 @@ struct xt_get_revision
/* For standard target */
#define XT_RETURN (-NF_REPEAT - 1)
-#define XT_ALIGN(s) (((s) + (__alignof__(void *)-1)) & ~(__alignof__(void *)-1))
+#define XT_ALIGN(s) (((s) + (__alignof__(u_int64_t)-1)) & ~(__alignof__(u_int64_t)-1))
/* Standard return verdict, or do jump. */
#define XT_STANDARD_TARGET ""

Is there more info needed? Did I miss something?

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
