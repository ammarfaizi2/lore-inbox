Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbTBFPfp>; Thu, 6 Feb 2003 10:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbTBFPfp>; Thu, 6 Feb 2003 10:35:45 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:36140 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S267331AbTBFPfm>; Thu, 6 Feb 2003 10:35:42 -0500
Message-Id: <5.2.0.9.0.20030206164445.030a3fd8@oceanic.wsisiz.edu.pl>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 06 Feb 2003 16:47:36 +0100
To: "Stephen C. Tweedie" <sct@redhat.com>
From: Bartlomiej Solarz-Niesluchowski 
	<B.Solarz-Niesluchowski@wsisiz.edu.pl>
Subject: Re: 2.4.21-pre3 - problems with ext3 (long)
Cc: Lukasz Trabinski <lukasz@wsisiz.edu.pl>, akpm@zip.com.au,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1043159893.2424.59.camel@sisko.scot.redhat.com>
References: <5.2.0.9.0.20030121152101.02c1e740@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
 <1043102297.13050.59.camel@sisko.scot.redhat.com>
 <Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl>
 <5.2.0.9.0.20030121152101.02c1e740@oceanic.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:38 2003-01-21 +0000, Stephen C. Tweedie wrote:
>Hi,
>
>On Tue, 2003-01-21 at 14:22, Bartlomiej Solarz-Niesluchowski wrote:
> > At 13:56 2003-01-21 +0000, Stephen C. Tweedie wrote:
> >
> > >If that happens again, serial console is the best way of getting the
> > >full oops.  How much memory does your system have?  Have you ever seen
> > >this error before?
> >
> > Yes - we have seen this error before.....
>
>Well, the kmap() bug looks like kunmap() being done twice on a page.  If
>that's happening, we really do need to find out where, so capturing that
>trace via serial console would be a _big_ help, thanks.

OK next OOPS in ext3 (now we have it at uptime 8.5 days and kernel 2.4.21-pre4)

Feb  6 15:10:52 oceanic kernel: Assertion failure in 
journal_start_Rsmp_909c88ec
() at transaction.c:249: "handle->h_transaction->t_journal == journal"

ksymoops 2.4.5 on i686 2.4.21-pre4.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.21-pre4/ (default)
      -m /lib/modules/2.4.21-pre4/System.map (specified)

