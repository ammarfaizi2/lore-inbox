Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWBZCjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWBZCjf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 21:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWBZCjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 21:39:35 -0500
Received: from central.webforum.de ([194.126.158.21]:61316 "EHLO
	server.webforum.de") by vger.kernel.org with ESMTP id S1751176AbWBZCje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 21:39:34 -0500
Subject: Oops in 2.6.15 with OpenVZ 025stab014 with high IO usage
From: Friedrich Schaeuffelhut <fries@desert.lnp.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 26 Feb 2006 03:12:55 +0100
Message-Id: <1140919976.8790.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm using a linux 2.6.15 with OpenVZ  025stab014 from
http://openvz.org/download/beta/kernel/

Under high IO usage this Kernel oopes.

I'm not a kernel developer, so I hoped someone could explain those
Oopses to me.  I'm also in contact with the OpenVZ developers. 

The Oops is reproduceable by running a command that stresses file io
like: stress -t 36000 -c 1 -i 1 -m 2 --vm-hang 5 -d 2 --hdd-bytes 800M

The problem does not appear in a vanilla 2.6.15.4 kernel.

The system setup is:

CPU:   Intel(R) Pentium(R) 4 CPU 2.60GHz
RAM:   1GB (48 runns of a mem test didn't show any errors)
Board: Tyan 5102,  82801EB/ER (ICH5/ICH5R)
SCSI:  Adaptec AHA-3960D / AIC-7899A U160/m
       2 x Vendor: SEAGATE  Model: ST336607LC
SATA:  1 x Vendor: ATA      Model: Maxtor 6V300F0
USB-Disk: 1 x Vendor: TinyDisk Model: 2005-12-08

Filesystem: EXT3 on software raid 1 on SCSI Disks
            SWAP on software raid 1 on SCSI Disks

The machine was rebooted after each Oops.

Please CC: me (fries@desert.lnp.org) any responses to this post.

Thank you for your time 
        Friedrich

Here are two of the Kernel Oopes:

Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c0138c32>]    Not tainted VLI
EFLAGS: 00010002   (2.6.15-025stab014)
eax: f02667cc   ebx: 51377c51   ecx: fffffffa   edx: 0002eec0
esi: 000200d2   edi: f02667c8   ebp: 0002eec0   esp: d96efd34
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 000200d2 d96efd74 bfbc66ae c013a3bf f02667c8 0002eec0
c149731c
       00001000 00000000 0002eec0 00001000 f026671c c02dd820 f02667c8
f61a4500
       c14479c0 000c02ee d96efe88 3f26671c 0000000a 00000000 c1249384
c12493a8
Call Trace:
 [<c013a3bf>] generic_file_buffered_write+0x141/0x535
 [<c013abe3>] __generic_file_aio_write_nolock+0x430/0x45e
 [<c0206528>] scsi_prep_fn+0x16e/0x1c7
 [<c013ae43>] generic_file_aio_write+0x66/0xb7
 [<c018a78c>] ext3_file_write+0x26/0x94
 [<c01525b9>] do_sync_write+0xb8/0xeb
 [<c0205f85>] scsi_io_completion+0x1c5/0x3a5
 [<c0225eb5>] sd_rw_intr+0x21c/0x224
 [<c012b5fe>] autoremove_wake_function+0x0/0x3a
 [<c020236b>] scsi_finish_command+0x13/0x83
 [<c0173f90>] inotify_dentry_parent_queue_event+0x29/0x8f
 [<c0152675>] vfs_write+0x89/0x120
 [<c01527aa>] sys_write+0x3b/0x63
 [<c01027eb>] sysenter_past_esp+0x54/0x75
Code: fb 89 d0 5b c3 55 57 56 53 8b 7c 24 14 8b 6c 24 18 8d 47 10 e8 86
bf 15 00 55 8d 47 04 50 e8 51 4d 08 00 89 c3 58 85 db 5a 74 56 <8b> 03
89 da f6 c4 40 74 03 8b 53 0c f0 ff 42 04 f0 0f ba 2b 00


>>EIP; c0138c32 <find_lock_page+26/88>   <=====

>>eax; f02667cc <pg0+2fee37cc/3fc7b400>
>>ebx; 51377c51 <phys_startup_32+51277c51/c0000000>
>>ecx; fffffffa <__kernel_rt_sigreturn+1bba/????>
>>edi; f02667c8 <pg0+2fee37c8/3fc7b400>
>>esp; d96efd34 <pg0+1936cd34/3fc7b400>

Trace; c013a3bf <generic_file_buffered_write+141/535>
Trace; c013abe3 <__generic_file_aio_write_nolock+430/45e>
Trace; c0206528 <scsi_prep_fn+16e/1c7>
Trace; c013ae43 <generic_file_aio_write+66/b7>
Trace; c018a78c <ext3_file_write+26/94>
Trace; c01525b9 <do_sync_write+b8/eb>
Trace; c0205f85 <scsi_io_completion+1c5/3a5>
Trace; c0225eb5 <sd_rw_intr+21c/224>
Trace; c012b5fe <autoremove_wake_function+0/3a>
Trace; c020236b <scsi_finish_command+13/83>
Trace; c0173f90 <inotify_dentry_parent_queue_event+29/8f>
Trace; c0152675 <vfs_write+89/120>
Trace; c01527aa <sys_write+3b/63>
Trace; c01027eb <sysenter_past_esp+54/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0138c07 <find_trylock_page+37/3c>
00000000 <_EIP>:
Code;  c0138c07 <find_trylock_page+37/3c>
   0:   fb                        sti
Code;  c0138c08 <find_trylock_page+38/3c>
   1:   89 d0                     mov    %edx,%eax
Code;  c0138c0a <find_trylock_page+3a/3c>
   3:   5b                        pop    %ebx
Code;  c0138c0b <find_trylock_page+3b/3c>
   4:   c3                        ret
Code;  c0138c0c <find_lock_page+0/88>
   5:   55                        push   %ebp
Code;  c0138c0d <find_lock_page+1/88>
   6:   57                        push   %edi
Code;  c0138c0e <find_lock_page+2/88>
   7:   56                        push   %esi
Code;  c0138c0f <find_lock_page+3/88>
   8:   53                        push   %ebx
Code;  c0138c10 <find_lock_page+4/88>
   9:   8b 7c 24 14               mov    0x14(%esp),%edi
Code;  c0138c14 <find_lock_page+8/88>
   d:   8b 6c 24 18               mov    0x18(%esp),%ebp
Code;  c0138c18 <find_lock_page+c/88>
  11:   8d 47 10                  lea    0x10(%edi),%eax
Code;  c0138c1b <find_lock_page+f/88>
  14:   e8 86 bf 15 00            call   15bf9f <_EIP+0x15bf9f>
Code;  c0138c20 <find_lock_page+14/88>
  19:   55                        push   %ebp
Code;  c0138c21 <find_lock_page+15/88>
  1a:   8d 47 04                  lea    0x4(%edi),%eax
Code;  c0138c24 <find_lock_page+18/88>
  1d:   50                        push   %eax
Code;  c0138c25 <find_lock_page+19/88>
  1e:   e8 51 4d 08 00            call   84d74 <_EIP+0x84d74>
Code;  c0138c2a <find_lock_page+1e/88>
  23:   89 c3                     mov    %eax,%ebx
Code;  c0138c2c <find_lock_page+20/88>
  25:   58                        pop    %eax
Code;  c0138c2d <find_lock_page+21/88>
  26:   85 db                     test   %ebx,%ebx
Code;  c0138c2f <find_lock_page+23/88>
  28:   5a                        pop    %edx
Code;  c0138c30 <find_lock_page+24/88>
  29:   74 56                     je     81 <_EIP+0x81>

This decode from eip onwards should be reliable

Code;  c0138c32 <find_lock_page+26/88>
00000000 <_EIP>:
Code;  c0138c32 <find_lock_page+26/88>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0138c34 <find_lock_page+28/88>
   2:   89 da                     mov    %ebx,%edx
Code;  c0138c36 <find_lock_page+2a/88>
   4:   f6 c4 40                  test   $0x40,%ah
Code;  c0138c39 <find_lock_page+2d/88>
   7:   74 03                     je     c <_EIP+0xc>
Code;  c0138c3b <find_lock_page+2f/88>
   9:   8b 53 0c                  mov    0xc(%ebx),%edx
Code;  c0138c3e <find_lock_page+32/88>
   c:   f0 ff 42 04               lock incl 0x4(%edx)
Code;  c0138c42 <find_lock_page+36/88>
  10:   f0 0f ba 2b 00            lock btsl $0x0,(%ebx)






Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c019fba5>]    Not tainted VLI
EFLAGS: 00010206   (2.6.15-025stab014)
eax: 00104029   ebx: 4324772d   ecx: c81fb2a8   edx: e77de4e4
esi: c81fb2a8   edi: c16194c4   ebp: e77de4e4   esp: c1bf9dd4
ds: 007b   es: 007b   ss: 0068
Stack: e77de4e4 c81fb2a8 c019af85 c81fb2a8 f6ff0400 e77de4e4 00000000
c16194c4
       f6ff0400 f0f7ea60 c1bf9f34 c018cf4b f6ff0400 c16194c4 000000d0
