Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUJWM1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUJWM1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 08:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbUJWM1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 08:27:23 -0400
Received: from [69.55.226.176] ([69.55.226.176]:24809 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S261151AbUJWM1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 08:27:07 -0400
Message-ID: <417A4E16.9080505@drugphish.ch>
Date: Sat, 23 Oct 2004 14:27:02 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 oops (probably I/O congestion/starvation related), already solved?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I should like to ask if following oops has already been fixed in more 
recent kernels?

I'm seing this on a productive machine with a SuSE 9.1 kernel 
(2.6.5-7.108-default). It's tainted with the nvidia module but the oops 
is not related to it.

If this has been fixed in later kernels, please tell me so, I can then 
justify a downtime. I'm going through the archives and bk-patches myself 
but I've a backlog of about 2 months.

Unable to handle kernel paging request at virtual address 00200200
c0126c38
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0126c38>]    Tainted: PF U
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210082   (2.6.5-7.108-default)
eax: f68a41c8   ebx: e8e7bfc0   ecx: f6910980   edx: 00200200
esi: 00200246   edi: 004a04b0   ebp: 00000001   esp: d9d55d24
ds: 007b   es: 007b   ss: 0068
Stack: 00001388 0160076d f6910980 f5df8c80 f8822ca9 00000000 f6910980 
0000005c
        eee2d424 0000046a 00000001 00000000 00200086 d8a23d8c 00000000 
f5df8cdc
        d9d55d90 00000000 c19bcc10 c011f1c0 d9d55d94 d9d55d94 00200246 
f3259200
Call Trace:
  [<f8822ca9>] start_this_handle+0x309/0x480 [jbd]
  [<c011f1c0>] autoremove_wake_function+0x0/0x30
  [<c011f1c0>] autoremove_wake_function+0x0/0x30
  [<f8826d72>] __log_start_commit+0x62/0x70 [jbd]
  [<f8822ead>] journal_restart+0x8d/0x120 [jbd]
  [<f8857c80>] ext3_clear_blocks+0x60/0x130 [ext3]
  [<f8857e57>] ext3_free_data+0x107/0x140 [ext3]
  [<f8857f5d>] ext3_free_branches+0xcd/0x1f0 [ext3]
  [<f8857f5d>] ext3_free_branches+0xcd/0x1f0 [ext3]
  [<f8858944>] ext3_truncate+0x8c4/0x9b0 [ext3]
  [<f88271ee>] log_wait_commit+0x10e/0x170 [jbd]
  [<c011b34e>] __wake_up+0xe/0x20
  [<f8821c0c>] journal_stop+0x1bc/0x2b0 [jbd]
  [<f8858ad7>] ext3_delete_inode+0xa7/0xd9 [ext3]
  [<f8858a30>] ext3_delete_inode+0x0/0xd9 [ext3]
  [<c0170b3c>] generic_delete_inode+0x8c/0x120
  [<c016f93d>] iput+0x4d/0x70
  [<c0168199>] sys_unlink+0x159/0x1a0
  [<c0107dc9>] sysenter_past_esp+0x52/0x79
Code: 89 02 c7 43 04 00 02 20 00 c7 03 00 01 10 00 89 7b 08 89 da


 >>EIP; c0126c38 <__mod_timer+38/70>   <=====

 >>eax; f68a41c8 <__crc_acpi_get_possible_resources+a56e/1ebb8>
 >>ebx; e8e7bfc0 <__crc_inet_addr_type+1884d9/2c3f96>
 >>ecx; f6910980 <__crc_ide_setup_pci_noise+25946/48c0e>
 >>edx; 00200200 <__crc___kill_fasync+13efec/1abbaf>
 >>esi; 00200246 <__crc___kill_fasync+13f032/1abbaf>
 >>edi; 004a04b0 <__crc_rtnetlink_links+4e7b2/8e103>
 >>esp; d9d55d24 <__crc_unregister_binfmt+17f4b9/2e10a7>

Trace; f8822ca9 <__crc_xfrm_state_get_afinfo+6bb89/b1bca>
Trace; c011f1c0 <autoremove_wake_function+0/30>
Trace; c011f1c0 <autoremove_wake_function+0/30>
Trace; f8826d72 <__crc_xfrm_state_get_afinfo+6fc52/b1bca>
Trace; f8822ead <__crc_xfrm_state_get_afinfo+6bd8d/b1bca>
Trace; f8857c80 <__crc_xfrm_state_get_afinfo+a0b60/b1bca>
Trace; f8857e57 <__crc_xfrm_state_get_afinfo+a0d37/b1bca>
Trace; f8857f5d <__crc_xfrm_state_get_afinfo+a0e3d/b1bca>
Trace; f8857f5d <__crc_xfrm_state_get_afinfo+a0e3d/b1bca>
Trace; f8858944 <__crc_xfrm_state_get_afinfo+a1824/b1bca>
Trace; f88271ee <__crc_xfrm_state_get_afinfo+700ce/b1bca>
Trace; c011b34e <__wake_up+e/20>
Trace; f8821c0c <__crc_xfrm_state_get_afinfo+6aaec/b1bca>
Trace; f8858ad7 <__crc_xfrm_state_get_afinfo+a19b7/b1bca>
Trace; f8858a30 <__crc_xfrm_state_get_afinfo+a1910/b1bca>
Trace; c0170b3c <generic_delete_inode+8c/120>
Trace; c016f93d <iput+4d/70>
Trace; c0168199 <sys_unlink+159/1a0>
Trace; c0107dc9 <sysenter_past_esp+52/79>

