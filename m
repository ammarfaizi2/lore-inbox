Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135644AbRDSMN4>; Thu, 19 Apr 2001 08:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135645AbRDSMNq>; Thu, 19 Apr 2001 08:13:46 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:34829 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135644AbRDSMNd> convert rfc822-to-8bit; Thu, 19 Apr 2001 08:13:33 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Date: Thu, 19 Apr 2001 14:13:11 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041714250400.01376@antares> <01041913393800.01240@antares> <20010419134601.P16822@suse.de>
In-Reply-To: <20010419134601.P16822@suse.de>
MIME-Version: 1.0
Message-Id: <01041914131100.01232@antares>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I applied your patch to 2.4.4-pre4. It compiled fine, but crashed during
> > boot (just right after the IDE init) with
>
> This should fix it.

It boots now. But I still cannot read a DVD-RAM disk (same behavior 
as before):
# strace dd of=/dev/null if=/dev/hdc bs=2k count=3
open("/dev/hdc", O_RDONLY|O_LARGEFILE)  = 0
close(1)                                = 0
open("/dev/null", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 1
rt_sigaction(SIGINT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x80493d0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGQUIT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x80493d0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGPIPE, {0x80493d0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR1, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {0x8049440, [], 0x4000000}, NULL, 8) = 0
brk(0x8054000)                          = 0x8054000
read(0, "", 2048)                       = 0
write(2, "0+0 records in\n", 150+0 records in
)        = 15
write(2, "0+0 records out\n", 160+0 records out
)       = 16
close(0)                                = 0
close(1)                                = 0
_exit(0)                                = ?
------------------
Nor mke2fs:

# strace mke2fs -b 2048 /dev/hdc
open("/dev/hdc", O_RDONLY|O_LARGEFILE)  = 3
ioctl(3, BLKGETSIZE, 0xbffff524)        = 0
close(3)                                = 0
open("/dev/hdc", O_RDWR|O_LARGEFILE)    = 3
time(NULL)                              = 987682145
old_mmap(NULL, 472477696, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = -1 ENOMEM (Cannot allocate memory)
brk(0x242e7000)                         = 0x8050000
old_mmap(NULL, 2097152, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, 
-1, 0) = 0x40159000
munmap(0x40159000, 684032)              = 0
munmap(0x40300000, 364544)              = 0
mprotect(0x40200000, 32768, PROT_READ|PROT_WRITE) = 0
old_mmap(NULL, 472477696, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = -1 ENOMEM (Cannot allocate memory)
old_mmap(NULL, 472477696, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = -1 ENOMEM (Cannot allocate memory)
close(3)                                = 0
write(2, "/dev/hdc", 8/dev/hdc)                 = 8
write(2, ": ", 2: )                       = 2
write(2, "Memory allocation failed", 24Memory allocation failed) = 24
write(2, " ", 1 )                        = 1
write(2, "while setting up superblock", 27while setting up superblock) = 27
)                       = 1
write(2, "\n", 1
)                       = 1
_exit(1)                                = ?

Cheers,
Stefan

