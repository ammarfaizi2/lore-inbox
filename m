Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLOJ3L>; Fri, 15 Dec 2000 04:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbQLOJ3B>; Fri, 15 Dec 2000 04:29:01 -0500
Received: from jam.net.uni-c.dk ([130.226.0.33]:7158 "HELO jam.net.uni-c.dk")
	by vger.kernel.org with SMTP id <S129421AbQLOJ2r>;
	Fri, 15 Dec 2000 04:28:47 -0500
Date: Fri, 15 Dec 2000 09:57:23 +0100
From: torben fjerdingstad <unitfj-lk@tfj.rnd.uni-c.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12 kernel BUG at buffer.c:765!
Message-ID: <20001215095723.B2724@tfj.rnd.uni-c.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dual pentium, aic7xxx,
In the middle of mke2fs'ing /dev/md1 (3x18Gb disks):

raid5: resync finished.
kernel BUG at buffer.c:765!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0131831>]
EFLAGS: 00010286
eax: 0000001c   ebx: dc043b28   ecx: 00000000   edx: 01000000
esi: c56a3160   edi: c56a3000   ebp: dc043ae0   esp: cb845e8c
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 3781, stackpage=cb845000)
Stack: c020de85 c020e1ba 000002fd 00000004 f891703c dc043ae0 00000001
00000004
       c56a3000 00000001 00000000 f8917bbf c56a3000 00000001 00000001
c56a3000
       e3ced400 c56a3000 00000003 00000003 e3ced400 f8918717 c56a3000
c56a3000
Call Trace: [<c020de85>] [<c020e1ba>] [<f891703c>] [<f8917bbf>]
[<f8918717>] [<c010a806>] [<f8918c89>]
       [<c01c0547>] [<c0107488>]
Code: 0f 0b 83 c4 0c 5b c3 55 57 56 53 8b 5c 24 14 8b 54 24 18 85


The symbols around c0131831 are here:
c01317c0 T init_buffer
c01317dc t end_buffer_io_bad
c0131838 t end_buffer_io_async
c0131958 T fsync_inode_buffers

Here is the output from mke2fs until it stuck:
# mke2fs /dev/md1
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
4480448 inodes, 8960192 blocks
448009 blocks (5.00%) reserved for the super user
First data block=0
274 block groups
32768 blocks per group, 32768 fragments per group
16352 inodes per group
Superblock backups stored on blocks:
 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
 4096000, 7962624

Writing inode tables: 110/274

-- 
Med venlig hilsen / Regards 
Netdriftgruppen / Network Management Group
UNI-C          

Tlf./Phone   +45 35 87 89 41        Mail:  UNI-C                                
Fax.         +45 35 87 89 90               Bygning 304
E-mail: torben.fjerdingstad@uni-c.dk       DK-2800 Lyngby

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
