Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271321AbRHZPO4>; Sun, 26 Aug 2001 11:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271320AbRHZPOr>; Sun, 26 Aug 2001 11:14:47 -0400
Received: from web13108.mail.yahoo.com ([216.136.174.153]:40458 "HELO
	web13108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271321AbRHZPOc>; Sun, 26 Aug 2001 11:14:32 -0400
Message-ID: <20010826151449.99510.qmail@web13108.mail.yahoo.com>
Date: Sun, 26 Aug 2001 08:14:49 -0700 (PDT)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Jfs bug ?
To: linuxjfs@us.ibm.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
I just formated one of mine linux partitions with jfs 
I had the following problems

When restoring from backup

jfs_strtoUCS: char2uni returned -22.
charset = iso8859-1, char = 0xffffff99
jfs_strtoUCS: char2uni returned -22.
charset = iso8859-1, char = 0xffffff99
jfs_strtoUCS: char2uni returned -22.
charset = iso8859-1, char = 0xffffff99
jfs_strtoUCS: char2uni returned -22.
charset = iso8859-1, char = 0xffffff99

I then booted the jfs partitions (03:07  /dev/hda7)
(slackware 8.0 glibc 2.2.3)

looked around, everything seemed to be fine and I did
a halt because it was late
and the systems works well until 'umount -a' (executed
automatically in sysvinit scripts) and then stops
I wait for a while and I press 'Alt SysRQ +s' (magic
sysrequire key + s) the message: 
Syncing device 03:07 ...
This is my root jfs partition
I had to reboot-it with 'Alt SysRq + b'

Later:

When I rebooted from my ext2 (03:02) partition it was
a jfs check at startup.

I was copying the kernel source from one partition to
another
I did also a man xpeek

result:
Sat Aug 25 - 10:38:08
root@grinch:/root/# ps ax
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:03 init
    2 ?        SW     0:00 [keventd]
    3 ?        SWN    0:00 [ksoftirqd_CPU0]
    4 ?        DW     0:34 [kswapd]
    5 ?        SW     0:00 [kreclaimd]
    6 ?        DW     0:06 [bdflush]
    7 ?        SW     0:07 [kupdated]
    8 ?        SW     0:12 [jfsIO]
    9 ?        DW     0:20 [jfsCommit]
   10 ?        SW     0:00 [jfsSync]
   64 ?        S      0:00 /usr/sbin/syslogd
   67 ?        SW     0:06 /usr/sbin/klogd -c 7
   69 ?        S      0:00 /usr/sbin/crond -l10
   77 ?        S      0:00 sendmail: accepting
connections
   85 ttyS1    S      0:00 gpm -m /dev/ttyS1 -t bare
   89 tty1     SW     0:00 -bash
   90 tty2     SW     0:01 -bash
   91 tty3     S      0:00 -bash
   92 tty4     S      0:00 -bash
   93 tty5     S      0:00 -bash
   94 tty6     SW     0:00 /sbin/agetty 38400 tty6
linux
  110 tty1     SW     0:04 /usr/bin/mc -P
  111 ?        SW     0:00 cons.saver /dev/tty1
  112 pts/0    SW     0:00 bash -rcfile .bashrc
  117 pts/0    DW     0:19 tar -c linux
  118 pts/0    DW     0:36 tar -x -C
/mnt/hda7/usr/src/ -f -
  133 tty2     SW     0:00 man xpeek
  136 tty2     SW     0:00 sh -c (cd /usr/share/man ;
(echo -e ".ll 11.8i\n.pl 1100i"; /bin/gunzip -c
/usr/share/man/man8/xpeek.8.gz; echo ".pl \n(nlu+10")
| /usr/bin/gtbl | /usr/bin/groff -S -Tascii -mandoc |
/usr/bin/less -is)
  137 tty2     SW     0:00 sh -c (cd /usr/share/man ;
(echo -e ".ll 11.8i\n.pl 1100i"; /bin/gunzip -c
/usr/share/man/man8/xpeek.8.gz; echo ".pl \n(nlu+10")
| /usr/bin/gtbl | /usr/bin/groff -S -Tascii -mandoc |
/usr/bin/less -is)
  142 tty2     DW     0:00 /usr/bin/less -is
  143 tty2     DW     0:00 troff -msafer -mandoc
-Tascii
  161 tty3     DW     0:00 sync
  175 tty4     S      0:02 mcedit jfs.err
  176 ?        SW     0:00 cons.saver /dev/tty4
  189 tty5     R      0:00 ps --cols 660 ax

'man xpeek' and 'tar -c linux  | tar -x -C
/mnt/hda7/usr/src/ -f -' are hunged 
after waiting for a while I openned another console
and did a manual 'sync' but this process hung too


I did an emergency sync (Alt SysRQ +s) result:
SysRq: Emergency Sync
Syncing device 03:02 ... OK
Syncing device 03:01 ... OK
Syncing device 03:05 ... OK
Syncing device 03:07 ...

03:02 and 03:05 are ext2 partitions
03:01 is a dos partition (fat16)
03:07 is a jfs partition

In the same time the logs are clean
(I have syslog on /dev/tty12 and 
i'm running klogd -c 7)

Here is dmesg output:

Linux version 2.4.9 (root@grinch) (gcc version
2.95.2.1 19991024 (release)) #5 Thu Aug 23 21:45:26
EEST 2001
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000000c00000 (usable)
On node 0 totalpages: 3072
zone(0): 3072 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=lin49jfs ro root=302
Initializing CPU#0
Console: colour VGA+ 132x25
Calibrating delay loop... 26.62 BogoMIPS
Memory: 10028k/12288k available (1069k kernel code,
1872k reserved, 318k data, 56k init, 0k highmem)
Checking if this processor honours the WP bit even in
supervisor mode... Ok.
Dentry-cache hash table entries: 2048 (order: 2, 16384
bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192
bytes)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 4096 (order: 2, 16384
bytes)
CPU: Before vendor init, caps: 00000000 00000000
00000000, vendor = 1
CPU: After vendor init, caps: 00000000 00000000
00000000 00000000
CPU:     After generic, caps: 00000000 00000000
00000000 00000000
CPU:             Common caps: 00000000 00000000
00000000 00000000
CPU: Cyrix Cx486DX2 stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
isapnp: Scanning for PnP cards...
isapnp: Card 'Crystal Codec'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Starting kswapd v1.8
JFS development version: $Name: v1_0_3 $
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with ISAPNP
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
Real Time Clock Driver v1.10d
block: 64 slots per queue, batch=8
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes;
override with idebus=xx
hda: ST36421A, ATA DISK drive
hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12596850 sectors (6450 MB) w/256KiB Cache,
CHS=784/255/63
hdb: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
Adding Swap: 104384k swap-space (priority -1)
SysRq: Emergency Sync
Syncing device 03:02 ... OK
Syncing device 03:01 ... OK
Syncing device 03:05 ... OK
Syncing device 03:07 ... 

My computer configuration:

o  Gnu C	2.95.2.1
o  Gnu make	GNU Make version 3.79.1
o  binutils	GNU ld version 2.11.90.0.25 (with BFD
2.11.90.0.25)
o  util-linux	fdformat from util-linux-2.11h
o  modutils	insmod version 2.4.7
o  e2fsprogs	tune2fs 1.22
o  reiserfsprogs	reiserfsprogs 3.x.0b

Glibc 2.1.3
Slackware 7.1 (modified)

the jfs utils are jfsutils-1.0.3.tar.gz from IBM site
I patched the kernel with patches from 
jfs-2.4-1.0.3-patch.tar.gz (those for kernel
2.4.7-2.4.9)
original kernel was 2.4.7 from kernel.org patched to
2.4.8 and then to 2.4.9 with patches from
ftp.timisoara.roedu.net kernel mirror (unnoficial
mirror) 

Any idea ?


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