Feb  6 15:10:52 oceanic kernel: kernel BUG at transaction.c:249!
Feb  6 15:10:52 oceanic kernel: invalid operand: 0000
Feb  6 15:10:52 oceanic kernel: CPU:    0
Feb  6 15:10:52 oceanic kernel: EIP:    0010:[<f88ab5df>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Feb  6 15:10:52 oceanic kernel: EFLAGS: 00010282
Feb  6 15:10:52 oceanic kernel: eax: 0000007a   ebx: ecf8b760   ecx: 
00000012   edx: f613ff7c
Feb  6 15:10:52 oceanic kernel: esi: cd456000   edi: f76e0c00   ebp: 
00000020   esp: cd457b74
Feb  6 15:10:52 oceanic kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 15:10:52 oceanic kernel: Process smbd (pid: 22109, stackpage=cd457000)
Feb  6 15:10:52 oceanic kernel: Stack: f88b5c00 f88b5083 f88b5014 000000f9 
f88b5dc0 ecf8b760 f7725620 f7725620
Feb  6 15:10:52 oceanic kernel:        f88c4bc0 f76e0c00 00000002 00000000 
f7baee18 00000001 f7725620 f76a4c00
Feb  6 15:10:52 oceanic kernel:        c0157f05 f7725620 f7725620 f76a4c00 
ffffffff c0131e6a f7725620 00000001
Feb  6 15:10:52 oceanic kernel: Call Trace:    [<f88b5c00>] [<f88b5083>] 
[<f88b5014>] [<f88b5dc0>] [<f88c4bc0>]
Feb  6 15:10:52 oceanic kernel:   [<c0157f05>] [<c0131e6a>] [<c01e3dec>] 
[<f88bf0c9>] [<c015e8a1>] [<c015ed8c>]
Feb  6 15:10:52 oceanic kernel:   [<c015fe21>] [<c01585de>] [<c01586bc>] 
[<c0158952>] [<c0158a04>] [<c0137223>]
Feb  6 15:10:52 oceanic kernel:   [<c0137286>] [<c01381d2>] [<c0138464>] 
[<c012f896>] [<f88b0018>] [<f88c2c75>]
Feb  6 15:10:52 oceanic kernel:   [<f88ab55b>] [<f88ab625>] [<f88c0b44>] 
[<f88c3858>] [<c020c57c>] [<c012bf43>]
Feb  6 15:10:52 oceanic kernel:   [<c0159b86>] [<f88c473c>] [<c024631e>] 
[<c0159ede>] [<c013e1e6>] [<c0148ab3>]
Feb  6 15:10:52 oceanic kernel:   [<c013f88d>] [<c013e297>] [<c010770f>]
Feb  6 15:10:52 oceanic kernel: Code: 0f 0b f9 00 14 50 8b f8 ff 43 08 89 
d8 8b 5c 24 14 8b 74 24


 >>EIP; f88ab5df <[jbd]journal_start+5f/c0>   <=====

 >>ebx; ecf8b760 <_end+2cc275bc/38546ebc>
 >>edx; f613ff7c <_end+35ddbdd8/38546ebc>
 >>esi; cd456000 <_end+d0f1e5c/38546ebc>
 >>edi; f76e0c00 <_end+3737ca5c/38546ebc>
 >>esp; cd457b74 <_end+d0f39d0/38546ebc>

Trace; f88b5c00 <[jbd]__kstrtab_journal_enable_debug+651/5be5>
Trace; f88b5083 <[jbd]__ksymtab_journal_enable_debug+1f/28>
Trace; f88b5014 <[jbd]__ksymtab_journal_ack_err+0/8>
Trace; f88b5dc0 <[jbd]__kstrtab_journal_enable_debug+811/5be5>
Trace; f88c4bc0 <[ext3]ext3_dirty_inode+160/180>
Trace; c0157f05 <__mark_inode_dirty+b5/c0>
Trace; c0131e6a <generic_file_write+2ba/800>
Trace; c01e3dec <ahc_linux_run_device_queue+3fc/8c0>
Trace; f88bf0c9 <[ext3]ext3_file_write+39/d0>
Trace; c015e8a1 <write_dquot+b1/100>
Trace; c015ed8c <dqput+4c/f0>
Trace; c015fe21 <dquot_drop+51/60>
Trace; c01585de <clear_inode+8e/130>
Trace; c01586bc <dispose_list+3c/80>
Trace; c0158952 <prune_icache+82/110>
Trace; c0158a04 <shrink_icache_memory+24/40>
Trace; c0137223 <shrink_caches+83/b0>
Trace; c0137286 <try_to_free_pages_zone+36/50>
Trace; c01381d2 <balance_classzone+62/1f0>
Trace; c0138464 <__alloc_pages+104/1a0>
Trace; c012f896 <find_or_create_page+86/110>
Trace; f88b0018 <[jbd]journal_recover+168/1d0>
Trace; f88c2c75 <[ext3]ext3_block_truncate_page+85/490>
Trace; f88ab55b <[jbd]new_handle+4b/70>
Trace; f88ab625 <[jbd]journal_start+a5/c0>
Trace; f88c0b44 <[ext3]start_transaction+94/a0>
Trace; f88c3858 <[ext3]ext3_truncate+d8/480>
Trace; c020c57c <skb_copy_datagram_iovec+4c/280>
Trace; c012bf43 <vmtruncate+d3/1b0>
Trace; c0159b86 <inode_setattr+106/120>
Trace; f88c473c <[ext3]ext3_setattr+25c/320>
Trace; c024631e <inet_recvmsg+4e/70>
Trace; c0159ede <notify_change+2ce/2e0>
Trace; c013e1e6 <do_truncate+66/90>
Trace; c0148ab3 <cp_new_stat64+f3/120>
Trace; c013f88d <do_sys_ftruncate+10d/16c>
Trace; c013e297 <sys_ftruncate64+27/30>
Trace; c010770f <system_call+33/38>

Code;  f88ab5df <[jbd]journal_start+5f/c0>
00000000 <_EIP>:
Code;  f88ab5df <[jbd]journal_start+5f/c0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  f88ab5e1 <[jbd]journal_start+61/c0>
    2:   f9                        stc
Code;  f88ab5e2 <[jbd]journal_start+62/c0>
    3:   00 14 50                  add    %dl,(%eax,%edx,2)
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


Best Regards



--
Bartlomiej Solarz-Niesluchowski, Administrator WSISiZ
e-mail: B.Solarz-Niesluchowski@wsisiz.edu.pl

