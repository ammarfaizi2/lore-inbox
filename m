Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVLDT0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVLDT0k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 14:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVLDT0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 14:26:40 -0500
Received: from [82.94.235.172] ([82.94.235.172]:40919 "EHLO
	mail.hipersonik.com") by vger.kernel.org with ESMTP id S932305AbVLDT0j
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 14:26:39 -0500
From: Norbert van Nobelen <norbert-kernel@hipersonik.com>
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: UML with 2.6.14-3 kernel
Date: Sun, 4 Dec 2005 20:29:31 +0100
User-Agent: KMail/1.8.2
Organization: Hipersonik.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512042029.32038.norbert-kernel@hipersonik.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to run UML with the 2.6.14-3 kernel, but for some reason if does 
not want to boot correctly.

The following error stays, despite changes which usually fix this problem with 
a normal kernel (usually a configure problem: Forgot the filesystem in the 
kernel setup):

<snip>
VFS: Cannot open root device "/tmp/root_fs" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
</snip>

The file /tmp/root_fs does exists.
I compiled the filesystem drivers into the kernel, tried to different linux 
installs for root. I am stuck. What am I missing here?

Complete boot log for the UML kernel 2.6.14-3:
Checking PROT_EXEC mmap in /tmp...OK
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
UML running in SKAS3 mode
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Linux version 2.6.14.3-default (root@linux) (gcc version 4.0.2 20050901 
(prerelease) (SUSE Linux)) #2 Sun Dec 4 19:34:47 CET 2005
Built 1 zonelists
Kernel command line: root=/tmp/root_fs
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27648k available
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
softlockup thread 0 started up.
Using 2.6 host AIO
NET: Registered protocol family 16
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
mconsole (version 2) initialized on /home/norbert/.uml/yZR0cN/mconsole
audit: initializing netlink socket (disabled)
audit(0.270:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NTFS driver 2.1.24 [Flags: R/W].
fuse init (API version 7.2)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
Initialized stdio console driver
Console initialized on /dev/tty0
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Cannot open root device "/tmp/root_fs" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

EIP: 0073:[<a0256fc1>] CPU: 0 Not tainted ESP: 007b:40000f9c EFLAGS: 00000202
    Not tainted
EAX: 00000000 EBX: 000017b3 ECX: 00000013 EDX: 000017b3
ESI: 000017af EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
a0cafb30:  [<a0031328>] printk+0x18/0x20
a0cafb40:  [<a00417ed>] notifier_call_chain+0x1d/0x30
a0cafb60:  [<a003086a>] panic+0x5a/0x110
a0cafb90:  [<a0001a1d>] mount_block_root+0x9d/0x110
a0cafbe0:  [<a0001bd1>] mount_root+0x51/0x60
a0cafbf0:  [<a0001c71>] prepare_namespace+0x91/0x140
a0cafbf8:  [<a00121b0>] init+0x0/0x160
a0cafc00:  [<a0001c1e>] prepare_namespace+0x3e/0x140
a0cafc0c:  [<a00121b0>] init+0x0/0x160
a0cafc10:  [<a00122e0>] init+0x130/0x160
a0cafc18:  [<a0256c69>] __sigjmp_save+0x39/0x50
a0cafc30:  [<a0027399>] run_kernel_thread+0x39/0x50
a0cafc58:  [<a00121b0>] init+0x0/0x160
a0cafc64:  [<a002737e>] run_kernel_thread+0x1e/0x50
a0cafcc0:  [<a002cea4>] schedule_tail+0x24/0x180
a0cafce8:  [<a00121b0>] init+0x0/0x160
a0cafcf0:  [<a001f078>] new_thread_handler+0x98/0xd0
a0cafcf4:  [<a00121b0>] init+0x0/0x160
a0cafd60:  [<a0256fc1>] __kill+0x11/0x20

The host kernel (Standard SuSE kernel):
Linux version 2.6.13-15-default (geeko@buildhost) (gcc version 4.0.2 20050901 
(prerelease) (SUSE Linux)) #1 Tue Sep 13 14:56:15 UTC 2005
