Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUJRIlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUJRIlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 04:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUJRIlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 04:41:50 -0400
Received: from main.gmane.org ([80.91.229.2]:13213 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264648AbUJRIlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 04:41:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: [2.6.8.1]Oops on eject /mnt/cdrom
Date: Mon, 18 Oct 2004 17:41:30 +0900
Message-ID: <ckvvjr$hev$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041016
X-Accept-Language: bg, en, ja, ru, de
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes this is 2.6.8.1, changed the version to agrre with x.y.z :-(
No patches, vanilla.

I did `mount /mnt/cdrom` and mounted a CD-R with some HTML/JPG data and looked through it (with Mozilla).
Then tried `eject /mnt/cdrom` and the command hang, so I checked dmesg:

ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
Unable to handle kernel paging request at virtual address bb726bfc
 printing eip:
c0151ff7
....

Runnig it through ksymoops gives:
ksymoops 2.4.9 on i686 2.6.8-KK1_sata.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.8-KK1_sata/ (default)
     -m /var/tmp/kernels/2.6.8-KK1_sata/System.map (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address bb726bfc
c0151ff7
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0151ff7>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287   (2.6.8-KK1_sata) 
eax: bb726c28   ebx: e8726c28   ecx: bb726c28   edx: e8726b54
esi: e8726b54   edi: 00000001   ebp: c19a8000   esp: c19a9ed4
ds: 007b   es: 007b   ss: 0068
Stack: e8726b54 e8726b5c e8726b54 00000004 c0169bff e8726b54 00000000 00000004 
       e8726d1c eb1c329c 00000080 00000000 c19a8000 f7ffea20 c0169cf0 00000080 
       c013cb2b 00000080 000000d0 00035a3b 00324b00 00000000 0000000f 00000000 
Call Trace:
 [<c0169bff>] prune_icache+0x14f/0x200
 [<c0169cf0>] shrink_icache_memory+0x40/0x50
 [<c013cb2b>] shrink_slab+0x14b/0x190
 [<c013df2d>] balance_pgdat+0x1ed/0x230
 [<c013e037>] kswapd+0xc7/0xe0
 [<c0116fb0>] autoremove_wake_function+0x0/0x60
 [<c0105ade>] ret_from_fork+0x6/0x14
 [<c0116fb0>] autoremove_wake_function+0x0/0x60
 [<c013df70>] kswapd+0x0/0xe0
 [<c0103d91>] kernel_thread_helper+0x5/0x14
Code: 8b 41 d4 a8 02 75 38 8b 01 8b 51 04 89 50 04 89 02 89 49 04 


>>EIP; c0151ff7 <remove_inode_buffers+37/80>   <=====

>>eax; bb726c28 <__crc_xfrm_get_acqseq+1537eb/401042>
>>ebx; e8726c28 <__crc_pci_do_scan_bus+557ba/28a863>
>>ecx; bb726c28 <__crc_xfrm_get_acqseq+1537eb/401042>
>>edx; e8726b54 <__crc_pci_do_scan_bus+556e6/28a863>
>>esi; e8726b54 <__crc_pci_do_scan_bus+556e6/28a863>
>>ebp; c19a8000 <__crc_unregister_chrdev+7ab6f/23ebeb>
>>esp; c19a9ed4 <__crc_unregister_chrdev+7ca43/23ebeb>

Trace; c0169bff <prune_icache+14f/200>
Trace; c0169cf0 <shrink_icache_memory+40/50>
Trace; c013cb2b <shrink_slab+14b/190>
Trace; c013df2d <balance_pgdat+1ed/230>
Trace; c013e037 <kswapd+c7/e0>
Trace; c0116fb0 <autoremove_wake_function+0/60>
Trace; c0105ade <ret_from_fork+6/14>
Trace; c0116fb0 <autoremove_wake_function+0/60>
Trace; c013df70 <kswapd+0/e0>
Trace; c0103d91 <kernel_thread_helper+5/14>

Code;  c0151ff7 <remove_inode_buffers+37/80>
00000000 <_EIP>:
Code;  c0151ff7 <remove_inode_buffers+37/80>   <=====
   0:   8b 41 d4                  mov    0xffffffd4(%ecx),%eax   <=====
Code;  c0151ffa <remove_inode_buffers+3a/80>
   3:   a8 02                     test   $0x2,%al
Code;  c0151ffc <remove_inode_buffers+3c/80>
   5:   75 38                     jne    3f <_EIP+0x3f>
Code;  c0151ffe <remove_inode_buffers+3e/80>
   7:   8b 01                     mov    (%ecx),%eax
Code;  c0152000 <remove_inode_buffers+40/80>
   9:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c0152003 <remove_inode_buffers+43/80>
   c:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0152006 <remove_inode_buffers+46/80>
   f:   89 02                     mov    %eax,(%edx)
Code;  c0152008 <remove_inode_buffers+48/80>
  11:   89 49 04                  mov    %ecx,0x4(%ecx)


1 warning issued.  Results may not be reliable.

# uname -a
Linux sata 2.6.8-KK1_sata #4 Sat Aug 21 21:35:05 JST 2004 i686 AMD Athlon(tm) XP 2500+ AuthenticAMD GNU/Linux
# grep cdrom /etc/fstab 
/dev/hdd                /mnt/cdrom           iso9660  noauto,user,ro        0 0
# cat /proc/ide/hdd/{model,driver,settings}
PLEXTOR DVDR PX-712A
ide-cdrom version 4.61
name                    value           min             max             mode
----                    -----           ---             ---             ----
current_speed           66              0               70              rw
dsc_overlap             1               0               1               rw
ide-scsi                0               0               1               rw
init_speed              12              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
nice1                   1               0               1               rw
number                  3               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw


I tried to reproduce the oops, but to no avail till now. It may be the CD-R as it is a bit "strange", I have my CT scans from the hospital in DICOM format (+jpg) :-(

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

