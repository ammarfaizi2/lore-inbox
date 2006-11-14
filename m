Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965920AbWKNPXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965920AbWKNPXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 10:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965925AbWKNPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 10:23:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:56458 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965920AbWKNPXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 10:23:12 -0500
Date: Tue, 14 Nov 2006 09:23:07 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Bill O'Donnell" <billodo@sgi.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Chris Friedhoff <chris@friedhoff.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061114152307.GA7534@sergelap.austin.ibm.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061109061021.GA32696@sergelap.austin.ibm.com> <20061109103349.e58e8f51.chris@friedhoff.org> <20061113215706.GA9658@sgi.com> <20061114052531.GA20915@sergelap.austin.ibm.com> <20061114135546.GA9953@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114135546.GA9953@sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bill O'Donnell (billodo@sgi.com):
> 8102  execve("/sbin/setfcaps", ["setfcaps", "cap_net_raw=ep", "/bin/ping"], [/* 67 vars */]) = 0
> 8102  brk(0)                            = 0x6000000000004000
> 8102  uname({sys="Linux", node="certify", ...}) = 0
> 8102  access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
> 8102  open("/etc/ld.so.cache", O_RDONLY) = 3
> 8102  fstat(3, {st_mode=S_IFREG|0644, st_size=111415, ...}) = 0
> 8102  mmap(NULL, 111415, PROT_READ, MAP_PRIVATE, 3, 0) = 0x200000000004c000
> 8102  close(3)                          = 0
> 8102  open("/lib/libcap.so.1", O_RDONLY) = 3
> 8102  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0\340\25"..., 832) = 832
> 8102  fstat(3, {st_mode=S_IFREG|0755, st_size=22672, ...}) = 0
> 8102  mmap(NULL, 85800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2000000000068000
> 8102  madvise(0x2000000000068000, 85800, MADV_SEQUENTIAL|0x1) = 0
> 8102  mprotect(0x2000000000070000, 49152, PROT_NONE) = 0
> 8102  mmap(0x200000000007c000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x200000000007c000
> 8102  close(3)                          = 0
> 8102  open("/lib/libc.so.6.1", O_RDONLY) = 3
> 8102  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0\3609\2"..., 832) = 832
> 8102  fstat(3, {st_mode=S_IFREG|0755, st_size=2590313, ...}) = 0
> 8102  mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000000080000
> 8102  mmap(NULL, 2416624, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2000000000084000
> 8102  madvise(0x2000000000084000, 2416624, MADV_SEQUENTIAL|0x1) = 0
> 8102  mprotect(0x20000000002bc000, 49152, PROT_NONE) = 0
> 8102  mmap(0x20000000002c8000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x234000) = 0x20000000002c8000
> 8102  mmap(0x20000000002d0000, 8176, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x20000000002d0000
> 8102  close(3)                          = 0
> 8102  mmap(NULL, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x20000000002d4000
> 8102  mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x20000000002dc000
> 8102  munmap(0x200000000004c000, 111415) = 0
> 8102  brk(0)                            = 0x6000000000004000
> 8102  brk(0x6000000000028000)           = 0x6000000000028000
> 8102  capget(0x19980330, 0, {0, 0, 0})  = -1 EINVAL (Invalid argument)

I don't see why this capget is returning -EINVAL.  In fact I don't see
why it happens at all - cap_inode_setxattr would check
capable(CAP_SYS_ADMIN), but setxattr hasn't been called yet.  Looking at
both libcap and setfcaps.c, I don't see where the capget comes from.

As for the -EINVAL, kernel/capability.c:sys_capget() returns -EINVAL if
the _LINUX_CAPABILITY_VERSION is wrong - you have 0x19980330 which is
correct - if pid < 0 - but you send in 0 - or if security_capget
returns -EINVAL, which cap_capget (and dummy_capget) don't do.

Kaigai, do you have any ideas?

thanks,
-serge
