Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288696AbSAIBtR>; Tue, 8 Jan 2002 20:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288702AbSAIBtH>; Tue, 8 Jan 2002 20:49:07 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:56299 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S288696AbSAIBst>; Tue, 8 Jan 2002 20:48:49 -0500
Date: Tue, 8 Jan 2002 17:42:16 -0800
To: linux-kernel@vger.kernel.org
Subject: Filesystem creation problems with 2.4.17
Message-ID: <20020109014216.GB4511@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Delivery-Agent: TMDA v0.42/Python 2.1.1 (sunos5)
From: "Adam McKenna" <adam-dated-1010972538.f82778@flounder.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some problems creating a large filesystem on linux kernels
2.4.17.  I am using Debian Potato with Adrian Bunk's updates for 
running 2.4.  The filesystem is approx. 260GB and is on an AMI MegaRAID
RAID-5 stripe.

adam@braindb:~$ uname -a
Linux braindb 2.4.17 #1 SMP Tue Jan 8 17:18:33 PST 2002 i686 unknown
adam@braindb:~$ sudo mke2fs /dev/sda9
mke2fs 1.25 (20-Sep-2001)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
33898496 inodes, 67782243 blocks
3389112 blocks (5.00%) reserved for the super user
First data block=0
2069 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632,
2654208, 
        4096000, 7962624, 11239424, 20480000, 23887872

File size limit exceeded
adam@braindb:~$

Here is (trailing) strace output from mke2fs:

write(1, "Superblock backups stored on blo"..., 37Superblock backups stored
on blocks: ) = 37
write(1, "\n\t", 2
        )                     = 2
write(1, "32768", 532768)                    = 5
write(1, ", ", 2, )                       = 2
write(1, "98304", 598304)                    = 5
write(1, ", ", 2, )                       = 2
write(1, "163840", 6163840)                   = 6
write(1, ", ", 2, )                       = 2
write(1, "229376", 6229376)                   = 6
write(1, ", ", 2, )                       = 2
write(1, "294912", 6294912)                   = 6
write(1, ", ", 2, )                       = 2
write(1, "819200", 6819200)                   = 6
write(1, ", ", 2, )                       = 2
write(1, "884736", 6884736)                   = 6
write(1, ", ", 2, )                       = 2
write(1, "1605632", 71605632)                  = 7
write(1, ", ", 2, )                       = 2
write(1, "2654208", 72654208)                  = 7
write(1, ", ", 2, )                       = 2
write(1, "\n\t", 2
        )                     = 2
write(1, "4096000", 74096000)                  = 7
write(1, ", ", 2, )                       = 2
write(1, "7962624", 77962624)                  = 7
write(1, ", ", 2, )                       = 2
write(1, "11239424", 811239424)                 = 8
write(1, ", ", 2, )                       = 2
write(1, "20480000", 820480000)                 = 8
write(1, ", ", 2, )                       = 2
write(1, "23887872", 823887872)                 = 8
write(1, "\n\n", 2

)                     = 2
lseek(3, 0, SEEK_SET)                   = 0
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) =
1024
brk(0x8076000)                          = 0x8076000
_llseek(3, 18446744072172666880, [277635989504], SEEK_SET) = 0
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768)
= -1 EFBIG (File too large)
--- SIGXFSZ (File size limit exceeded) ---
+++ killed by SIGXFSZ +++

Can anyone shed some light on this?  I'd be happy to provide more info if it
is needed.  CC's appreciated.  I'm going to try downgrading the kernel to an
older version and see if that helps.

Thanks,

--Adam
