Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130847AbRATRlL>; Sat, 20 Jan 2001 12:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130762AbRATRlB>; Sat, 20 Jan 2001 12:41:01 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:36224 "EHLO
	burton") by vger.kernel.org with ESMTP id <S130636AbRATRkw>;
	Sat, 20 Jan 2001 12:40:52 -0500
Date: Sat, 20 Jan 2001 18:41:06 +0100
To: linux-kernel@vger.kernel.org
Subject: lvm-oops in 2.4.1pre8
Message-ID: <20010120184106.A355@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

got this oops when doing a 
vgextend -v vgroot /dev/ide/host2/bus0/target0/lun0/part2 \
/dev/ide/host2/bus1/target0/lun0/part2

vgroot is a VG containing 2 PVs with a striped LV. 
yesterday the same thing didnt oops but then the LV wasnt striped.
(output of vgdisplay -v at end of mail)

------------------------------------------------------------------

burton:~# uname -a
Linux burton 2.4.1-pre8 #2 Wed Jan 17 19:14:07 CET 2001 i686 unknown

burton:~# pvdisplay --help

Logical Volume Manager 0.9
Heinz Mauelshagen, Sistina Software  13/11/2000  (IOP 10)



ksymoops 2.3.7 on i686 2.4.1-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre8/ (default)
     -m /boot/System.map-2.4.1p8 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000002c
c01e3c87
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01e3c87>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00002f2f   ebx: 00000000   ecx: 00000000   edx: 0000002f
esi: 0000002c   edi: 0000002c   ebp: 00000000   esp: c1b63d8c
ds: 0018   es: 0018   ss: 0018
Process vgextend (pid: 2488, stackpage=c1b63000)
Stack: 00000000 cd47d000 4004fe03 cd47d000 cd47d000 c01e1aa2 cd47d000 00000000 
       08053c30 cd47d000 00000002 08053c30 c02dc8a0 c01df74b cd47d000 08053c30 
       cbbe3860 08053c30 4004fe03 ffffffe7 00000020 c1b63ed4 db56f5e0 08053c30 
Call Trace: [<c01e1aa2>] [<c01df74b>] [<c018e5e5>] [<c01f2a7c>] [<c01ee2b0>] [<c01f2956>] [<ffffa3d9>] 
       [<c0127d75>] [<c012157d>] [<c0122358>] [<c0122403>] [<c0122358>] [<c011f5d8>] [<c0136a14>] [<c013733a>] 
       [<c012d9e2>] [<c014f81a>] [<c012cc85>] [<c012cbbe>] [<c013a447>] [<c0108d5f>] 
Code: ac 38 e0 75 03 8d 6e ff 84 c0 75 f4 89 ea 85 d2 75 07 89 fa 

>>EIP; c01e3c87 <lvm_do_create_proc_entry_of_pv+1b/68>   <=====
Trace; c01e1aa2 <lvm_do_vg_extend+56/a8>
Trace; c01df74b <lvm_chr_ioctl+2b3/678>
Trace; c018e5e5 <n_tty_receive_buf+ea1/edc>
Trace; c01f2a7c <ip_rcv_finish+0/1e4>
Trace; c01ee2b0 <nf_hook_slow+7c/b0>
Trace; c01f2956 <ip_rcv+2f2/32c>
Trace; ffffa3d9 <END_OF_CODE+237c89ea/????>
Trace; c0127d75 <inactive_shortage+31/7c>
Trace; c012157d <__find_get_page+2d/68>
Trace; c0122358 <filemap_nopage+0/400>
Trace; c0122403 <filemap_nopage+ab/400>
Trace; c0122358 <filemap_nopage+0/400>
Trace; c011f5d8 <do_no_page+50/b0>
Trace; c0136a14 <cached_lookup+10/54>
Trace; c013733a <path_walk+6e6/7ac>
Trace; c012d9e2 <chrdev_open+3e/4c>
Trace; c014f81a <devfs_open+ee/18c>
Trace; c012cc85 <dentry_open+bd/154>
Trace; c012cbbe <filp_open+52/5c>
Trace; c013a447 <sys_ioctl+16b/184>
Trace; c0108d5f <system_call+33/38>
Code;  c01e3c87 <lvm_do_create_proc_entry_of_pv+1b/68>
00000000 <_EIP>:
Code;  c01e3c87 <lvm_do_create_proc_entry_of_pv+1b/68>   <=====
   0:   ac                        lods   %ds:(%esi),%al   <=====
Code;  c01e3c88 <lvm_do_create_proc_entry_of_pv+1c/68>
   1:   38 e0                     cmp    %ah,%al
Code;  c01e3c8a <lvm_do_create_proc_entry_of_pv+1e/68>
   3:   75 03                     jne    8 <_EIP+0x8> c01e3c8f <lvm_do_create_proc_entry_of_pv+23/68>
Code;  c01e3c8c <lvm_do_create_proc_entry_of_pv+20/68>
   5:   8d 6e ff                  lea    0xffffffff(%esi),%ebp
Code;  c01e3c8f <lvm_do_create_proc_entry_of_pv+23/68>
   8:   84 c0                     test   %al,%al
Code;  c01e3c91 <lvm_do_create_proc_entry_of_pv+25/68>
   a:   75 f4                     jne    0 <_EIP>
Code;  c01e3c93 <lvm_do_create_proc_entry_of_pv+27/68>
   c:   89 ea                     mov    %ebp,%edx
Code;  c01e3c95 <lvm_do_create_proc_entry_of_pv+29/68>
   e:   85 d2                     test   %edx,%edx
Code;  c01e3c97 <lvm_do_create_proc_entry_of_pv+2b/68>
  10:   75 07                     jne    19 <_EIP+0x19> c01e3ca0 <lvm_do_create_proc_entry_of_pv+34/68>
Code;  c01e3c99 <lvm_do_create_proc_entry_of_pv+2d/68>
  12:   89 fa                     mov    %edi,%edx


--- Volume group ---
VG Name               vgroot
VG Access             read/write
VG Status             available/resizable
VG #                  0
MAX LV                256
Cur LV                1
Open LV               1
MAX LV Size           255.99 GB
Max PV                256
Cur PV                4
Act PV                4
VG Size               2 GB
PE Size               4 MB
Total PE              512
Alloc PE / Size       512 / 2 GB
Free  PE / Size       0 / 0
VG UUID               0jth8q-BQzm-Qwwq-J1vB-6Av7-SVIP-M9YzvS

--- Logical volume ---
LV Name                /dev/vgroot/stripedtest
VG Name                vgroot
LV Write Access        read/write
LV Status              available
LV #                   1
# open                 1
LV Size                2 GB
Current LE             512
Allocated LE           512
Stripes               2
Stripe size (KByte)   64
Allocation             next free
Read ahead sectors     120
Block device           58:0


--- Physical volumes ---
PV Name (#)           /dev/ide/host2/bus0/target0/lun0/part1 (1)
PV Status             available / allocatable
Total PE / Free PE    256 / 0

PV Name (#)           /dev/ide/host2/bus0/target0/lun0/part2 (3)
PV Status             available / allocatable
Total PE / Free PE    256 / 256

PV Name (#)           /dev/ide/host2/bus1/target0/lun0/part1 (2)
PV Status             available / allocatable
Total PE / Free PE    256 / 0

PV Name (#)           /dev/ide/host2/bus1/target0/lun0/part2 (3)
PV Status             available / allocatable
Total PE / Free PE    256 / 256





-- 

//anders/g

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