f0f7ea60
       c16194c4 c014244c c16194c4 000000d0 00000001 00000001 00000011
00000000
Call Trace:
 [<c019af85>] journal_try_to_free_buffers+0x88/0xc3
 [<c018cf4b>] ext3_releasepage+0x59/0x63
 [<c014244c>] shrink_list+0x259/0x3ab
 [<c014273e>] shrink_cache+0xff/0x24b
 [<c0142d8d>] shrink_zone+0xab/0xc4
 [<c01432b2>] balance_pgdat+0x209/0x35f
 [<c01434f6>] kswapd+0xee/0xf3
 [<c012b5fe>] autoremove_wake_function+0x0/0x3a
 [<c010274e>] ret_from_fork+0x6/0x14
 [<c012b5fe>] autoremove_wake_function+0x0/0x3a
 [<c0143408>] kswapd+0x0/0xf3
 [<c0100f35>] kernel_thread_helper+0x5/0xb
Code: a9 00 00 20 00 75 08 0f 0b 36 00 f9 4b 2a c0 f0 0f ba 33 15 5b c3
56 53 8b 74 24 0c 8b 1e eb 0b f3 90 8b 03 a9 00 00 20 00 75 f5 <f0> 0f
ba 2b 15 19 c0 85 c0 75 ec 83 7e 04 00 7f 29 68 f3 9d 2a


