Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSGCFwG>; Wed, 3 Jul 2002 01:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSGCFwF>; Wed, 3 Jul 2002 01:52:05 -0400
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:36498 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S316916AbSGCFwD>; Wed, 3 Jul 2002 01:52:03 -0400
Date: Wed, 3 Jul 2002 01:59:30 -0400
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703055930.GA3630@lnuxlab.ath.cx>
References: <20020703022051.GA2669@lnuxlab.ath.cx> <200207030526.g635Q6T25581@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207030526.g635Q6T25581@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 08:25:45AM -0200, Denis Vlasenko wrote:
> On 3 July 2002 00:20, khromy wrote:
> > When I copy a file(13Megs) from /home/ to /tmp/, sync takes almost 2
> > minutes. When I copy the same file to /usr/local/, sync returns almost
> > right away.  Both filesystems are ext3 and are on the same harddrive.  When
> > sync is running, the harddrive light stays on but I don't hear it doing
> > anything. dmesg doesn't show any errors either. Below is the `time` output
> > for each command.  If you need anymore information  let me know..
> 
> Can be useful:
> * strace -r sync
> * ksymoopsed SysRq-T output (sync part only)

*** strace -r sync
     0.000000 execve("/bin/sync", ["sync"], [/* 24 vars */]) = 0
     0.000260 uname({sys="Linux", node="dev-01", ...}) = 0
     0.000361 brk(0)                    = 0x804a308
     0.000067 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
     0.000105 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
     0.000108 open("/etc/ld.so.cache", O_RDONLY) = 3
     0.000064 fstat64(3, {st_mode=S_IFREG|0644, st_size=24001, ...}) = 0
     0.000111 old_mmap(NULL, 24001, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
     0.000068 close(3)                  = 0
     0.000065 open("/lib/libc.so.6", O_RDONLY) = 3
     0.000086 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\24\222"..., 1024) = 1024
     0.000120 fstat64(3, {st_mode=S_IFREG|0755, st_size=1149584, ...}) = 0
     0.000087 old_mmap(NULL, 1162080, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001b000
     0.000068 mprotect(0x4012d000, 39776, PROT_NONE) = 0
     0.000056 old_mmap(0x4012d000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x112000) = 0x4012d000
     0.000098 old_mmap(0x40133000, 15200, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40133000
     0.000072 close(3)                  = 0
     0.000786 munmap(0x40015000, 24001) = 0
     0.000176 brk(0)                    = 0x804a308
     0.000049 brk(0x804a330)            = 0x804a330
     0.000051 brk(0x804b000)            = 0x804b000
     0.000092 sync()                    = 0
    92.243322 _exit(0)                  = ?

*** ksymoopsed SysRq-T
sync          D 00200034     0  1200   1199                     (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c01ae4d7>] [<c01ae688>] [<c01aeb40>] [<c01af13a>] [<c01af1f9>]
   [<c014344c>] [<c0143566>] [<c01435bb>] [<c014370a>] [<c01438a7>] [<c014394f>]
   [<c01091c3>]

Proc;  sync

>>EIP; 00200034 Before first symbol   <=====

Trace; c01ae4d7 <__get_request_wait+e7/f0>
Trace; c01ae688 <account_io_start+38/60>
Trace; c01aeb40 <__make_request+1c0/6c0>
Trace; c01af13a <generic_make_request+fa/160>
Trace; c01af1f9 <submit_bh+59/80>
Trace; c014344c <write_locked_buffers+2c/40>
Trace; c0143566 <write_some_buffers+106/130>
Trace; c01435bb <write_unlocked_buffers+2b/40>
Trace; c014370a <sync_buffers+1a/70>
Trace; c01438a7 <fsync_dev+27/b0>
Trace; c014394f <sys_sync+f/20>
Trace; c01091c3 <tracesys+1f/23>

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
