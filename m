Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTETRFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTETRFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:05:18 -0400
Received: from boden.synopsys.com ([204.176.20.19]:683 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S262714AbTETRFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:05:15 -0400
Date: Tue, 20 May 2003 19:17:59 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Milton Miller <miltonm@bga.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       mikpe@csd.uu.se
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
Message-ID: <20030520171759.GR32559@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <3ECA05FA.6090008@gmx.net> <200305201634.h4KGY9VJ049544@sullivan.realtime.net> <20030520170054.GQ32559@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520170054.GQ32559@Synopsys.COM>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen, Tue, May 20, 2003 19:00:54 +0200:
> Milton Miller, Tue, May 20, 2003 18:34:09 +0200:
> > Shouldn't this just use active_mm?   Can somebody test?
> 
> It helped.
> 
> > by the way, I saw this with a 486 kernel compiled by
> > gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
> > 
> > on a Toshiba 2105 (aka 2100 +- sw) 486DX2/50, although I am not
> > at that computer presenlty to test.
> > 
> 
> Also the stability problems I mentioned before gone.
> 

the last sentence is not true:

Unable to handle kernel paging request at virtual address 8bd6c008
 printing eip:
c0180010
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0180010>]    Not tainted
EFLAGS: 00010216
EIP is at ext3_get_inode_loc+0xc0/0x180
eax: c5eb6000   ebx: 00066080   ecx: 0000000c   edx: 00000066
esi: c5ebbe00   edi: 00000100   ebp: c5c89e20   esp: c5c89e08
ds: 007b   es: 007b   ss: 0068
Process find (pid: 22, threadinfo=c5c88000 task=c5e7e080)
Stack: 00000cc1 00000008 c5c89e30 c49bb984 c5ebbe00 c49bb900 c5c89e58 c018018d 
       c49bb984 c5c89e3c c5c89e54 c0162920 c5ebbe00 c10fe4f4 000209c2 c10fe4f4 
       000209c2 c49bb984 c5ebbe00 c56ad0a0 c5c89e74 c018215e c49bb984 c20861c8 
Call Trace:
 [<c018018d>] ext3_read_inode+0x2d/0x3c0
 [<c0162920>] iget_locked+0x90/0xc0
 [<c018215e>] ext3_lookup+0x12e/0x140
 [<c01570cc>] real_lookup+0xac/0xd0
 [<c015739e>] do_lookup+0x6e/0x80
 [<c015783a>] link_path_walk+0x48a/0x900
 [<c01b74be>] write_chan+0x16e/0x220
 [<c0156cd8>] getname+0x78/0xc0
 [<c01580e2>] __user_walk+0x32/0x50
 [<c01533f7>] vfs_lstat+0x17/0x50
 [<c01539d4>] sys_lstat64+0x14/0x30
 [<c014aba2>] vfs_write+0xb2/0xf0
 [<c014ac5e>] sys_write+0x2e/0x50
 [<c0109187>] syscall_call+0x7/0xb

Code: 8b 4c 00 08 01 ca 89 55 f0 8b 46 0c 50 52 8b 86 8c 00 00 00 

It is harder to trigger, but possible.
I booted with init=/bin/bash. Than I started this
find / -type f -fprint /dev/stderr -print | xargs cat > /dev/null
and began going in suspend mode and back.

At some point it broke with oops above.

-alex

