Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130157AbRAaSpI>; Wed, 31 Jan 2001 13:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRAaSos>; Wed, 31 Jan 2001 13:44:48 -0500
Received: from m2ep.pp.htv.fi ([212.90.64.98]:27155 "EHLO m2.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S131003AbRAaSon>;
	Wed, 31 Jan 2001 13:44:43 -0500
Date: Wed, 31 Jan 2001 20:44:31 +0200 (EET)
From: Timo Jantunen <jeti@iki.fi>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at inode.c:889!
Message-ID: <Pine.LNX.4.30.0101312023170.1186-100000@limbo.null.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heip!


While I was looking unused partitions to be used for ReiserFS testing
(paranoia is a way of life when dealing with my data ;-), I did

mount /dev/hda5 /mnt/tmp

to a partition which I thought to be unused (just to be sure). This resulted
in a Really Weird(tm) /mnt/tmp _file_ which didn't have any permissions to
anyone. When checking kernel messages, I found "EXT2-fs warning: checktime
reached, running e2fsck is recommended" line. Then I tried to unmount the
partition. It checkfaulted. Messages had following entries.

---cut
Jan 31 19:46:30 limbo kernel: EXT2-fs error (device ide0(3,5)): free_inode: reserved inode or nonexistent inode
Jan 31 19:46:30 limbo kernel: kernel BUG at inode.c:889!
Jan 31 19:46:30 limbo kernel: invalid operand: 0000
Jan 31 19:46:30 limbo kernel: CPU:    0
Jan 31 19:46:30 limbo kernel: EIP:    0010:[iput+205/336]
Jan 31 19:46:30 limbo kernel: EFLAGS: 00010282
Jan 31 19:46:30 limbo kernel: eax: 0000001b   ebx: c7ce7180   ecx: cd536000   edx: c023a328
Jan 31 19:46:30 limbo kernel: esi: c023dde0   edi: c023dde0   ebp: c023de18   esp: c7c69f20
Jan 31 19:46:30 limbo kernel: ds: 0018   es: 0018   ss: 0018
Jan 31 19:46:30 limbo kernel: Process umount (pid: 1076, stackpage=c7c69000)
Jan 31 19:46:30 limbo kernel: Stack: c020954b c02095eb 00000379 c80b48c0 c7ce7180 c01413fe c7ce7180 cbb04e00
Jan 31 19:46:30 limbo kernel:        c80b48c0 c01352ff c80b48c0 c88ed0c0 cbb04e00 00000000 080526c0 c013466a
Jan 31 19:46:30 limbo kernel:        c0135731 cbb04e00 00000000 c88ed0c0 c023ce8c ffffffff cd07a000 c0135803
Jan 31 19:46:30 limbo kernel: Call Trace: [dput+238/336] [kill_super+63/304] [remove_vfsmnt+138/144] [do_umount+433/448] [sys_umount+195/240] [sys_munmap+43/64] [sys_oldumount+12/16]
Jan 31 19:46:30 limbo kernel:        [system_call+51/56]
Jan 31 19:46:30 limbo kernel:
Jan 31 19:46:30 limbo kernel: Code: 0f 0b 83 c4 0c eb 6c 39 1b 74 38 f6 83 ec 00 00 00 07 75 26
---cut

I couldn't unmount that partition, but SysRq <Sync> <Unmount> <Boot> saved
all other partitions.

After reboot I fsck'd /dev/hda5 and it was seriously messed up. Actually it
was very likely once part of RAID array tests I did a while back (/dev/hda5
was 5GB but fsck said ext2 was a 6GB filesystem).

So ok, I did try to mount a seriously messed up filesystem, but it shouldn't
be possible in the first place or at least it shouldn't do that when I try to
umount.


// /
....................................Timo Jantunen  ......................
       ZZZ      (Used to represent :Kuunsäde 8 A 28: Email: jeti@iki.fi :
the  sound of  a person  snoring.) :02210 Espoo    : http://iki.fi/jeti :
Webster's  Encyclopedic Unabridged :Finland        : GSM+358-40-5763131 :
Dictionary of the English Language :...............:....................:


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
