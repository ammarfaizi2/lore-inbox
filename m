Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270777AbUJUPlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270777AbUJUPlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270778AbUJUPgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:36:39 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:36757 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270780AbUJUPce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:32:34 -0400
Message-ID: <4177D68A.2070100@namesys.com>
Date: Thu, 21 Oct 2004 08:32:26 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Reich <ryanr@uchicago.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS on 2.6.9 while compiling, very reproducible
References: <20041021054844.GA3335@ryanr>
In-Reply-To: <20041021054844.GA3335@ryanr>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Reich wrote:

>Hey all,
>
>I get the following OOPS when compiling stuff.  The machine freezes solid if
>I get this while compiling 2.6.9 itself (as I was when it first happened),
>and on top of that the messsages and the call trace run off the screen, but I
>only get this small one when I compile something lesser.
>
>Oct 21 00:43:38 (none) kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
>Oct 21 00:43:38 (none) kernel:  printing eip:
>Oct 21 00:43:38 (none) kernel: c01ad955
>Oct 21 00:43:38 (none) kernel: *pde = 00000000
>Oct 21 00:43:38 (none) kernel: Oops: 0000 [#1]
>Oct 21 00:43:38 (none) kernel: PREEMPT
>Oct 21 00:43:38 (none) kernel: Modules linked in: ipt_ULOG ipt_multiport ipt_state ip_conntrack iptable_filter ip_tables it87 eeprom i2c_sensor i2c_isa i2c_nforce2 eth1394 usblp snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ohci1394 ieee1394 forcedeth ehci_hcd ohci_hcd usbcore nvidia_agp agpgart
>Oct 21 00:43:38 (none) kernel: CPU:    0
>Oct 21 00:43:38 (none) kernel: EIP: 0060:[prepare_for_delete_or_cut+37/2064]    Not tainted VLI
>Oct 21 00:43:38 (none) kernel: EFLAGS: 00010282   (2.6.9)
>Oct 21 00:43:38 (none) kernel: EIP is at prepare_for_delete_or_cut+0x25/0x810
>Oct 21 00:43:38 (none) kernel: eax: 00000000   ebx: 00000000   ecx: e9af8e48 edx: 00000000
>Oct 21 00:43:38 (none) kernel: esi: 00000001   edi: 00000000   ebp: 00000000 esp: e9af8b80
>Oct 21 00:43:38 (none) kernel: ds: 007b   es: 007b   ss: 0068
>Oct 21 00:43:38 (none) kernel: Process cc1 (pid: 3331, threadinfo=e9af8000 task=ef461560)
>Oct 21 00:43:38 (none) kernel: Stack: 00000001 00000318 0000ffff e9094758 00000318 00001000 effa5800 0003e8da
>Oct 21 00:43:38 (none) kernel:        0003f186 00001000 20000000 00000001 00000004 eececcec effa5800 0003e8da
>Oct 21 00:43:38 (none) kernel:        0003f186 00000001 20000000 0318ffff 00010bd0 e90947a4 e9af8ec8 00000000
>Oct 21 00:43:38 (none) kernel: Call Trace:
>Oct 21 00:43:38 (none) kernel:  [reiserfs_cut_from_item+207/1488] reiserfs_cut_from_item+0xcf/0x5d0
>Oct 21 00:43:38 (none) kernel:  [reiserfs_do_truncate+827/1488] reiserfs_do_truncate+0x33b/0x5d0
>Oct 21 00:43:38 (none) kernel:  [reiserfs_truncate_file+237/576] reiserfs_truncate_file+0xed/0x240
>Oct 21 00:43:38 (none) kernel:  [reiserfs_file_release+1306/1312] reiserfs_file_release+0x51a/0x520
>Oct 21 00:43:38 (none) kernel:  [do_mmap_pgoff+1199/1904] do_mmap_pgoff+0x4af/0x770
>Oct 21 00:43:38 (none) kernel:  [reiserfs_file_write+0/2016] reiserfs_file_write+0x0/0x7e0
>Oct 21 00:43:38 (none) kernel:  [__fput+286/368] __fput+0x11e/0x170
>Oct 21 00:43:38 (none) kernel:  [filp_close+82/160] filp_close+0x52/0xa0
>Oct 21 00:43:38 (none) kernel:  [sys_close+88/176] sys_close+0x58/0xb0
>Oct 21 00:43:38 (none) kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
>Oct 21 00:43:38 (none) kernel: Code: c4 08 c3 8d 76 00 55 57 56 53 83 ec 5c 8b 44 24 74 8b 54 24 78 8b 80 8c 00 00 00 89 d1 89 44 24 38 8b 02 8b 54 c2 08 8b 44 c1 0c <8b> 52 18 8d 04 40 8d 74 c2 18 66 83 7e 16 00 75 43 8b 4e 0c 31
>
>Clearly, I use reiserfs.  I also have Gentoo's fbsplash patched in, but
>nothing else.
>
>  
>
Are you using a compiler version that is accepted for use by the kernel? 
Which version?
