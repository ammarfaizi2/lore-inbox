Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129209AbQKAEik>; Tue, 31 Oct 2000 23:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQKAEic>; Tue, 31 Oct 2000 23:38:32 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:7832 "EHLO
	mail.mirai.cx") by vger.kernel.org with ESMTP id <S129209AbQKAEiR>;
	Tue, 31 Oct 2000 23:38:17 -0500
Message-ID: <39FF9E2E.5586ADF1@pobox.com>
Date: Tue, 31 Oct 2000 20:38:06 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10-6l i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-lvm@msede.com
Subject: Repeatable oops mounting snapshot fs on 2.4.0-test10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm just getting started playing around with the lvm.
I've used the HP-UX lvm, and was giving the Linux
version a spin for the very first time when I ran into
some big problems:

Let me know if I'm doing something really stupid, but
something tells me a kernel oops is not a good sign!

An excerpt from the fateful session:
-----------------------------------------------------
wintermute: /root
(tty/dev/pts/0): bash: 1014 > lvcreate -L 2000 -s -n snap1
/dev/lxlvm/lvm1
lvcreate -- INFO: using default snapshot chunk size of 64 KB
lvcreate -- doing automatic backup of "lxlvm"
lvcreate -- logical volume "/dev/lxlvm/snap1" successfully created

wintermute: /root
(tty/dev/pts/0): bash: 1015 > mount /dev/lxlvm/snap1 /snapshots/d1/
segmentation fault
------------------------------------------------------

The volume was not mounted.

oops -> ksymoops follows:

ksymoops 0.7c on i686 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /boot/System.map (specified)

CPU:    0
EIP:    0010:[<d2887f31>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0000178a   ebx: d16d6570   ecx: d16d6400   edx: 00000000
esi: 0000178c   edi: 00000002   ebp: 00000000   esp: d16d1c34
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 2947, stackpage=d16d1000)
Stack: d16d6570 0000178c 00000002 00000000 00000243 00000000 080566f4
000006f4
       00000000 d2885fa2 d16d1cce d16d1cd0 0000178a d16d6400 d16beba0
00000002
       000000e8 00000002 d16d0000 c0142f1c d288e000 0000090c c014424b
080566f4
Call Trace: [<d2885fa2>] [<c0142f1c>] [<d288e000>] [<c014424b>]
[<c014367c>] [<d
288604b>] [<c01584e0>]
       [<c01586b3>] [<c01332db>] [<c0129259>] [<c011f4d7>] [<c011f554>]
[<c011f6
d0>] [<c0110620>] [<c0110767>]
       [<c0110620>] [<c0129259>] [<c011f4d7>] [<c011f554>] [<c0136624>]
[<c0136

133b53>] [<c012c41f>]
       [<c012c356>] [<c012ca5e>] [<c010a3ff>]
Code: f7 b1 64 01 00 00 8b 44 24 2c 89 d3 8b 30 89 f7 29 df 89 f8

>>EIP; d2887f31 <[lvm-mod]lvm_snapshot_remap_block+11/f4>   <=====
Trace; d2885fa2 <[lvm-mod]lvm_map+446/4b8>
Trace; c0142f1c <padzero+1c/20>
Trace; d288e000 <[lvm-mod]__module_using_checksums+2024/11084>
Trace; c014424b <load_elf_binary+bcf/d50>
Trace; c014367c <load_elf_binary+0/d50>
Trace; d288604b <[lvm-mod]lvm_make_request_fn+f/18>
Trace; c01584e0 <generic_make_request+b4/114>
Trace; c01586b3 <ll_rw_block+173/1e8>
Trace; c01332db <block_read+337/540>
Trace; c0129259 <__alloc_pages+e1/2c8>
Trace; c011f4d7 <do_anonymous_page+2f/7c>
Trace; c011f554 <do_no_page+30/c4>
Trace; c011f6d0 <handle_mm_fault+e8/164>
Trace; c0110620 <do_page_fault+0/400>
Trace; c0110767 <do_page_fault+147/400>
Trace; c0110620 <do_page_fault+0/400>
Trace; c0129259 <__alloc_pages+e1/2c8>
Trace; c011f4d7 <do_anonymous_page+2f/7c>
Trace; c011f554 <do_no_page+30/c4>
Trace; c0136624 <cached_lookup+10/54>
Trace; c0136f8f <path_walk+72b/80c>
Trace; c0133b53 <blkdev_open+53/80>
Trace; c012c41f <dentry_open+bf/14c>
Trace; c012c356 <filp_open+52/5c>
Trace; c012ca5e <sys_read+8e/c4>
Trace; c010a3ff <system_call+33/38>
Code;  d2887f31 <[lvm-mod]lvm_snapshot_remap_block+11/f4>
00000000 <_EIP>:
Code;  d2887f31 <[lvm-mod]lvm_snapshot_remap_block+11/f4>   <=====
   0:   f7 b1 64 01 00 00         div    0x164(%ecx),%eax   <=====
Code;  d2887f37 <[lvm-mod]lvm_snapshot_remap_block+17/f4>
   6:   8b 44 24 2c               mov    0x2c(%esp,1),%eax
Code;  d2887f3b <[lvm-mod]lvm_snapshot_remap_block+1b/f4>
   a:   89 d3                     mov    %edx,%ebx
Code;  d2887f3d <[lvm-mod]lvm_snapshot_remap_block+1d/f4>
   c:   8b 30                     mov    (%eax),%esi
Code;  d2887f3f <[lvm-mod]lvm_snapshot_remap_block+1f/f4>
   e:   89 f7                     mov    %esi,%edi
Code;  d2887f41 <[lvm-mod]lvm_snapshot_remap_block+21/f4>
  10:   29 df                     sub    %ebx,%edi
Code;  d2887f43 <[lvm-mod]lvm_snapshot_remap_block+23/f4>
  12:   89 f8                     mov    %edi,%eax


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
