Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131100AbQJ2EjX>; Sun, 29 Oct 2000 00:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131532AbQJ2EjO>; Sun, 29 Oct 2000 00:39:14 -0400
Received: from z211-19-80-152.dialup.wakwak.ne.jp ([211.19.80.152]:2809 "EHLO
	220fx.luky.org") by vger.kernel.org with ESMTP id <S131100AbQJ2EjH>;
	Sun, 29 Oct 2000 00:39:07 -0400
To: axboe@suse.de
Cc: shibata@luky.org, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
In-Reply-To: <20001028201047.A5879@suse.de>
In-Reply-To: <20001028134056.J3919@suse.de>
	<20001029120703Y.shibata@luky.org>
	<20001028201047.A5879@suse.de>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001029134145N.shibata@luky.org>
Date: Sun, 29 Oct 2000 13:41:45 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again.

> > > Ok, does /proc/sys/dev/cdrom/info list DVD-RAM as a capability?

> > CD-ROM information, Id: cdrom.c 3.12 2000/10/22
> > 
> > Can write DVD-RAM:      1
> 
> So far, so good.

:-)

> > Should I set any flags to permit write a DVD-RAM media ?
> 
> No, as I said it should detect it automatically. But d'oh, I
> just realised that it is set too soon... Sorry, try with this
> patch.

Thank you for your quick response.

I tried the patch.
But kernel said Oops both fdisk /dev/hdc and
dd if=/dev/zero of=/dev/hdc bs=2048 count=1 .

strace dd if=/dev/zero of=/dev/hdc bs=2048 count=1 shows
-----------------------------------------------------------------------------
[root@celto shibata]# strace  dd if=/dev/zero of=/dev/hdc bs=2048 count=1
execve("/bin/dd", ["dd", "if=/dev/zero", "of=/dev/hdc", "bs=2048", "count=1"], [/* 19 vars */]) = 0
brk(0)                                  = 0x80504a8
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=19214, ...}) = 0
old_mmap(NULL, 19214, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=5224080, ...}) = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0(\215\1"..., 4096) = 4096
old_mmap(NULL, 941692, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40019000
mprotect(0x400f7000, 32380, PROT_NONE)  = 0
old_mmap(0x400f7000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xdd000) = 0x400f7000
old_mmap(0x400fc000, 11900, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400fc000
close(3)                                = 0
munmap(0x40014000, 19214)               = 0
personality(PER_LINUX)                  = 0
getpid()                                = 709
brk(0)                                  = 0x80504a8
brk(0x80504e0)                          = 0x80504e0
brk(0x8051000)                          = 0x8051000
close(0)                                = 0
open("/dev/zero", O_RDONLY|O_LARGEFILE) = 0
close(1)                                = 0
open("/dev/hdc", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = -1 ENOSYS (Function not implemented)
open("/dev/hdc", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = -1 ENOSYS (Function not implemented)
open("/dev/hdc", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 1
rt_sigaction(SIGINT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x804adec, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGQUIT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x804adec, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGPIPE, {0x804adec, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR1, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {0x804aeac, [], 0x4000000}, NULL, 8) = 0
brk(0x8054000)                          = 0x8054000
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 2048
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 2048
write(2, "1+0 records in\n", 151+0 records in
)        = 15
write(2, "1+0 records out\n", 161+0 records out
)       = 16
close(0)                                = 0
close(1

-----------------------------------------------------------------------------
After showing above strace message in a few seconds, kernel panic happened.

I can not see some head line of Oops messages. Sorry.

Please let me test more patches. I will keep up with you.

Best Regards,

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata
0(mmm)0 P-mail: 070-5419-3233    IRC: #luky
   ~    http://his.luky.org/ last update:2000.3.12
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
