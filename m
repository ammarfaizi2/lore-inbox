Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbTHaKht (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 06:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTHaKhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 06:37:48 -0400
Received: from village.ehouse.ru ([193.111.92.18]:55308 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262561AbTHaKho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 06:37:44 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-testX and InnoDB (was: Re: 2.6.0-test2-mm3 and mysql)
Date: Sun, 31 Aug 2003 14:37:51 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <1059871132.2302.33.camel@mars.goatskin.org> <20030828125010.7b45407d.akpm@osdl.org> <200308291212.39238.rathamahata@php4.ru>
In-Reply-To: <200308291212.39238.rathamahata@php4.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308311437.51942.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Friday 29 August 2003 12:12, Sergey S. Kostyliov wrote:
> Hi Andrew,
>
> On Thursday 28 August 2003 23:50, Andrew Morton wrote:
> > "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> > > And here is another one InnoDB crash I've just got with 2.6.0-test4.
> >
> > Which filesystem?
>
> It's a reiserfs (v3.6)
> /dev/md/2 on /var/lib type reiserfs (rw,noatime,nodiratime,notail)
>
> > What sort of I/O system?
>
> It's a software raid1 over two scsi discs attached to
> 00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
>
> Host: scsi0 Channel: 00 Id: 08 Lun: 00
>   Vendor: QUANTUM  Model: ATLAS10K2-TY734L Rev: DDD6
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 09 Lun: 00
>   Vendor: QUANTUM  Model: ATLAS10K2-TY734L Rev: DDD6
>   Type:   Direct-Access                    ANSI SCSI revision: 03
>
> > Please grab http://www.zip.com.au/~akpm/linux/patches/stuff/fsx-linux.c
> >
> > and run
> >
> > 	./fsx-linux foo -s <physmem-in-bytes> foo
Sorry, this options doesn't work for me.
Perhaps `./fsx-linux -l  <physmem-in-bytes> foo`
are the right one? (It least it is what I'm using right now)

> >
> > on that machine for 12 hours or so.  Where <physmem-in-bytes> is (say)
> > 256000000 on a 256-MB machine.
> >
> > If the machine has more than a couple of gigabytes you'll need to run
> > multiple instances, against different files.
> >
> > Make sure that a decent amount of I/O is happening during the run.
>
> Ok, will do this evening. Thank you.

fsx-linux hasn't been producing any error messages or logs since Friday.
But I've got an oops. Here it is.

ksymoops 2.4.9 on i686 2.6.0-test4.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test4/ (default)
     -m /proc/kallsyms (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0c.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xb800. Vers LK1.1.19
kernel BUG at mm/filemap.c:336!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01324f0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1577e70   ecx: 00000016   edx: 00000001
esi: c1a00448   edi: d5f3e820   ebp: e7147858   esp: c1bbbd34
ds: 007b   es: 007b   ss: 0068
Stack: c1577e70 00000286 00000000 c0191a4e c1577e70 eb14fde0 d5f3e850 c1577e70 
       00000000 00000000 00000000 e7147904 c1577e70 c1bbbe64 e71478e4 c013c294 
       c1577e70 c1bbbdac c1bba000 c1bba000 c1bba000 c1bba000 c1bba000 c1bba000 
Call Trace:
 [<c0191a4e>] reiserfs_write_full_page+0xee/0x3a0
 [<c013c294>] shrink_list+0x394/0x5f0
 [<c013afe8>] __pagevec_release+0x28/0x40
 [<c013c6a7>] shrink_cache+0x1b7/0x350
 [<c013d267>] balance_pgdat+0x187/0x220
 [<c013d443>] kswapd+0x143/0x150
 [<c01183b0>] autoremove_wake_function+0x0/0x50
 [<c0109232>] ret_from_fork+0x6/0x14
 [<c01183b0>] autoremove_wake_function+0x0/0x50
 [<c013d300>] kswapd+0x0/0x150
 [<c0107215>] kernel_thread_helper+0x5/0x10
Code: 0f 0b 50 01 0b e8 2c c0 eb c6 8d b6 00 00 00 00 89 1c 24 e8 


>>EIP; c01324f0 <end_page_writeback+70/90>   <=====

Trace; c0191a4e <reiserfs_write_full_page+ee/3a0>
Trace; c013c294 <shrink_list+394/5f0>
Trace; c013afe8 <__pagevec_release+28/40>
Trace; c013c6a7 <shrink_cache+1b7/350>
Trace; c013d267 <balance_pgdat+187/220>
Trace; c013d443 <kswapd+143/150>
Trace; c01183b0 <autoremove_wake_function+0/50>
Trace; c0109232 <ret_from_fork+6/14>
Trace; c01183b0 <autoremove_wake_function+0/50>
Trace; c013d300 <kswapd+0/150>
Trace; c0107215 <kernel_thread_helper+5/10>

Code;  c01324f0 <end_page_writeback+70/90>
00000000 <_EIP>:
Code;  c01324f0 <end_page_writeback+70/90>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01324f2 <end_page_writeback+72/90>
   2:   50                        push   %eax
Code;  c01324f3 <end_page_writeback+73/90>
   3:   01 0b                     add    %ecx,(%ebx)
Code;  c01324f5 <end_page_writeback+75/90>
   5:   e8 2c c0 eb c6            call   c6ebc036 <_EIP+0xc6ebc036>
Code;  c01324fa <end_page_writeback+7a/90>
   a:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c0132500 <end_page_writeback+80/90>
  10:   89 1c 24                  mov    %ebx,(%esp,1)
Code;  c0132503 <end_page_writeback+83/90>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