Code;  c0126c38 <__mod_timer+38/70>
00000000 <_EIP>:
Code;  c0126c38 <__mod_timer+38/70>   <=====
    0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0126c3a <__mod_timer+3a/70>
    2:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)
Code;  c0126c41 <__mod_timer+41/70>
    9:   c7 03 00 01 10 00         movl   $0x100100,(%ebx)
Code;  c0126c47 <__mod_timer+47/70>
    f:   89 7b 08                  mov    %edi,0x8(%ebx)
Code;  c0126c4a <__mod_timer+4a/70>
   12:   89 da                     mov    %ebx,%edx

kernel BUG at fs/ext3/super.c:412!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<f885d19b>]    Tainted: PF U
EFLAGS: 00010286   (2.6.5-7.108-default)
eax: 0000005e   ebx: f5df8704   ecx: c033f764   edx: 00005cde
esi: f5df8680   edi: f5df8704   ebp: ed3d7400   esp: d8a23ee8
ds: 007b   es: 007b   ss: 0068
Stack: f8863680 f8862751 f8864ba6 0000019c f8864bdb ed3d7400 ed3d744c 
f886c000
        d8a23f44 c015f246 ed3d7400 f6ec2b00 00000000 c015f26f ed3d7400 
f886bfc0
        c015ead8 f7ffea60 d8a23f54 c01737d0 ed3d7400 f7ff48c0 c014b33e 
00000000
Call Trace:
  [<c015f246>] generic_shutdown_super+0xe6/0x100
  [<c015f26f>] kill_block_super+0xf/0x30
  [<c015ead8>] deactivate_super+0x38/0x50
  [<c01737d0>] sys_umount+0x70/0x2e0
  [<c014b33e>] split_vma+0x18e/0x240
  [<c0173a4c>] sys_oldumount+0xc/0xf
  [<c0107dc9>] sysenter_past_esp+0x52/0x79
Code: 0f 0b 9c 01 a6 4b 86 f8 83 c4 14 eb 88 8b 46 2c 8b 88 e8 00


 >>EIP; f885d19b <__crc_xfrm_state_get_afinfo+a607b/b1bca>   <=====

 >>ebx; f5df8704 <__crc_change_page_attr+2c361f/43bc73>
 >>ecx; c033f764 <console_sem+0/10>
 >>esi; f5df8680 <__crc_change_page_attr+2c359b/43bc73>
 >>edi; f5df8704 <__crc_change_page_attr+2c361f/43bc73>
 >>ebp; ed3d7400 <__crc_pm_send_all+7dd753/902541>
 >>esp; d8a23ee8 <__crc_ckrm_class_set_shares+9a156/a0e03>

Trace; c015f246 <generic_shutdown_super+e6/100>
Trace; c015f26f <kill_block_super+f/30>
Trace; c015ead8 <deactivate_super+38/50>
Trace; c01737d0 <sys_umount+70/2e0>
Trace; c014b33e <split_vma+18e/240>
Trace; c0173a4c <sys_oldumount+c/f>
Trace; c0107dc9 <sysenter_past_esp+52/79>

Code;  f885d19b <__crc_xfrm_state_get_afinfo+a607b/b1bca>
00000000 <_EIP>:
Code;  f885d19b <__crc_xfrm_state_get_afinfo+a607b/b1bca>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  f885d19d <__crc_xfrm_state_get_afinfo+a607d/b1bca>
    2:   9c                        pushf
Code;  f885d19e <__crc_xfrm_state_get_afinfo+a607e/b1bca>
    3:   01 a6 4b 86 f8 83         add    %esp,0x83f8864b(%esi)
Code;  f885d1a4 <__crc_xfrm_state_get_afinfo+a6084/b1bca>
    9:   c4 14 eb                  les    (%ebx,%ebp,8),%edx
Code;  f885d1a7 <__crc_xfrm_state_get_afinfo+a6087/b1bca>
    c:   88 8b 46 2c 8b 88         mov    %cl,0x888b2c46(%ebx)
Code;  f885d1ad <__crc_xfrm_state_get_afinfo+a608d/b1bca>
   12:   e8 00 00 00 00            call   17 <_EIP+0x17>


