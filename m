Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTANNGi>; Tue, 14 Jan 2003 08:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTANNGi>; Tue, 14 Jan 2003 08:06:38 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:18457 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S262796AbTANNGf>; Tue, 14 Jan 2003 08:06:35 -0500
Date: Tue, 14 Jan 2003 14:15:26 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: ext3-users@redhat.com
Cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: 2.4.21-pre3 - problems with ext3
Message-ID: <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Since 2.4.20, we have problems with ext3. Machine is 2xPentium III (1GHz),
2GB RAM, 1GB swap. RH 8.0 (glibc-2.3.1-21), gcc (GCC) 3.2 20020903

We have a lot of users:

oceanic:~# wc -l /etc/passwd
   6694 /etc/passwd

connected via SAMBA (2.2.7) from 200-300 Windows-XX workstations

Partition with ext3 looks like this:

oceanic:~# mount |grep ext3
/dev/sdb5 on /home1 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdb6 on /home2 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdc5 on /home3 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdc6 on /home4 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdc7 on /home5 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdc8 on /home6 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdb7 on /home7 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdb8 on /home8 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdd5 on /home9 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdd6 on /homea type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdd7 on /homeb type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdd8 on /homec type ext3 (rw,nosuid,nodev,usrquota)
/dev/sda7 on /opt/windows type ext3 (rw,nosuid,nodev)



My question is:
Is it a problem with ext3 or problems with disk (hardware problem) or 
something else?

Oops looks like this:


ksymoops 2.4.5 on i686 2.4.21-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3/ (default)
     -m /boot/System.map-2.4.21-pre3 (default)

