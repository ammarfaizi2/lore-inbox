Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265331AbSJXGYJ>; Thu, 24 Oct 2002 02:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbSJXGYJ>; Thu, 24 Oct 2002 02:24:09 -0400
Received: from [202.108.164.87] ([202.108.164.87]:23953 "EHLO dsguardian.com")
	by vger.kernel.org with ESMTP id <S265331AbSJXGYI>;
	Thu, 24 Oct 2002 02:24:08 -0400
Subject: pls help me
From: yf <fyou@dsguardian.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 14:30:45 +0800
Message-Id: <1035441048.727.3.camel@yf.dsguardian.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all, 

Recently I wrote a file-system under Linux. When mounting, it prints 
these messages. I use iget(sb, ino) to get the root inode. 

But when run into get_new_inode():wake_up(), it hangs there. Who could 
give me some hints? 

what the dmesg output: 
************************************************************************

==> vvfs_init() 
==> vvfs_read_super(<NULL>) 
==> vvfs_connect(192.168.1.57, 52886) 
2, 38606, 956410048 
<== vvfs_connect()OK 
superblock ordinary filling ok 
==> vvfs_alloc_inode() 
<== vvfs_alloc_inode() 
==> vvfs_read_inode(c67fb000) 
get sb sock 
get inode fid 
root inode 
fetch inode OK 
set server info OK 
<== vvfs_read_inode()c67fb000 
Unable to handle kernel paging request at virtual address fffffffc 
printing eip: 
c0117e20 
*pde = 00001063 
*pte = 00000000 
Oops: 0000 
vvfs 8139too mii iptable_filter ip_tables reiserfs mousedev keybdev hid 
input 
CPU:    0 
EIP:    0010:[<c0117e20>]    Tainted: P 
EFLAGS: 00010013 

EIP is at __wake_up [kernel] 0x20 (2.4.18-14) 
eax: c67fb098   ebx: 00000000   ecx: 00000001   edx: 00000003 
esi: c67fb098   edi: 00000003   ebp: c57add5c   esp: c57add40 
ds: 0018   es: 0018   ss: 0018 
Process insmod (pid: 651, stackpage=c57ad000) 
Stack: 00000000 c0154a4c 00000001 00000282 00000000 c67fb000 c7b09c00 
c7feb660 
       c0155885 c67fb000 00000000 c7feb660 00000000 00000000 00000000 
c7feb660 
       c7b09c00 00000000 c0155a5b c7b09c00 00000000 c7feb660 00000000 
00000000 
Call Trace: [<c0154a4c>] alloc_inode [kernel] 0xbc (0xc57add44)) 
[<c0155885>] get_new_inode [kernel] 0x145 (0xc57add60)) 
[<c0155a5b>] iget4 [kernel] 0xdb (0xc57add88)) 
[<c8964a6d>] vvfs_read_super [vvfs] 0xe1 (0xc57addb0)) 
[<c014561e>] get_anon_super [kernel] 0xce (0xc57adde4)) 
[<c89662ac>] vvfs_fs_type [vvfs] 0x0 (0xc57adde8)) 
[<c89662ac>] vvfs_fs_type [vvfs] 0x0 (0xc57addec)) 
[<c89662ac>] vvfs_fs_type [vvfs] 0x0 (0xc57addf8)) 
[<c0145943>] get_sb_nodev [kernel] 0x63 (0xc57ade00)) 
[<c89662ac>] vvfs_fs_type [vvfs] 0x0 (0xc57ade18)) 
[<c0145b50>] do_kern_mount [kernel] 0x100 (0xc57ade1c)) 
[<c89662ac>] vvfs_fs_type [vvfs] 0x0 (0xc57ade20)) 
[<c01585f3>] do_add_mount [kernel] 0x93 (0xc57ade40)) 
[<c0158920>] do_mount [kernel] 0x160 (0xc57ade60)) 
[<c896565c>] .rodata.str1.1 [vvfs] 0x74 (0xc57ade8c)) 
[<c014a237>] getname [kernel] 0x97 (0xc57ade90)) 
[<c0158d41>] sys_mount [kernel] 0xb1 (0xc57adeb0)) 
[<c8964351>] vvfs_init [vvfs] 0x59 (0xc57adedc)) 
[<c896565c>] .rodata.str1.1 [vvfs] 0x74 (0xc57adee4)) 
[<c8965657>] .rodata.str1.1 [vvfs] 0x6f (0xc57adee8)) 
[<c8965643>] .rodata.str1.1 [vvfs] 0x5b (0xc57adef4)) 
[<c011bf79>] sys_init_module [kernel] 0x4d9 (0xc57adf1c)) 
[<c8964060>] is_big_endian [vvfs] 0x0 (0xc57adf20)) 
[<c8964060>] is_big_endian [vvfs] 0x0 (0xc57adf58)) 
[<c010910f>] system_call [kernel] 0x33 (0xc57adfc0)) 


Code: 8b 53 fc 8b 02 85 c7 75 17 8b 1b 39 f3 75 f1 ff 75 f0 9d 83 
<6>Intel 810 + AC97 Audio, version 0.22, 13:45:06 Sep  4 2002 
PCI: Found IRQ 10 for device 00:1f.5 
PCI: Sharing IRQ 10 with 00:1f.3 
PCI: Setting latency timer of device 00:1f.5 to 64 
i810: Intel ICH2 found at IO 0xd800 and 0xdc00, IRQ 10 
i810_audio: Audio Controller supports 6 channels. 
i810_audio: Defaulting to base 2 channel mode. 
ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P) 
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2 
ide-floppy driver 0.99.newide 
hdd: ATAPI 52X CD-ROM drive, 128kB Cache 
Uniform CD-ROM driver Revision: 3.12 



