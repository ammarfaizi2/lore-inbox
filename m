Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUJGRNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUJGRNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUJGRMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:12:31 -0400
Received: from main.gmane.org ([80.91.229.2]:24736 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267502AbUJGRCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:02:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: [2.6.8.1] Oops, probably reiserfs related
Date: Fri, 08 Oct 2004 02:02:34 +0900
Message-ID: <ck3srb$iru$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was trying to mencode a lot of MPEG files into one when I got this oops.
Everything that wanted to access the partition in question (not my /) was stuck in D state, I couldn't even reboot, so a hard reset was needed. No data loss it seems.

Running tained with nvidia and VMware.

$ uname -a
Linux sata 2.6.8-KK1_sata #4 Sat Aug 21 21:35:05 JST 2004 i686 AMD Athlon(tm) XP 2500+ AuthenticAMD GNU/Linux
*** this is 2.6.8.1 vanilla ***

Here it is:

ksymoops 2.4.9 on i686 2.6.8-KK1_sata.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.8-KK1_sata/ (default)
     -m /var/tmp/kernels/2.6.8-KK1_sata/System.map (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at /usr/src/linux-2.6.8-KK1/fs/reiserfs/prints.c:362!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01a3651>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282   (2.6.8-KK1_sata) 
eax: 00000060   ebx: c03731ae   ecx: 00000000   edx: c03a44b8
esi: c1963a00   edi: c1963b2c   ebp: f8b48dc0   esp: c1997e30
ds: 007b   es: 007b   ss: 0068
Stack: c03665fc c1963b2c c048c320 00000000 f8b481a8 d2b3fc44 c01b4d7c c1963a00 
       c0368738 00000545 00000000 c16e83c0 c16ee480 c104ce40 030658e8 00002012 
       f7884c00 d2b3fc44 f6e633f8 000003fa 00001e4f f7884c00 f6e633e0 00000004 
Call Trace:
 [<c01b4d7c>] do_journal_end+0xbac/0xbb0
 [<c01b37ed>] journal_end_sync+0x4d/0x90
 [<c019ff5c>] reiserfs_sync_fs+0x5c/0xb0
 [<c01564ac>] sync_supers+0xac/0xc0
 [<c01375b3>] wb_kupdate+0x33/0x110
 [<c013808a>] __pdflush+0xca/0x1c0
 [<c0138180>] pdflush+0x0/0x30
 [<c01381a8>] pdflush+0x28/0x30
 [<c0137580>] wb_kupdate+0x0/0x110
 [<c0138180>] pdflush+0x0/0x30
 [<c012b825>] kthread+0xa5/0xb0
 [<c012b780>] kthread+0x0/0xb0
 [<c0103d91>] kernel_thread_helper+0x5/0x14
Code: 0f 0b 6a 01 20 66 36 c0 85 f6 c7 44 24 08 20 c3 48 c0 c7 04 


>>EIP; c01a3651 <reiserfs_panic+51/80>   <=====

>>ebx; c03731ae <__func__.2+17fe0/3399e>
>>edx; c03a44b8 <log_wait+0/8>
>>esi; c1963a00 <__crc_unregister_chrdev+3656f/23ebeb>
>>edi; c1963b2c <__crc_unregister_chrdev+3669b/23ebeb>
>>ebp; f8b48dc0 <__crc_pm_idle+238f41/511cc5>
>>esp; c1997e30 <__crc_unregister_chrdev+6a99f/23ebeb>

Trace; c01b4d7c <do_journal_end+bac/bb0>
Trace; c01b37ed <journal_end_sync+4d/90>
Trace; c019ff5c <reiserfs_sync_fs+5c/b0>
Trace; c01564ac <sync_supers+ac/c0>
Trace; c01375b3 <wb_kupdate+33/110>
Trace; c013808a <__pdflush+ca/1c0>
Trace; c0138180 <pdflush+0/30>
Trace; c01381a8 <pdflush+28/30>
Trace; c0137580 <wb_kupdate+0/110>
Trace; c0138180 <pdflush+0/30>
Trace; c012b825 <kthread+a5/b0>
Trace; c012b780 <kthread+0/b0>
Trace; c0103d91 <kernel_thread_helper+5/14>

Code;  c01a3651 <reiserfs_panic+51/80>
00000000 <_EIP>:
Code;  c01a3651 <reiserfs_panic+51/80>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01a3653 <reiserfs_panic+53/80>
   2:   6a 01                     push   $0x1
Code;  c01a3655 <reiserfs_panic+55/80>
   4:   20 66 36                  and    %ah,0x36(%esi)
Code;  c01a3658 <reiserfs_panic+58/80>
   7:   c0 85 f6 c7 44 24 08      rolb   $0x8,0x2444c7f6(%ebp)
Code;  c01a365f <reiserfs_panic+5f/80>
   e:   20 c3                     and    %al,%bl
Code;  c01a3661 <reiserfs_panic+61/80>
  10:   48                        dec    %eax
Code;  c01a3662 <reiserfs_panic+62/80>
  11:   c0 c7 04                  rol    $0x4,%bh


1 warning issued.  Results may not be reliable.

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

