Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966206AbWKNRjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966206AbWKNRjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755464AbWKNRjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:39:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24483 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1755463AbWKNRjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:39:44 -0500
Date: Tue, 14 Nov 2006 11:40:30 -0600
From: "Bill O'Donnell" <billodo@sgi.com>
To: Chris Friedhoff <chris@friedhoff.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061114174030.GE9953@sgi.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061109061021.GA32696@sergelap.austin.ibm.com> <20061109103349.e58e8f51.chris@friedhoff.org> <20061113215706.GA9658@sgi.com> <20061114052531.GA20915@sergelap.austin.ibm.com> <20061114135546.GA9953@sgi.com> <20061114152307.GA7534@sergelap.austin.ibm.com> <20061114182818.b342e7aa.chris@friedhoff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114182818.b342e7aa.chris@friedhoff.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 06:28:18PM +0100, Chris Friedhoff wrote:
| Attached the trace of 
| $ su -c "strace -o /tmp/stracesetfcapsout -f setfcaps
| cap_net_raw=ep /bin/ping "
| Here its working.
| From where are the setfcaps/getfcaps tools? Bill, have you compiled
| them or are they from a package?

I compiled and installed them to /sbin (Kagai's userspace libcap tools), 
using his Makefile.



| 
| > $ uname -a
| > Linux certify 2.6.19-rc3 #3 SMP PREEMPT Mon Nov 13 14:40:54 CST 2006
| > ia64
| Its an 64 bit system, right? Which distro are you using?

Yes.  Its an Itanium based SGI Altix, with a SuSE SLES-10 distro.



Bill

| 
| 
| Chris
| 
| 
| On Tue, 14 Nov 2006 09:23:07 -0600
| "Serge E. Hallyn" <serue@us.ibm.com> wrote:
| 
| > Quoting Bill O'Donnell (billodo@sgi.com):
| > > 8102  execve("/sbin/setfcaps", ["setfcaps", "cap_net_raw=ep", "/bin/ping"], [/* 67 vars */]) = 0
| > > 8102  brk(0)                            = 0x6000000000004000
| > > 8102  uname({sys="Linux", node="certify", ...}) = 0
| > > 8102  access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
| > > 8102  open("/etc/ld.so.cache", O_RDONLY) = 3
| > > 8102  fstat(3, {st_mode=S_IFREG|0644, st_size=111415, ...}) = 0
| > > 8102  mmap(NULL, 111415, PROT_READ, MAP_PRIVATE, 3, 0) = 0x200000000004c000
| > > 8102  close(3)                          = 0
| > > 8102  open("/lib/libcap.so.1", O_RDONLY) = 3
| > > 8102  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0\340\25"..., 832) = 832
| > > 8102  fstat(3, {st_mode=S_IFREG|0755, st_size=22672, ...}) = 0
| > > 8102  mmap(NULL, 85800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2000000000068000
| > > 8102  madvise(0x2000000000068000, 85800, MADV_SEQUENTIAL|0x1) = 0
| > > 8102  mprotect(0x2000000000070000, 49152, PROT_NONE) = 0
| > > 8102  mmap(0x200000000007c000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x200000000007c000
| > > 8102  close(3)                          = 0
| > > 8102  open("/lib/libc.so.6.1", O_RDONLY) = 3
| > > 8102  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0002\0\1\0\0\0\3609\2"..., 832) = 832
| > > 8102  fstat(3, {st_mode=S_IFREG|0755, st_size=2590313, ...}) = 0
| > > 8102  mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2000000000080000
| > > 8102  mmap(NULL, 2416624, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2000000000084000
| > > 8102  madvise(0x2000000000084000, 2416624, MADV_SEQUENTIAL|0x1) = 0
| > > 8102  mprotect(0x20000000002bc000, 49152, PROT_NONE) = 0
| > > 8102  mmap(0x20000000002c8000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x234000) = 0x20000000002c8000
| > > 8102  mmap(0x20000000002d0000, 8176, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x20000000002d0000
| > > 8102  close(3)                          = 0
| > > 8102  mmap(NULL, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x20000000002d4000
| > > 8102  mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x20000000002dc000
| > > 8102  munmap(0x200000000004c000, 111415) = 0
| > > 8102  brk(0)                            = 0x6000000000004000
| > > 8102  brk(0x6000000000028000)           = 0x6000000000028000
| > > 8102  capget(0x19980330, 0, {0, 0, 0})  = -1 EINVAL (Invalid argument)
| > 
| > I don't see why this capget is returning -EINVAL.  In fact I don't see
| > why it happens at all - cap_inode_setxattr would check
| > capable(CAP_SYS_ADMIN), but setxattr hasn't been called yet.  Looking at
| > both libcap and setfcaps.c, I don't see where the capget comes from.
| > 
| > As for the -EINVAL, kernel/capability.c:sys_capget() returns -EINVAL if
| > the _LINUX_CAPABILITY_VERSION is wrong - you have 0x19980330 which is
| > correct - if pid < 0 - but you send in 0 - or if security_capget
| > returns -EINVAL, which cap_capget (and dummy_capget) don't do.
| > 
| > Kaigai, do you have any ideas?
| > 
| > thanks,
| > -serge
| 
| 
| --------------------
| Chris Friedhoff
| chris@friedhoff.org



-- 
Bill O'Donnell
SGI
651.683.3079
billodo@sgi.com
