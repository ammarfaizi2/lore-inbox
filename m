Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRCGHyP>; Wed, 7 Mar 2001 02:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130429AbRCGHx4>; Wed, 7 Mar 2001 02:53:56 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:13838 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S130428AbRCGHxs>; Wed, 7 Mar 2001 02:53:48 -0500
Date: Tue, 6 Mar 2001 23:53:07 -0800 (PST)
From: Jauder Ho <jauderho@carumba.com>
X-X-Sender: <jauderho@twinlark.arctic.org>
To: <lnz@dandelion.com>, <alan@www.linux.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: RAID, 2.4.2 and Buslogic
In-Reply-To: <200103060831.JAA04492@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.33.0103061015130.1695-100000@twinlark.arctic.org>
X-Mailer: UW Pine 4.21 + a bunch of schtuff
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Leonard,

My story is somewhat similar to what Dick Johnson has encountered except
this is with 2.4.2 running on a pentium 200.

I encountered an oops last night while untarring a file. Upon reboot, it
appears that the partition labels disappeared along with the superblock.
Unfortunately, I was not able to recover and had to redo the setup from
scratch.


Here is the lspci output

deepthought%jauderho% lspci
00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
00:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 02)
00:0b.0 VGA compatible controller: ATI Technologies Inc 210888GX [Mach64
GX] (rev 01)
00:0d.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX
(rev 10)
00:0f.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] (rev 08)



Unfortunately, the System.map was deleted during a compile but attached is
the dmesg output.

EXT2-fs error (device md(9,0)): ext2_add_entry: bad entry in directory
#343396:
inode out of bounds - offset=0, inode=343396, rec_len=12, name_len=1
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 12
EXT2-fs error (device md(9,0)): free_inode: reserved inode or nonexistent
inode
kernel BUG at inode.c:885!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01425ba>]
EFLAGS: 00010292
eax: 0000001b   ebx: c2af8ba0   ecx: c373c000   edx: 00000001
esi: c023b9e0   edi: c38bd017   ebp: c3c285e0   esp: c1877f24
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 5383, stackpage=c1877000)
Stack: c01fd7e5 c01fd865 00000375 c2af8ba0 c13b8f40 c014fa07 c2af8ba0
ffffffff
       000001fd c3c285e0 c3c28650 c13b8f40 00000007 c3932560 c0138ef7
fffffffe
       c013a773 c3c285e0 c13b8ee0 000001fd c13b8ee0 c1877fa4 c13b8ee0
c1e5c000
Call Trace: [<c014fa07>] [<c0138ef7>] [<c013a773>] [<c013a816>]
[<c0108de3>]

Code: 0f 0b 83 c4 0c eb 6f 39 1b 74 3b f6 83 ec 00 00 00 07 75 26
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 474218
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 474219
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 474216

...

EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number:
1062908
EXT2-fs error (device md(9,0)): ext2_readdir: bad entry in directory
#310689: in
ode out of bounds - offset=0, inode=310689, rec_len=12, name_len=1
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 228935
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 212584
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 212583
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 212586
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 212588
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 212589
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 212587
EXT2-fs error (device md(9,0)): ext2_write_inode: bad inode number: 212585
EXT2-fs error (device md(9,0)): ext2_find_entry: bad entry in directory
#883010:
 inode out of bounds - offset=60, inode=245344, rec_len=4036, name_len=16



--Jauder







PS. Is there a minimum processor speed requirement to do RAID? I know the
pentium 200 is pretty wimpy but if this is the failure mode it was
certainly unexpected.



