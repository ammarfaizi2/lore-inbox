Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136403AbRD2WqH>; Sun, 29 Apr 2001 18:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136404AbRD2Wp4>; Sun, 29 Apr 2001 18:45:56 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:60121 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S136403AbRD2Wpi>;
	Sun, 29 Apr 2001 18:45:38 -0400
Date: Mon, 30 Apr 2001 00:45:36 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.3-ac14: Unable to handle kernel paging request at virtual address
 bccfbcd0
Message-ID: <Pine.A41.4.31.0104300044190.49748-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I just did my daily apt-get upgrade + netscape w/ 32Mb ram, so it swapped
a lot. at that time there was a swap file on an ext2fs, but I think it's
not about swapping.

so the screen I saw (there is one digit missing):

[<c0147454>] [<c0109e08>] [<c0107e1d>] [<c012d6f6>] [<c015f125>] [<c015ef97>]
[<c015f409>] [<c0147b02>] [<c0147454>] [<c013d65f>] [<c0124daf>] [<c016fa21>]
[<c0124eef>] [<c0125b60>] [<c0124234>] [<c012bf5c>] [<c012c30e>] [<c012c4da>]
[<c01474f4>] [<c0147454>] [<c012d6f6>] [<c0147b02>] [<c0147454>] [<c013d65f>]
[<c0124daf>] [<c0124eef>] [<c0125b60>] [<c0124234>] [<c012bf5c>] [<c012c30e>]
[<c012c4da>] [<c01474f4>] [<c0147454>] [<c012d6f6>] [<c015095f>] [<c012db15>]
[<c012db6b>] [<c0147b02>] [<c0147454>] [<c013d65f>] [<c0124daf>] [<c0124eef>]
[<c0125b60>] [<c0124234>] [<c012bf5c>] [<c012c30e>] [<c014791b>] [<c0123e3e>]
[<c0125590>] [<c01256f2>] [<c0148d19>] [<c0184a46>] [<c018a57?>] [<c0184bd0>]
[<c0148fd7>] [<c01340d7>] [<c0134487>] [<c0134d96>] [<c0131e99>] [<c0106a63>]

Code: 8b 53 1c 89 d0 85 d2 7d 06 8d 82 ff 7f 00 00 25 00 80 ff ff
<1> Unable to handle kernel paging request at virtual address bccfbcd0

I looked up the addresses in System.map:

c0147454 ext2_get_block
c0109e08 end_8259A_irq
c0107e1d do_IRQ
c012d6f6 generic_block_bmap
c015f125 SHATransform
c015ef97 add_timer_randomness
c015f409 extract_entropy
c0147b02 ext2_bmap
c0147454 ext2_get_block
c013d65f bmap
c0124daf rw_swap_page_base
c016fa21 ide_set_handler
c0124eef rw_swap_page
c0125b60 swap_writepage
c0124234 page_launder
c012bf5c refill_freelist
c012c30e getblk
c012c4da bread
c01474f4 ext2_get_block
c0147454 ext2_get_block
c012d6f6 generic_block_bmap
c0147b02 ext2_bmap
c0147454 ext2_get_block
c013d65f bmap
c0124daf rw_swap_page_base
c0124eef rw_swap_page
c0125b60 swap_writepage
c0124234 page_launder
c012bf5c refill_freelist
c012c30e getblk
c012c4da bread
c01474f4 ext2_get_block
c0147454 ext2_get_block
c012d6f6 generic_block_bmap
c015095f submit_bh
c012db15 brw_page
c012db6b brw_page
c0147b02 ext2_bmap
c0147454 ext2_get_block
c013d65f bmap
c0124daf rw_swap_page_base
c0124eef rw_swap_page
c0125b60 swap_writepage
c0124234 page_launder
c012bf5c refill_freelist
c012c30e getblk
c014791b ext2_getblk
c0123e3e reclaim_page
c0125590 __alloc_pages_limit
c01256f2 __alloc_pages
c0148d19 ext2_find_entry
c0184a46 skb_release_data
c018a57? // here I missed one digit (maybe not the last digit) :/
c0184bd0 __kfree_skb
c0148fd7 ext2_lookup
c01340d7 real_lookup
c0134487 path_walk
c0134d96 __user_walk
c0131e99 sys_stat64
c0106a63 system_call

ver_linux:
Linux kama3 2.4.3-ac14 #2 Sun Apr 29 14:46:29 CEST 2001 i586 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.5
util-linux
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer available.
util-linux             Please use /usr/bin/superformat instead (make sure you have the
util-linux             fdutils package installed first).  Also, there had been some
util-linux             major changes from version 4.x.  Please refer to the documentation.
util-linux
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    0.96
Sh-utils               2.0.11
Modules Loaded         reiserfs snd-mixer-oss snd-card-fm801 snd-mpu401-uart snd-rawmidi snd-seq-device snd-fm801 snd-pcm snd-ac97-codec snd-mixer snd-opl3 snd-timer snd-hwdep snd soundcore

I was also using the ppp module, but that's not related, I think.
tell me if you need more info.

Bye,
Szabi

