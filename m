Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbTAUAQw>; Mon, 20 Jan 2003 19:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbTAUAQw>; Mon, 20 Jan 2003 19:16:52 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:29480 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S261506AbTAUAQr>; Mon, 20 Jan 2003 19:16:47 -0500
Date: Tue, 21 Jan 2003 01:25:47 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: akpm@zip.com.au, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org,
       Bartlomiej Solarz-Niesluchowski <solarz@wsisiz.edu.pl>
Subject: Re: 2.4.21-pre3 - problems with ext3 (long)
In-Reply-To: <1043102297.13050.59.camel@sisko.scot.redhat.com>
Message-ID: <Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl>
References: <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
 <1043102297.13050.59.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, Stephen C. Tweedie wrote:

> > Since 2.4.20, we have problems with ext3. Machine is 2xPentium III (1GHz),
> > 2GB RAM, 1GB swap. RH 8.0 (glibc-2.3.1-21), gcc (GCC) 3.2 20020903
> 
> So it was stable under earlier kernels?

Yes, it was stable.

Some plays with zcat messages.*.gz |grep "Assertion failure":

system boot  2.4.21-pre3
Jan 14 12:53:52 oceanic kernel: Assertion failure in journal_start_Rsmp_909c88ec
() at transaction.c:249: "handle->h_transaction->t_journal == journal"

system boot  2.4.21-pre2
Jan 10 13:00:11 oceanic kernel: Assertion failure in journal_start_Rsmp_c2be780a
() at transaction.c:248: "handle->h_transaction->t_journal == journal"

system boot  2.4.20:
Dec 15 15:27:01 oceanic kernel: Assertion failure in journal_start_Rsmp_c2be780a
() at transaction.c:248: "handle->h_transaction->t_journal == journal


With earlier kernels 2.4.X (for example 2.4.20-rc2) this machine has much 
longer uptime.

[...]
> But as for the decoded OOPS, I can't immediately trace through it
> successfully.  There's no syscall entry point at the top of the stack,
> and there appear to be two separate possible interpretations of the call
> trace.  Do you have any other captured oopses that I might be able to
> find some common threads in?


By the way, last crash was with messages:

Jan 19 11:50:20 oceanic kernel: kernel BUG at highmem.c:159!
Jan 19 11:50:20 oceanic kernel: invalid operand: 0000
Jan 19 11:50:20 oceanic kernel: CPU:    1

But, that's all what was in log files.


There is two earlier oopses, if you want,  can send to you fragments 
directly from log files - not output from ksymoops. All oopses came from
smbd process. ( samba-2.2.7-1.7.3 from RH updates). 


oopses 1:

ksymoops 2.4.5 on i686 2.4.21-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre2/System.map (specified)
     -m /boot/System.map-2.4.21-pre3 (default)

