Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135416AbRDRWNB>; Wed, 18 Apr 2001 18:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135409AbRDRWMw>; Wed, 18 Apr 2001 18:12:52 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:46599 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135365AbRDRWMa> convert rfc822-to-8bit; Wed, 18 Apr 2001 18:12:30 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Date: Thu, 19 Apr 2001 00:12:15 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041714250400.01376@antares> <20010418123941.H492@suse.de> <20010418143953.D490@suse.de>
In-Reply-To: <20010418143953.D490@suse.de>
MIME-Version: 1.0
Message-Id: <01041900121500.06850@antares>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 April 2001 14:39, Jens Axboe wrote:

> Please send me strace info when reading/writing to the drive (or at
> least attempting to), this looks very queer indeed.
>
> Attached patch for 2.4.4-pre4 which fixes all known DVD-RAM ATAPI bugs.
> Both pio and dma mode work fine here, using ext2, on a 9.4gb HITACHI
> DVD-RAM GF-2000 drive.

I'll try the patch asap.

Here is a quick strace (on the SuSE 2.4.0 kernel, since my SMC Etherpower 
doesn't work with 2.4.3) of a read with DVD-RAM medium inserted: 

# strace dd if=/dev/hdc of=/dev/null bs=2k count=3
<... loading libraries ...>
close(0)                                = 0
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

--------------------------------

Writing works, the LED is blinking. (I didn't know the difference 
between /dev/zero and /dev/null when I did the first post. Sorry.):

# strace dd if=/dev/zero of=/dev/hdc bs=2k count=3
<... loading libraries ...>
close(0)                                = 0
open("/dev/zero", O_RDONLY|O_LARGEFILE) = 0
close(1)                                = 0
open("/dev/hdc", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 1
rt_sigaction(SIGINT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x80493d0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGQUIT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x80493d0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGPIPE, {0x80493d0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR1, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {0x8049440, [], 0x4000000}, NULL, 8) = 0
brk(0x8054000)                          = 0x8054000
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 
2048
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 
2048
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 
2048
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 
2048
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 
2048
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 
2048
write(2, "3+0 records in\n", 153+0 records in
)        = 15
write(2, "3+0 records out\n", 163+0 records out
)       = 16
close(0)                                = 0
close(1)                                = 0
_exit(0)                                = ?
-------------------------------------

But mke2fs does not work:

# strace mke2fs -b 2048 /dev/hdc
... <libraries loaded> ...
write(2, "mke2fs 1.19, 13-Jul-2000 for EXT"..., 52mke2fs 1.19, 13-Jul-2000 
for EXT2 FS 0.5b, 95/08/09
) = 52
stat64("/dev/hdc", {st_mode=S_IFBLK|0660, st_rdev=makedev(22, 0), ...}) = 0
open("/etc/mtab", O_RDONLY)             = 3
brk(0x8050000)                          = 0x8050000
fstat64(3, {st_mode=S_IFREG|0644, st_size=234, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x40017000
read(3, "/dev/sda3 / ext2 rw 0 0\nproc /pr"..., 4096) = 234
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40017000, 4096)                = 0
open("/dev/hdc", O_RDONLY|O_LARGEFILE)  = 3
ioctl(3, BLKGETSIZE, 0xbffff524)        = 0
close(3)                                = 0
open("/dev/hdc", O_RDWR|O_LARGEFILE)    = 3
time(NULL)                              = 987630857
old_mmap(NULL, 488173568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = -1 ENOMEM (Cannot allocate memory)
brk(0x251df000)                         = 0x8050000
old_mmap(NULL, 2097152, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, 
-1, 0) = 0x40159000
munmap(0x40159000, 684032)              = 0
munmap(0x40300000, 364544)              = 0
mprotect(0x40200000, 32768, PROT_READ|PROT_WRITE) = 0
old_mmap(NULL, 488173568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = -1 ENOMEM (Cannot allocate memory)
old_mmap(NULL, 488173568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
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
___________________________________

Another story: With the SuSE DVD-ROM in the drive, the 
"dd if=/dev/hdc of=/dev/null bs=2k count=3" also just reads 0 bytes as above, 
but the "mount -t iso9660 /dev/hdc /dvd" and then reading from
/dvd succeeds.

Stefan 

