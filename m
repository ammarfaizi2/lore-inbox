Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVCPPQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVCPPQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVCPPQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:16:20 -0500
Received: from [194.243.27.136] ([194.243.27.136]:50862 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S262628AbVCPPOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:14:37 -0500
X-Qmail-Scanner-Mail-From: devel@integra-sc.it via venere.pandoraonline.it
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:1(62.94.206.179):. Processed in 2.117967 secs)
Date: Wed, 16 Mar 2005 16:14:19 +0100
From: Devel <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at lib/radix-tree.c:592!
Message-Id: <20050316161419.1b318a69.devel@integra-sc.it>
Organization: Integra Solutions
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this message with kernel 2.6.11-2 any ideas?


kernel BUG at lib/radix-tree.c:592!
invalid operand: 0000 [#1]
Modules linked in: ppp_generic slhc bttv video_buf v4l2_common btcx_risc videodev autofs4 pcmcia yenta_socket rsrc_nonstatic pcmcia_core dm_mod battery ac
CPU:    0
EIP:    0060:[<c01ef502>]    Not tainted VLI
EFLAGS: 00010046   (2.6.11.2) 
EIP is at __lookup_tag+0x132/0x160
eax: 00000000   ebx: 00000009   ecx: c7cc5b5c   edx: 00000008
esi: c7cc5b5c   edi: 00000003   ebp: 00000000   esp: c13ffd24
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 246, threadinfo=c13fe000 task=c13dba60)
Stack: 00000003 00000000 c7cc5b5c 00000000 00000003 00000000 0000000e 0000003f 
       c84fdb30 c01ef593 c84fdb30 c13ffe08 00000000 0000000e c13ffd64 00000000 
       00000040 c13ffe00 c13ffe08 c13ffdf0 c13fff38 c0132ff8 c84fdb30 c13ffe08 
Call Trace:
 [<c01ef593>] radix_tree_gang_lookup_tag+0x63/0x80
 [<c0132ff8>] find_get_pages_tag+0x38/0x80
 [<c013c4a6>] pagevec_lookup_tag+0x36/0x40
 [<c017318e>] mpage_writepages+0x15e/0x3d0
 [<c0193520>] reiserfs_writepage+0x0/0x40
 [<c01af8b5>] do_journal_end+0x685/0xa40
 [<c0138ac2>] do_writepages+0x42/0x50
 [<c01716a6>] __sync_single_inode+0x56/0x1e0
 [<c0171897>] __writeback_single_inode+0x67/0x140
 [<c0139280>] pdflush+0x0/0x30
 [<c01ae855>] journal_end_sync+0x55/0xa0
 [<c019b6c5>] reiserfs_sync_fs+0x65/0x70
 [<c0171b11>] sync_sb_inodes+0x1a1/0x290
 [<c0139280>] pdflush+0x0/0x30
 [<c0171cac>] writeback_inodes+0xac/0xb0
 [<c0138886>] wb_kupdate+0x96/0x110
 [<c01391b4>] __pdflush+0xa4/0x170
 [<c01392a6>] pdflush+0x26/0x30
 [<c01387f0>] wb_kupdate+0x0/0x110
 [<c0139280>] pdflush+0x0/0x30
 [<c012924a>] kthread+0xaa/0xb0
 [<c01291a0>] kthread+0x0/0xb0
 [<c01012fd>] kernel_thread_helper+0x5/0x18
Code: 8b 4c 24 08 8b 14 24 8b 54 91 04 89 54 24 08 0f 85 24 ff ff ff 8d 74 26 00 8b 44 24 38 89 18 8b 44 24 10 83 c4 14 5b 5e 5f 5d c3 <0f> 0b 50 02 0a 23 42 c0 eb 9e 8b 7c 24 08 8b 44 8f 04 85 c0 0f 


[eyeass@apps]$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU              800MHz
stepping        : 1
cpu MHz         : 799.605
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1585.15

[eyeass@apps]$ /sbin/lspci 
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 04)
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
01:04.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 15)
01:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
01:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
01:07.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
01:09.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
01:0b.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
01:0b.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
01:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
01:0d.0 USB Controller: NEC Corporation USB (rev 41)
01:0d.1 USB Controller: NEC Corporation USB (rev 41)
01:0d.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
02:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)