>>EIP; c019fba5 <journal_put_journal_head+15/87>   <=====

>>eax; 00104029 <phys_startup_32+4029/c0000000>
>>ebx; 4324772d <phys_startup_32+4314772d/c0000000>
>>ecx; c81fb2a8 <pg0+7e782a8/3fc7b400>
>>edx; e77de4e4 <pg0+2745b4e4/3fc7b400>
>>esi; c81fb2a8 <pg0+7e782a8/3fc7b400>
>>edi; c16194c4 <pg0+12964c4/3fc7b400>
>>ebp; e77de4e4 <pg0+2745b4e4/3fc7b400>
>>esp; c1bf9dd4 <pg0+1876dd4/3fc7b400>

Trace; c019af85 <journal_try_to_free_buffers+88/c3>
Trace; c018cf4b <ext3_releasepage+59/63>
Trace; c014244c <shrink_list+259/3ab>
Trace; c014273e <shrink_cache+ff/24b>
Trace; c0142d8d <shrink_zone+ab/c4>
Trace; c01432b2 <balance_pgdat+209/35f>
Trace; c01434f6 <kswapd+ee/f3>
Trace; c012b5fe <autoremove_wake_function+0/3a>
Trace; c010274e <ret_from_fork+6/14>
Trace; c012b5fe <autoremove_wake_function+0/3a>
Trace; c0143408 <kswapd+0/f3>
Trace; c0100f35 <kernel_thread_helper+5/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c019fb7a <journal_remove_journal_head+26/3c>
00000000 <_EIP>:
Code;  c019fb7a <journal_remove_journal_head+26/3c>
   0:   a9 00 00 20 00            test   $0x200000,%eax
