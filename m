Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUL3LqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUL3LqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 06:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUL3LqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 06:46:16 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:64520 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S261264AbUL3LqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 06:46:09 -0500
Subject: Re: BUG in reiser4
From: Vladimir Saveliev <vs@namesys.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412291939.31032@zodiac.zodiac.dnsalias.org>
References: <200412291939.31032@zodiac.zodiac.dnsalias.org>
Content-Type: text/plain
Message-Id: <1104407116.3682.168.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 30 Dec 2004 14:45:17 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2004-12-29 at 21:39, Alexander Gran wrote:
> Hi,
> 
> using 2.6.10-rc2-mm3 (config attached) i catched a bug in reiser4 while 
> apt-get updateing:
> Dec 29 19:30:08 t40 kernel: ------------[ cut here ]------------
> Dec 29 19:30:08 t40 kernel: kernel BUG at 
> fs/reiser4/plugin/file/tail_conversion.c:58!
> Dec 29 19:30:08 t40 kernel: invalid operand: 0000 [#1]
> Dec 29 19:30:09 t40 kernel: PREEMPT
> Dec 29 19:30:09 t40 kernel: Modules linked in: nls_cp437
> Dec 29 19:30:09 t40 kernel: CPU:    0
> Dec 29 19:30:09 t40 kernel: EIP:    0060:[<c01c1c75>]    Not tainted VLI
> Dec 29 19:30:09 t40 kernel: EFLAGS: 00210282   (2.6.10-rc2-mm3-orig)
> Dec 29 19:30:09 t40 kernel: EIP is at get_nonexclusive_access+0x26/0x30
> Dec 29 19:30:09 t40 kernel: eax: d2553f30   ebx: d33c88f0   ecx: dec66a40   
> edx: d33c8898
> Dec 29 19:30:09 t40 kernel: esi: d33c88c0   edi: d33c8898   ebp: d332fa6c   
> esp:
>  d2553cc4
> Dec 29 19:30:09 t40 kernel: ds: 007b   es: 007b   ss: 0068
> Dec 29 19:30:09 t40 kernel: Process apt-get (pid: 3064, threadinfo=d2552000 
> task=d2606580)
> Dec 29 19:30:09 t40 kernel: Stack: c01c0c27 b73eb000 00000000 00000000 
> 00000000 00000000 00000000 00000000
> Dec 29 19:30:09 t40 kernel:        00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000 00000000
> Dec 29 19:30:09 t40 kernel:        00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000 00000000
> Dec 29 19:30:09 t40 kernel: Call Trace:
> Dec 29 19:30:09 t40 kernel:  [<c01c0c27>] unix_file_filemap_nopage+0x5a/0xad
> Dec 29 19:30:09 t40 kernel:  [<c01c0bcd>] unix_file_filemap_nopage+0x0/0xad
> Dec 29 19:30:09 t40 kernel:  [<c013edb7>] do_no_page+0xc4/0x340
> Dec 29 19:30:09 t40 kernel:  [<c013f1f8>] handle_mm_fault+0xbe/0x151
> Dec 29 19:30:09 t40 kernel:  [<c013d899>] __follow_page+0x97/0xb5
> Dec 29 19:30:09 t40 kernel:  [<c013da06>] get_user_pages+0x11e/0x384
> Dec 29 19:30:09 t40 kernel:  [<c01c0281>] reiser4_get_user_pages+0x87/0xad
> Dec 29 19:30:09 t40 kernel:  [<c01c114f>] write_unix_file+0x356/0x3af
> Dec 29 19:30:09 t40 kernel:  [<c018a5ba>] try_commit_txnh+0x64/0x192
> Dec 29 19:30:09 t40 kernel:  [<c018a752>] commit_txnh+0x6a/0x9f
> Dec 29 19:30:09 t40 kernel:  [<c019b290>] reiser4_write+0x61/0x9e
> Dec 29 19:30:09 t40 kernel:  [<c014b99c>] sys_fchmod+0x95/0xb3
> Dec 29 19:30:09 t40 kernel:  [<c019b22f>] reiser4_write+0x0/0x9e
> Dec 29 19:30:09 t40 kernel:  [<c014ca2c>] vfs_write+0x98/0x11d
> Dec 29 19:30:09 t40 kernel:  [<c014cb6e>] sys_write+0x47/0x76
> Dec 29 19:30:09 t40 kernel:  [<c0102e25>] sysenter_past_esp+0x52/0x71
> Dec 29 19:30:09 t40 kernel: Code: 29 0f 00 00 c3 89 c2 b8 00 e0 ff ff 21 e0 8b 
> 00 8b 80 b8 04 00 00 8b 40 3c 8b 48 08 85 c9 75 0b 89 d0 ff 00 0f 88 17
> 0f 00 00 c3 <0f> 0b 3a 00 00 a4 43 c0 eb eb ba ff ff ff ff 0f c1 10 0f 88 0c
> 
> Shortly afterwards the kernel paniced (i.e. the system hung). I could not get 
> the mesage as it didn'tcame through X.
> 

It is very likely that this biug is fixed already in
ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.10-rc3-mm1/reiser4-update-for-2.6.10-rc3-mm1-1.gz

Would you try it, please?

> regards
> Alex