Jan 10 13:00:11 oceanic kernel: kernel BUG at transaction.c:248!
Jan 10 13:00:11 oceanic kernel: invalid operand: 0000
Jan 10 13:00:11 oceanic kernel: CPU:    1
Jan 10 13:00:11 oceanic kernel: EIP:    0010:[<f88ab368>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 10 13:00:11 oceanic kernel: EFLAGS: 00010296
Jan 10 13:00:11 oceanic kernel: eax: 0000007a   ebx: e03e2420   ecx: ea894000   edx: f744df44
Jan 10 13:00:11 oceanic kernel: esi: f7b59400   edi: ea894000   ebp: d73bc960   esp: ea8959e4
Jan 10 13:00:11 oceanic kernel: ds: 0018   es: 0018   ss: 0018
Jan 10 13:00:11 oceanic kernel: Process smbd (pid: 13129, stackpage=ea895000)
Jan 10 13:00:11 oceanic kernel: Stack: f88b2300 f88b3ffb f88b3fd0 000000f8 f88b23a0 e03e2420 ffffffe2 f7563d60 
Jan 10 13:00:11 oceanic kernel:        f88bf7ae f7b59400 00000001 0076c129 00000400 ec001e60 f76a51a0 ea895a48 
Jan 10 13:00:11 oceanic kernel:        00000000 00000000 f76ed400 f7563d60 f7b58c00 00000001 c014dc02 f7563d60 
Jan 10 13:00:11 oceanic kernel: Call Trace:    [<f88b2300>] [<f88b3ffb>] [<f88b3fd0>] [<f88b23a0>] [<f88bf7ae>]
Jan 10 13:00:11 oceanic kernel:   [<c014dc02>] [<c012c337>] [<f88abd0e>] [<c01a385a>] [<c0129882>] [<c0132555>]
Jan 10 13:00:11 oceanic kernel:   [<f88babc2>] [<c0153abb>] [<c0153f50>] [<c0154e9b>] [<c014e797>] [<c014da7d>]
Jan 10 13:00:11 oceanic kernel:   [<c014e86d>] [<c014eaed>] [<c014eb30>] [<c01312fe>] [<c013135c>] [<c0131e52>]
Jan 10 13:00:11 oceanic kernel:   [<c013210b>] [<c0129db8>] [<f88bdd75>] [<f88bcc6e>] [<c021445f>] [<c0209b59>]
Jan 10 13:00:11 oceanic kernel:   [<c013aeb8>] [<f88b3ff0>] [<f88b1c17>] [<f88ab285>] [<f88ab39d>] [<f88be710>]
Jan 10 13:00:11 oceanic kernel:   [<f88bc198>] [<f88be710>] [<f88be7c9>] [<c01eea7d>] [<c020abf5>] [<f88be710>]
Jan 10 13:00:11 oceanic kernel:   [<c0126d99>] [<c014f836>] [<f88bf525>] [<c01eb561>] [<c0132170>] [<c014f9d9>]
Jan 10 13:00:11 oceanic kernel:   [<c01eb668>] [<c01374a7>] [<c0137b22>] [<c01070c3>]
Jan 10 13:00:11 oceanic kernel: Code: 0f 0b f8 00 d0 3f 8b f8 83 c4 14 ff 43 08 eb 40 8b 4c 24 14 


>>EIP; f88ab368 <[jbd].text.start+308/9ea9>   <=====

>>ebx; e03e2420 <___strtok+2007e360/38546fa0>
>>ecx; ea894000 <___strtok+2a52ff40/38546fa0>
>>edx; f744df44 <___strtok+370e9e84/38546fa0>
>>esi; f7b59400 <___strtok+377f5340/38546fa0>
>>edi; ea894000 <___strtok+2a52ff40/38546fa0>
>>ebp; d73bc960 <___strtok+170588a0/38546fa0>
>>esp; ea8959e4 <___strtok+2a531924/38546fa0>

Trace; f88b2300 <[jbd].text.start+72a0/9ea9>
Trace; f88b3ffb <[jbd].text.start+8f9b/9ea9>
Trace; f88b3fd0 <[jbd].text.start+8f70/9ea9>
Trace; f88b23a0 <[jbd].text.start+7340/9ea9>
Trace; f88bf7ae <[ext3].text.start+274e/dc9d>
Trace; c014dc02 <vfs_mkdir+232/350>
Trace; c012c337 <vmtruncate+3a7/9e0>
Trace; f88abd0e <[jbd].text.start+cae/9ea9>
Trace; c01a385a <vc_resize+170a/3a40>
Trace; c0129882 <in_egroup_p+922/c70>
Trace; c0132555 <generic_file_write+895/2bb0>
Trace; f88babc2 <[jbd].rodata.end+5bdf/6191>
Trace; c0153abb <locks_copy_lock+72b/a30>
Trace; c0153f50 <posix_locks_deadlock+f0/110>
Trace; c0154e9b <lease_get_mtime+fb/e60>
Trace; c014e797 <vfs_symlink+257/2c0>
Trace; c014da7d <vfs_mkdir+ad/350>
Trace; c014e86d <vfs_link+6d/da0>
Trace; c014eaed <vfs_link+2ed/da0>
Trace; c014eb30 <vfs_link+330/da0>
Trace; c01312fe <generic_file_mmap+40e/d20>
Trace; c013135c <generic_file_mmap+46c/d20>
Trace; c0131e52 <generic_file_write+192/2bb0>
Trace; c013210b <generic_file_write+44b/2bb0>
Trace; c0129db8 <exec_usermodehelper+1e8/210>
Trace; f88bdd75 <[ext3].text.start+d15/dc9d>
Trace; f88bcc6e <[jbd].bss.end+1ac7/1eb9>
Trace; c021445f <__rta_fill+9f/150>
Trace; c0209b59 <sock_init_data+2e9/370>
Trace; c013aeb8 <alloc_pages_node+78/2480>
Trace; f88b3ff0 <[jbd].text.start+8f90/9ea9>
Trace; f88b1c17 <[jbd].text.start+6bb7/9ea9>
Trace; f88ab285 <[jbd].text.start+225/9ea9>
Trace; f88ab39d <[jbd].text.start+33d/9ea9>
Trace; f88be710 <[ext3].text.start+16b0/dc9d>
Trace; f88bc198 <[jbd].bss.end+ff1/1eb9>
Trace; f88be710 <[ext3].text.start+16b0/dc9d>
Trace; f88be7c9 <[ext3].text.start+1769/dc9d>
Trace; c01eea7d <scsi_free+e33d/1c220>
Trace; c020abf5 <__pskb_pull_tail+115/300>
Trace; f88be710 <[ext3].text.start+16b0/dc9d>
Trace; c0126d99 <notify_parent+599/d50>
Trace; c014f836 <vfs_follow_link+b6/d0>
Trace; f88bf525 <[ext3].text.start+24c5/dc9d>
Trace; c01eb561 <scsi_free+ae21/1c220>
Trace; c0132170 <generic_file_write+4b0/2bb0>
Trace; c014f9d9 <page_follow_link+e9/15e0>
Trace; c01eb668 <scsi_free+af28/1c220>
Trace; c01374a7 <kmem_find_general_cachep+1707/24b0>
Trace; c0137b22 <kmem_find_general_cachep+1d82/24b0>
Trace; c01070c3 <__read_lock_failed+dff/183c>

Code;  f88ab368 <[jbd].text.start+308/9ea9>
00000000 <_EIP>:
Code;  f88ab368 <[jbd].text.start+308/9ea9>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f88ab36a <[jbd].text.start+30a/9ea9>
   2:   f8                        clc    
Code;  f88ab36b <[jbd].text.start+30b/9ea9>
   3:   00 d0                     add    %dl,%al
Code;  f88ab36d <[jbd].text.start+30d/9ea9>
   5:   3f                        aas    
Code;  f88ab36e <[jbd].text.start+30e/9ea9>
   6:   8b f8                     mov    %eax,%edi
Code;  f88ab370 <[jbd].text.start+310/9ea9>
   8:   83 c4 14                  add    $0x14,%esp
Code;  f88ab373 <[jbd].text.start+313/9ea9>
   b:   ff 43 08                  incl   0x8(%ebx)
Code;  f88ab376 <[jbd].text.start+316/9ea9>
   e:   eb 40                     jmp    50 <_EIP+0x50>
Code;  f88ab378 <[jbd].text.start+318/9ea9>
  10:   8b 4c 24 14               mov    0x14(%esp,1),%ecx

oopses 2:

ksymoops 2.4.5 on i686 2.4.21-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/System.map (specified)
     -m /boot/System.map-2.4.21-pre3 (default)
Dec 15 15:27:01 oceanic kernel: Kernel panic: EXT3-fs panic (device sd(8,23)): load_block_bitmap: block_group >= groups_count - block_group = 524287, groups_count = 2126
Dec 15 15:27:01 oceanic kernel: kernel BUG at transaction.c:248!
Dec 15 15:27:01 oceanic kernel: invalid operand: 0000
Dec 15 15:27:01 oceanic kernel: CPU:    0
Dec 15 15:27:01 oceanic kernel: EIP:    0010:[<f88ab368>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 15 15:27:01 oceanic kernel: EFLAGS: 00010202
Dec 15 15:27:01 oceanic kernel: eax: 0000007a   ebx: f5c4fd40   ecx: c029e0c0   edx: 00018765
Dec 15 15:27:01 oceanic kernel: esi: f7b57000   edi: f7530000   ebp: f6295920   esp: f753178c
Dec 15 15:27:01 oceanic kernel: ds: 0018   es: 0018   ss: 0018
Dec 15 15:27:01 oceanic kernel: Process smbd (pid: 21636, stackpage=f7531000)
Dec 15 15:27:01 oceanic kernel: Stack: f88b2300 f88b3ffb f88b3fd0 000000f8 f88b23a0 f5c4fd40 ffffffe2 f77020c0 
Dec 15 15:27:01 oceanic kernel:        f88bf7de f7b57000 00000001 c013afe6 d585ae60 c013bc31 00000400 00000000 
Dec 15 15:27:01 oceanic kernel:        00014140 00000000 c2382900 f77020c0 f7b56800 00000001 c014db12 f77020c0 
Dec 15 15:27:01 oceanic kernel: Call Trace:    [<f88b2300>] [<f88b3ffb>] [<f88b3fd0>] [<f88b23a0>] [<f88bf7de>]
Dec 15 15:27:01 oceanic kernel:   [<c013afe6>] [<c013bc31>] [<c014db12>] [<c012c2f7>] [<c012c4e0>] [<c013b188>]
Dec 15 15:27:01 oceanic kernel:   [<c0199cfb>] [<f88babc2>] [<c0153aeb>] [<c0153dac>] [<c013a1d3>] [<c013a40e>]
Dec 15 15:27:01 oceanic kernel:   [<f88c7320>] [<c013a467>] [<c0117599>] [<f88c247f>] [<f88c5e40>] [<f88c7320>]
Dec 15 15:27:01 oceanic kernel:   [<f88c9540>] [<f88c9540>] [<f88c4960>] [<f88b919d>] [<f88c7320>] [<f88c4960>]
Dec 15 15:27:01 oceanic kernel:   [<c014db12>] [<f88b9452>] [<f88bf229>] [<f88bf287>] [<f88abd6f>] [<f88bf6b1>]
Dec 15 15:27:01 oceanic kernel:   [<f88bf645>] [<f88bf656>] [<f88bf757>] [<f88bf819>] [<f88ac466>] [<f88bc0f3>]
Dec 15 15:27:01 oceanic kernel:   [<c01fefb2>] [<f88be345>] [<f88aff50>] [<f88abd0e>] [<f88b1d40>] [<f88be42c>]
Dec 15 15:27:01 oceanic kernel:   [<c01c35d2>] [<f88abd0e>] [<c01b72bc>] [<f88be72f>] [<c011c6ed>] [<c013a04e>]
Dec 15 15:27:01 oceanic kernel:   [<c013af18>] [<c013b1b6>] [<f88be5d6>] [<c013af18>] [<f88abd0e>] [<f88bf645>]
Dec 15 15:27:01 oceanic kernel:   [<f88bf656>] [<f88be9c5>] [<f88b3ff0>] [<f88b1c27>] [<f88ab285>] [<f88ab39d>]
Dec 15 15:27:01 oceanic kernel:   [<f88bc1c8>] [<f88ac705>] [<f88bc35c>] [<f88bc280>] [<f88bc280>] [<c014f178>]
Dec 15 15:27:01 oceanic kernel:   [<c014d216>] [<c014551e>] [<c0143090>] [<c01440ba>] [<c01455d9>] [<c01070c3>]
Dec 15 15:27:01 oceanic kernel: Code: 0f 0b f8 00 d0 3f 8b f8 83 c4 14 ff 43 08 eb 40 8b 4c 24 14 


>>EIP; f88ab368 <[jbd].text.start+308/9ea9>   <=====

>>ebx; f5c4fd40 <___strtok+358ebc80/38546fa0>
>>ecx; c029e0c0 <scsi_device_types+374a0/43060>
>>edx; 00018765 Before first symbol
>>esi; f7b57000 <___strtok+377f2f40/38546fa0>
>>edi; f7530000 <___strtok+371cbf40/38546fa0>
>>ebp; f6295920 <___strtok+35f31860/38546fa0>
>>esp; f753178c <___strtok+371cd6cc/38546fa0>

Trace; f88b2300 <[jbd].text.start+72a0/9ea9>
Trace; f88b3ffb <[jbd].text.start+8f9b/9ea9>
Trace; f88b3fd0 <[jbd].text.start+8f70/9ea9>
Trace; f88b23a0 <[jbd].text.start+7340/9ea9>
Trace; f88bf7de <[ext3].text.start+277e/dc9d>
Trace; c013afe6 <alloc_pages_node+1a6/2480>
Trace; c013bc31 <alloc_pages_node+df1/2480>
Trace; c014db12 <vfs_mkdir+142/350>
Trace; c012c2f7 <vmtruncate+367/9e0>
Trace; c012c4e0 <vmtruncate+550/9e0>
Trace; c013b188 <alloc_pages_node+348/2480>
Trace; c0199cfb <n_tty_ioctl+76b/19e0>
Trace; f88babc2 <[jbd].rodata.end+5bdf/6191>
Trace; c0153aeb <locks_copy_lock+75b/a30>
Trace; c0153dac <locks_copy_lock+a1c/a30>
Trace; c013a1d3 <free_pages+1b53/27c0>
Trace; c013a40e <free_pages+1d8e/27c0>
Trace; f88c7320 <[ext3].text.start+a2c0/dc9d>
Trace; c013a467 <free_pages+1de7/27c0>
Trace; c0117599 <change_page_attr+e9/3c0>
Trace; f88c247f <[ext3].text.start+541f/dc9d>
Trace; f88c5e40 <[ext3].text.start+8de0/dc9d>
Trace; f88c7320 <[ext3].text.start+a2c0/dc9d>
Trace; f88c9540 <[ext3].text.start+c4e0/dc9d>
Trace; f88c9540 <[ext3].text.start+c4e0/dc9d>
Trace; f88c4960 <[ext3].text.start+7900/dc9d>
Trace; f88b919d <[jbd].rodata.end+41ba/6191>
Trace; f88c7320 <[ext3].text.start+a2c0/dc9d>
Trace; f88c4960 <[ext3].text.start+7900/dc9d>
Trace; c014db12 <vfs_mkdir+142/350>
Trace; f88b9452 <[jbd].rodata.end+446f/6191>
Trace; f88bf229 <[ext3].text.start+21c9/dc9d>
Trace; f88bf287 <[ext3].text.start+2227/dc9d>
Trace; f88abd6f <[jbd].text.start+d0f/9ea9>
Trace; f88bf6b1 <[ext3].text.start+2651/dc9d>
Trace; f88bf645 <[ext3].text.start+25e5/dc9d>
Trace; f88bf656 <[ext3].text.start+25f6/dc9d>
Trace; f88bf757 <[ext3].text.start+26f7/dc9d>
Trace; f88bf819 <[ext3].text.start+27b9/dc9d>
Trace; f88ac466 <[jbd].text.start+1406/9ea9>
Trace; f88bc0f3 <[jbd].bss.end+f4c/1eb9>
Trace; c01fefb2 <cdrom_ioctl+652/1b60>
Trace; f88be345 <[ext3].text.start+12e5/dc9d>
Trace; f88aff50 <[jbd].text.start+4ef0/9ea9>
Trace; f88abd0e <[jbd].text.start+cae/9ea9>
Trace; f88b1d40 <[jbd].text.start+6ce0/9ea9>
Trace; f88be42c <[ext3].text.start+13cc/dc9d>
Trace; c01c35d2 <ide_taskfile_ioctl+302/550>
Trace; f88abd0e <[jbd].text.start+cae/9ea9>
Trace; c01b72bc <get_gendisk+62ec/ad20>
Trace; f88be72f <[ext3].text.start+16cf/dc9d>
Trace; c011c6ed <inter_module_put+5fd/900>
Trace; c013a04e <free_pages+19ce/27c0>
Trace; c013af18 <alloc_pages_node+d8/2480>
Trace; c013b1b6 <alloc_pages_node+376/2480>
Trace; f88be5d6 <[ext3].text.start+1576/dc9d>
Trace; c013af18 <alloc_pages_node+d8/2480>
Trace; f88abd0e <[jbd].text.start+cae/9ea9>
Trace; f88bf645 <[ext3].text.start+25e5/dc9d>
Trace; f88bf656 <[ext3].text.start+25f6/dc9d>
Trace; f88be9c5 <[ext3].text.start+1965/dc9d>
Trace; f88b3ff0 <[jbd].text.start+8f90/9ea9>
Trace; f88b1c27 <[jbd].text.start+6bc7/9ea9>
Trace; f88ab285 <[jbd].text.start+225/9ea9>
Trace; f88ab39d <[jbd].text.start+33d/9ea9>
Trace; f88bc1c8 <[jbd].bss.end+1021/1eb9>
Trace; f88ac705 <[jbd].text.start+16a5/9ea9>
Trace; f88bc35c <[jbd].bss.end+11b5/1eb9>
Trace; f88bc280 <[jbd].bss.end+10d9/1eb9>
Trace; f88bc280 <[jbd].bss.end+10d9/1eb9>
Trace; c014f178 <vfs_link+978/da0>
Trace; c014d216 <vfs_create+4e6/8f0>
Trace; c014551e <set_buffer_async_io+5e/330>
Trace; c0143090 <create_empty_buffers+3a0/720>
Trace; c01440ba <block_write_full_page+12a/140>
Trace; c01455d9 <set_buffer_async_io+119/330>
Trace; c01070c3 <__read_lock_failed+dff/183c>

Code;  f88ab368 <[jbd].text.start+308/9ea9>
00000000 <_EIP>:
Code;  f88ab368 <[jbd].text.start+308/9ea9>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f88ab36a <[jbd].text.start+30a/9ea9>
   2:   f8                        clc    
Code;  f88ab36b <[jbd].text.start+30b/9ea9>
   3:   00 d0                     add    %dl,%al
Code;  f88ab36d <[jbd].text.start+30d/9ea9>
   5:   3f                        aas    
Code;  f88ab36e <[jbd].text.start+30e/9ea9>
   6:   8b f8                     mov    %eax,%edi
Code;  f88ab370 <[jbd].text.start+310/9ea9>
   8:   83 c4 14                  add    $0x14,%esp
Code;  f88ab373 <[jbd].text.start+313/9ea9>
   b:   ff 43 08                  incl   0x8(%ebx)
Code;  f88ab376 <[jbd].text.start+316/9ea9>
   e:   eb 40                     jmp    50 <_EIP+0x50>
Code;  f88ab378 <[jbd].text.start+318/9ea9>
  10:   8b 4c 24 14               mov    0x14(%esp,1),%ecx


Greetings

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
