Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268492AbTBWPqu>; Sun, 23 Feb 2003 10:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268502AbTBWPqu>; Sun, 23 Feb 2003 10:46:50 -0500
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:52222
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP
	id <S268492AbTBWPqs>; Sun, 23 Feb 2003 10:46:48 -0500
Subject: 2.4.19 + XFS 1.2pre3 swap file oops
From: Timo Sirainen <tss@iki.fi>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046015817.890.59.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Feb 2003 17:56:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After about three weeks of use I got an oops while moving a 480MB file.
There was no disk errors in log. Moving was from hda -> hdd, both are
XFS filesystems, swap is on hda.

About 30MB of the 1GB swap was in use. All processes using the swap got
stuck after the oops, but shutdown seemed to go fine.

I'll upgrade to 2.4.20 + XFS 1.2 now, but I didn't see anything swap
related in their changelogs.

VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:DMA
hda: IBM-DTLA-305040, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
hdd: ST3120023A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=5005/255/63, UDMA(100)
hdd: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
Partition check:
 hda: hda1
 hdd: hdd1

ksymoops 2.4.8 on i686 2.4.19-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-xfs/ (default)
     -M (specified)

Feb 23 15:57:51 hurina kernel: c012d810
Feb 23 15:57:51 hurina kernel: Oops: 0002
Feb 23 15:57:51 hurina kernel: CPU:    0
Feb 23 15:57:51 hurina kernel: EIP:    0010:[<c012d810>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 23 15:57:51 hurina kernel: EFLAGS: 00210046
Feb 23 15:57:51 hurina kernel: eax: c7514000   ebx: 00000010   ecx: ddba4000   edx: ffffffff
Feb 23 15:57:51 hurina kernel: esi: c158fe50   edi: 00200202   ebp: 000001d0   esp: c15bbf00
Feb 23 15:57:51 hurina kernel: ds: 0018   es: 0018   ss: 0018
Feb 23 15:57:51 hurina kernel: Process kswapd (pid: 4, stackpage=c15bb000)
Feb 23 15:57:51 hurina kernel: Stack: ddba48c0 ddba48c0 ddba48c0 000001d0 c0137ce8 c158fe50 ddba48c0 c0139bcf 
Feb 23 15:57:51 hurina kernel:        ddba48c0 ddba48c0 c1489a54 000001d0 c15ba000 c1489a54 c1489a54 c0138039 
Feb 23 15:57:51 hurina kernel:        c15ba000 c1489a70 c012e774 c1489a54 000001d0 00000020 000001d0 00000020 
Feb 23 15:57:51 hurina kernel: Call Trace:    [<c0137ce8>] [<c0139bcf>] [<c0138039>] [<c012e774>] [<c012ea76>]
Feb 23 15:57:51 hurina kernel:   [<c012eadc>] [<c012eb73>] [<c012ebd6>] [<c012eced>] [<c0107038>]
Feb 23 15:57:51 hurina kernel: Code: 89 42 04 89 10 8b 46 08 89 48 04 89 01 8d 56 08 89 51 04 89 


>>EIP; c012d810 <kmem_cache_free+70/90>   <=====

>>eax; c7514000 <___strtok+720372c/2059e78c>
>>ecx; ddba4000 <___strtok+1d89372c/2059e78c>
>>esi; c158fe50 <___strtok+127f57c/2059e78c>
>>esp; c15bbf00 <___strtok+12ab62c/2059e78c>

Trace; c0137ce8 <bread+98/d0>
Trace; c0139bcf <try_to_free_buffers+7f/270>
Trace; c0138039 <set_bh_page+229/230>
Trace; c012e774 <kmem_find_general_cachep+e94/1b40>
Trace; c012ea76 <kmem_find_general_cachep+1196/1b40>
Trace; c012eadc <kmem_find_general_cachep+11fc/1b40>
Trace; c012eb73 <kmem_find_general_cachep+1293/1b40>
Trace; c012ebd6 <kmem_find_general_cachep+12f6/1b40>
Trace; c012eced <kmem_find_general_cachep+140d/1b40>
Trace; c0107038 <kernel_thread+28/1f0>

Code;  c012d810 <kmem_cache_free+70/90>
00000000 <_EIP>:
Code;  c012d810 <kmem_cache_free+70/90>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c012d813 <kmem_cache_free+73/90>
   3:   89 10                     mov    %edx,(%eax)
Code;  c012d815 <kmem_cache_free+75/90>
   5:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c012d818 <kmem_cache_free+78/90>
   8:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012d81b <kmem_cache_free+7b/90>
   b:   89 01                     mov    %eax,(%ecx)
Code;  c012d81d <kmem_cache_free+7d/90>
   d:   8d 56 08                  lea    0x8(%esi),%edx
Code;  c012d820 <kmem_cache_free+80/90>
  10:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c012d823 <kmem_cache_free+83/90>
  13:   89 00                     mov    %eax,(%eax)