Code;  c019fb7f <journal_remove_journal_head+2b/3c>
   5:   75 08                     jne    f <_EIP+0xf>
Code;  c019fb81 <journal_remove_journal_head+2d/3c>
   7:   0f 0b                     ud2a
Code;  c019fb83 <journal_remove_journal_head+2f/3c>
   9:   36                        ss
Code;  c019fb84 <journal_remove_journal_head+30/3c>
   a:   00 f9                     add    %bh,%cl
Code;  c019fb86 <journal_remove_journal_head+32/3c>
   c:   4b                        dec    %ebx
Code;  c019fb87 <journal_remove_journal_head+33/3c>
   d:   2a c0                     sub    %al,%al
Code;  c019fb89 <journal_remove_journal_head+35/3c>
   f:   f0 0f ba 33 15            lock btrl $0x15,(%ebx)
Code;  c019fb8e <journal_remove_journal_head+3a/3c>
  14:   5b                        pop    %ebx
Code;  c019fb8f <journal_remove_journal_head+3b/3c>
  15:   c3                        ret
Code;  c019fb90 <journal_put_journal_head+0/87>
  16:   56                        push   %esi
Code;  c019fb91 <journal_put_journal_head+1/87>
  17:   53                        push   %ebx
Code;  c019fb92 <journal_put_journal_head+2/87>
  18:   8b 74 24 0c               mov    0xc(%esp),%esi
Code;  c019fb96 <journal_put_journal_head+6/87>
  1c:   8b 1e                     mov    (%esi),%ebx
Code;  c019fb98 <journal_put_journal_head+8/87>
  1e:   eb 0b                     jmp    2b <_EIP+0x2b>
Code;  c019fb9a <journal_put_journal_head+a/87>
  20:   f3 90                     pause
Code;  c019fb9c <journal_put_journal_head+c/87>
  22:   8b 03                     mov    (%ebx),%eax
Code;  c019fb9e <journal_put_journal_head+e/87>
  24:   a9 00 00 20 00            test   $0x200000,%eax
Code;  c019fba3 <journal_put_journal_head+13/87>
  29:   75 f5                     jne    20 <_EIP+0x20>

This decode from eip onwards should be reliable

Code;  c019fba5 <journal_put_journal_head+15/87>
00000000 <_EIP>:
Code;  c019fba5 <journal_put_journal_head+15/87>   <=====
   0:   f0 0f ba 2b 15            lock btsl $0x15,(%ebx)   <=====
Code;  c019fbaa <journal_put_journal_head+1a/87>
   5:   19 c0                     sbb    %eax,%eax
Code;  c019fbac <journal_put_journal_head+1c/87>
   7:   85 c0                     test   %eax,%eax
Code;  c019fbae <journal_put_journal_head+1e/87>
   9:   75 ec                     jne    fffffff7 <_EIP+0xfffffff7>
Code;  c019fbb0 <journal_put_journal_head+20/87>
   b:   83 7e 04 00               cmpl   $0x0,0x4(%esi)
Code;  c019fbb4 <journal_put_journal_head+24/87>
   f:   7f 29                     jg     3a <_EIP+0x3a>
Code;  c019fbb6 <journal_put_journal_head+26/87>
  11:   68                        .byte 0x68
Code;  c019fbb7 <journal_put_journal_head+27/87>
  12:   f3 9d                     repz popf
Code;  c019fbb9 <journal_put_journal_head+29/87>
  14:   2a                        .byte 0x2a

Kernel panic - not syncing: Fatal exception