Jan 14 12:53:52 oceanic kernel: EIP:    0010:[<f88ab5df>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 14 12:53:52 oceanic kernel: EFLAGS: 00010282
Jan 14 12:53:52 oceanic kernel: eax: 0000007a   ebx: efeed7a0   ecx: 00000092   edx: e9925f7c
Jan 14 12:53:52 oceanic kernel: esi: ef818000   edi: f7719000   ebp: 00000020   esp: ef819b74
Jan 14 12:53:52 oceanic kernel: ds: 0018   es: 0018   ss: 0018
Jan 14 12:53:52 oceanic kernel: Process smbd (pid: 7566, stackpage=ef819000)
Jan 14 12:53:52 oceanic kernel: Stack: f88b5be0 f88b5063 f88b4ff4 000000f9 f88b5da0 efeed7a0 f758e2c0 f758e2c0 
Jan 14 12:53:52 oceanic kernel:        f88c4bc0 f7719000 00000001 f7b73218 00000002 00000001 f758e2c0 f7638c00 
Jan 14 12:53:52 oceanic kernel:        c0157ff5 f758e2c0 f758e2c0 f7638c00 ffffffff c0131f7a f758e2c0 00000001 
Jan 14 12:53:52 oceanic kernel: Call Trace:    [<f88b5be0>] [<f88b5063>] [<f88b4ff4>] [<f88b5da0>] [<f88c4bc0>]
Jan 14 12:53:52 oceanic kernel:   [<c0157ff5>] [<c0131f7a>] [<c01de57f>] [<c0138bb5>] [<f88bf0c9>] [<c015e991>]
Jan 14 12:53:52 oceanic kernel:   [<c015ee7c>] [<c015ff11>] [<c01586ce>] [<c01587ac>] [<c0156590>] [<c0158a42>]
Jan 14 12:53:52 oceanic kernel:   [<c0158af4>] [<c0137323>] [<c0137386>] [<c01382d2>] [<c0138564>] [<c012f9b6>]
Jan 14 12:53:52 oceanic kernel:   [<f88b44dc>] [<f88c2c75>] [<f88ab55b>] [<f88ab625>] [<f88c0b44>] [<f88c3858>]
Jan 14 12:53:52 oceanic kernel:   [<c020c28c>] [<c0209fe1>] [<c012c063>] [<c0159c76>] [<f88c473c>] [<c024601e>]
Jan 14 12:53:52 oceanic kernel:   [<c0159fce>] [<c013e2e6>] [<c0148bb3>] [<c013f98d>] [<c013e397>] [<c010770f>]
Jan 14 12:53:52 oceanic kernel: Code: 0f 0b f9 00 f4 4f 8b f8 ff 43 08 89 d8 8b 5c 24 14 8b 74 24 


>>EIP; f88ab5df <[jbd]journal_start+5f/c0>   <=====

>>ebx; efeed7a0 <___strtok+2fb896e0/38546fa0>
>>edx; e9925f7c <___strtok+295c1ebc/38546fa0>
>>esi; ef818000 <___strtok+2f4b3f40/38546fa0>
>>edi; f7719000 <___strtok+373b4f40/38546fa0>
>>esp; ef819b74 <___strtok+2f4b5ab4/38546fa0>

Trace; f88b5be0 <[jbd]__kstrtab_journal_enable_debug+651/5be5>
Trace; f88b5063 <[jbd]__ksymtab_journal_enable_debug+1f/28>
Trace; f88b4ff4 <[jbd]__ksymtab_journal_ack_err+0/8>
Trace; f88b5da0 <[jbd]__kstrtab_journal_enable_debug+811/5be5>
Trace; f88c4bc0 <[ext3]ext3_dirty_inode+160/180>
Trace; c0157ff5 <__mark_inode_dirty+b5/4e0>
Trace; c0131f7a <generic_file_write+2ba/2bb0>
Trace; c01de57f <scsi_io_completion+16f/850>
Trace; c0138bb5 <free_pages+535/27c0>
Trace; f88bf0c9 <[ext3]ext3_file_write+39/d0>
Trace; c015e991 <seq_printf+f01/a9c0>
Trace; c015ee7c <seq_printf+13ec/a9c0>
Trace; c015ff11 <seq_printf+2481/a9c0>
Trace; c01586ce <clear_inode+8e/260>
Trace; c01587ac <clear_inode+16c/260>
Trace; c0156590 <dput+30/190>
Trace; c0158a42 <invalidate_device+102/240>
Trace; c0158af4 <invalidate_device+1b4/240>
Trace; c0137323 <kmem_find_general_cachep+1583/24b0>
Trace; c0137386 <kmem_find_general_cachep+15e6/24b0>
Trace; c01382d2 <_alloc_pages+82/210>
Trace; c0138564 <__alloc_pages+104/1a0>
Trace; c012f9b6 <find_or_create_page+86/110>
Trace; f88b44dc <[jbd]__jbd_kmalloc+2c/c0>
Trace; f88c2c75 <[ext3]ext3_block_truncate_page+85/490>
Trace; f88ab55b <[jbd]new_handle+4b/70>
Trace; f88ab625 <[jbd]journal_start+a5/c0>
Trace; f88c0b44 <[ext3]start_transaction+94/a0>
Trace; f88c3858 <[ext3]ext3_truncate+d8/480>
Trace; c020c28c <skb_copy_datagram_iovec+4c/690>
Trace; c0209fe1 <alloc_skb+361/370>
Trace; c012c063 <vmtruncate+d3/9e0>
Trace; c0159c76 <inode_setattr+106/190>
Trace; f88c473c <[ext3]ext3_setattr+25c/320>
Trace; c024601e <inet_recvmsg_R__ver_inet_recvmsg+4e/70>
Trace; c0159fce <notify_change+2ce/350>
Trace; c013e2e6 <fd_install+b6/b70>
Trace; c0148bb3 <cdput+8c3/bb0>
Trace; c013f98d <generic_file_open+55d/650>
Trace; c013e397 <fd_install+167/b70>
Trace; c010770f <__read_lock_failed+144b/183c>

Code;  f88ab5df <[jbd]journal_start+5f/c0>
00000000 <_EIP>:
Code;  f88ab5df <[jbd]journal_start+5f/c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f88ab5e1 <[jbd]journal_start+61/c0>
   2:   f9                        stc    
Code;  f88ab5e2 <[jbd]journal_start+62/c0>
   3:   00 f4                     add    %dh,%ah
Code;  f88ab5e4 <[jbd]journal_start+64/c0>
   5:   4f                        dec    %edi
Code;  f88ab5e5 <[jbd]journal_start+65/c0>
   6:   8b f8                     mov    %eax,%edi
Code;  f88ab5e7 <[jbd]journal_start+67/c0>
   8:   ff 43 08                  incl   0x8(%ebx)
Code;  f88ab5ea <[jbd]journal_start+6a/c0>
   b:   89 d8                     mov    %ebx,%eax
Code;  f88ab5ec <[jbd]journal_start+6c/c0>
   d:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  f88ab5f0 <[jbd]journal_start+70/c0>
  11:   8b 74 24 00               mov    0x0(%esp,1),%esi


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
