Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270566AbSKECMJ>; Mon, 4 Nov 2002 21:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271405AbSKECMI>; Mon, 4 Nov 2002 21:12:08 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:7296 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S270566AbSKECAs>; Mon, 4 Nov 2002 21:00:48 -0500
Date: Tue, 5 Nov 2002 13:06:30 +1100
From: CaT <cat@zip.com.au>
To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com, linux@brodo.de,
       Tamagucci@libero.it, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021105020630.GA644@zip.com.au>
References: <20021104025458.GA3088@zip.com.au> <20021104161504.GA316@neo.rr.com> <20021104235408.GA627@zip.com.au> <20021104202800.GD316@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104202800.GD316@neo.rr.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 08:28:00PM +0000, Adam Belay wrote:
> occured when the pnp bios protocol reached node 0x13.  This node, pnp id
> PNP0f13, is of course a standard mouse port.  If you look at the output of 
> lspnp for my system, the following can be seen.
> 
> 12 PNP0f13 input device: mouse
>     flags: [no disable] [no config] [static]
>     allocated resources:
> 	irq 12 [high edge]

Mine is #13 (ie the first line reads 13 PNP0f13...)

> Please feel free to send any questions or comments.  The patch is below.

The patch lets me boot just fine. (Woo) One hassle though, doing
lspci -v 13 or cat /proc/bus/pnp/13 causes an oops. I presume it's the
same deal as what you were talking about?

general protection fault: 0040
e100  
CPU:    0
EIP:    0088:[<0000992d>]    Not tainted
EFLAGS: 00010046
EIP is at E Using_Versions+0x992c/0xc01188ff
eax: 00000040   ebx: 00009bd1   ecx: 00150000   edx: 00000005
esi: 0000c1b1   edi: 00000000   ebp: cc56dde8   esp: cc56dd98
ds: 0090   es: 00a0   ss: 0068
Process lspnp (pid: 539, threadinfo=cc56c000 task=cd51a160)
Stack: c1f60090 9bd10005 c1d03032 c1940003 0a110011 0018c157 c1449bcb 0000c130 
       c11b9bca 0000c109 00030000 dde80000 dddecc56 9bb2cc56 00000000 00180000 
       03010015 c7110000 cc56c000 00000000 cffea600 c015fa28 de60df00 0000cc56 
Call Trace:
 [<c015fa28>] proc_alloc_inode+0x10/0x4c
 [<c0159ba3>] dio_get_page+0x4f/0x54
 [<c0153917>] wake_up_inode+0xb/0x34
 [<c0152f95>] unlock_new_inode+0x11/0x18
 [<c015fc0f>] proc_get_inode+0x5f/0x124
 [<c02737bc>] __pnp_bios_get_dev_node+0x120/0x17c
 [<c0140000>] sync_blockdev+0x20/0x3c
 [<c027382e>] pnp_bios_get_dev_node+0x16/0x34
 [<c027543f>] proc_read_node+0x47/0x8c
 [<c0161958>] proc_file_read+0xec/0x190
 [<c013e571>] vfs_read+0xc1/0x158
 [<c013eba2>] sys_read+0x2a/0x3c
 [<c0106f0f>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: lspnp[539] exited with preempt_count 1
Warning: null TTY for (88:04) in tty_fasync
general protection fault: 0040
e100  
CPU:    0
EIP:    0088:[<0000992d>]    Not tainted
EFLAGS: 00010046
EIP is at E Using_Versions+0x992c/0xc01188ff
eax: 00000040   ebx: 00009bd1   ecx: 00150000   edx: 00000005
esi: 0000c1b1   edi: 00000000   ebp: c65efde8   esp: c65efd98
ds: 0090   es: 00a0   ss: 0068
Process cat (pid: 734, threadinfo=c65ee000 task=cbae81e0)
Stack: c1f60090 9bd10005 c1d03032 c1940003 0a110011 0018c157 c1449bcb 0000c130 
       c11b9bca 0000c109 00030000 fde80000 fddec65e 9bb2c65e 00000000 00180000 
       03010015 c7110000 c11efb68 c65efe88 40014a25 00000a25 fe60fb68 c012c65e 
Call Trace:
 [<c012c65e>] filemap_nopage+0x1ae/0x2bc
 [<c013abcd>] do_page_cache_readahead+0x7d/0x150
 [<c02737bc>] __pnp_bios_get_dev_node+0x120/0x17c
 [<c0120000>] init_timers_cpu+0x0/0x88
 [<c027382e>] pnp_bios_get_dev_node+0x16/0x34
 [<c027543f>] proc_read_node+0x47/0x8c
 [<c0161958>] proc_file_read+0xec/0x190
 [<c013e571>] vfs_read+0xc1/0x158
 [<c013eba2>] sys_read+0x2a/0x3c
 [<c0106f0f>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: cat[734] exited with preempt_count 1

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