Unable to handle kernel paging request at virtual address 00200200
  printing eip:
c0126c38
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0126c38>]    Tainted: PF U
EFLAGS: 00210082   (2.6.5-7.108-default)
EIP is at __mod_timer+0x38/0x70
eax: f68a41c8   ebx: e8e7bfc0   ecx: f6910980   edx: 00200200
esi: 00200246   edi: 004a04b0   ebp: 00000001   esp: d9d55d24
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 6103, threadinfo=d9d54000 task=c19bcc10)
Stack: 00001388 0160076d f6910980 f5df8c80 f8822ca9 00000000 f6910980 
0000005c
        eee2d424 0000046a 00000001 00000000 00200086 d8a23d8c 00000000 
f5df8cdc
        d9d55d90 00000000 c19bcc10 c011f1c0 d9d55d94 d9d55d94 00200246 
f3259200
Call Trace:
  [<f8822ca9>] start_this_handle+0x309/0x480 [jbd]
  [<c011f1c0>] autoremove_wake_function+0x0/0x30
  [<c011f1c0>] autoremove_wake_function+0x0/0x30
  [<f8826d72>] __log_start_commit+0x62/0x70 [jbd]
  [<f8822ead>] journal_restart+0x8d/0x120 [jbd]
  [<f8857c80>] ext3_clear_blocks+0x60/0x130 [ext3]
  [<f8857e57>] ext3_free_data+0x107/0x140 [ext3]
  [<f8857f5d>] ext3_free_branches+0xcd/0x1f0 [ext3]
  [<f8857f5d>] ext3_free_branches+0xcd/0x1f0 [ext3]
  [<f8858944>] ext3_truncate+0x8c4/0x9b0 [ext3]
  [<f88271ee>] log_wait_commit+0x10e/0x170 [jbd]
  [<c011b34e>] __wake_up+0xe/0x20
  [<f8821c0c>] journal_stop+0x1bc/0x2b0 [jbd]
  [<f8858ad7>] ext3_delete_inode+0xa7/0xd9 [ext3]
  [<f8858a30>] ext3_delete_inode+0x0/0xd9 [ext3]
  [<c0170b3c>] generic_delete_inode+0x8c/0x120
  [<c016f93d>] iput+0x4d/0x70
  [<c0168199>] sys_unlink+0x159/0x1a0
  [<c0107dc9>] sysenter_past_esp+0x52/0x79

Code: 89 02 c7 43 04 00 02 20 00 c7 03 00 01 10 00 89 7b 08 89 da
  <3>sb orphan head is 16924729
sb_info orphan list:
   inode sda1:16924729 at f5e7c914: mode 100600, nlink 0, next 0
Assertion failure in ext3_put_super() at fs/ext3/super.c:412: 
"list_empty(&sbi->s_orphan)"
------------[ cut here ]------------
kernel BUG at fs/ext3/super.c:412!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<f885d19b>]    Tainted: PF U
EFLAGS: 00010286   (2.6.5-7.108-default)
EIP is at ext3_put_super+0xeb/0x1b0 [ext3]
eax: 0000005e   ebx: f5df8704   ecx: c033f764   edx: 00005cde
esi: f5df8680   edi: f5df8704   ebp: ed3d7400   esp: d8a23ee8
ds: 007b   es: 007b   ss: 0068
Process submountd (pid: 6102, threadinfo=d8a22000 task=f66f8200)
Stack: f8863680 f8862751 f8864ba6 0000019c f8864bdb ed3d7400 ed3d744c 
f886c000
        d8a23f44 c015f246 ed3d7400 f6ec2b00 00000000 c015f26f ed3d7400 
f886bfc0
        c015ead8 f7ffea60 d8a23f54 c01737d0 ed3d7400 f7ff48c0 c014b33e 
00000000
Call Trace:
  [<c015f246>] generic_shutdown_super+0xe6/0x100
  [<c015f26f>] kill_block_super+0xf/0x30
  [<c015ead8>] deactivate_super+0x38/0x50
  [<c01737d0>] sys_umount+0x70/0x2e0
  [<c014b33e>] split_vma+0x18e/0x240
  [<c0173a4c>] sys_oldumount+0xc/0xf
  [<c0107dc9>] sysenter_past_esp+0x52/0x79

Code: 0f 0b 9c 01 a6 4b 86 f8 83 c4 14 eb 88 8b 46 2c 8b 88 e8 00
  <7>ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0010b9010140c170]

It's a firewire disk (160GB) mounted through a TSB43AB23 IEEE-1394a-2000 
Controller. Mount options are:

/dev/sda1 on /media/ieee1394_sbp2-0010b9010140c170-0-0p1 type subfs 
(rw,noexec,nosuid,nodev,sync,procuid,iocharset=utf8)

It happened while trying to remove a 1GB file. Generally unlink() 
doesn't seem to be liked by this kernel.

Best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
