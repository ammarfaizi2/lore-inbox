Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265822AbTF3J4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 05:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbTF3J4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 05:56:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:2697 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265822AbTF3J4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 05:56:10 -0400
Date: Mon, 30 Jun 2003 15:47:20 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.5.73-mm1 falling over in SDET
Message-ID: <20030630101719.GC4065@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030628170235.51ee2f69.akpm@digeo.com> <1056857338.2514.4.camel@mulgrave> <6620000.1056864944@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6620000.1056864944@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 06:09:41AM +0000, Martin J. Bligh wrote:
> --James Bottomley <James.Bottomley@SteelEye.com> wrote (on Saturday, June 28, 2003 22:28:57 -0500):
> 
> > On Sat, 2003-06-28 at 19:02, Andrew Morton wrote:
> >> Yes, isplinux_queuecommand() returns non-zero and the scsi generic layer
> >> cheerfully goes infinitely recursive.
> > 
> > Sigh, certain persons need to be more careful when doing logic
> > alterations.
> > 
> > Try the attached.
> 
> OK, that gets rather further, and I strongly suspect fixes the SCSI
> problem. Thanks very much.
> 
> But now it just OOMs instead, which seems to be slab failing 
> dismally to shrink it's fat ass enough to fit in that lazy-boy.
> Ext2 doesn't look desparately happy either. Maybe it's really
> that one's fault?
> 

I tried sdet on 16-way numaq with 2.5.73-mm2. It completes the run on ext2 
(no OOMs), but gives following oops while running on ext3

------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1132!
invalid operand: 0000 [#1]
SMP 
CPU:    5
EIP:    0060:[<c019f23d>]    Not tainted VLI
EFLAGS: 00010282
EIP is at journal_dirty_metadata+0x171/0x27c
eax: 00000072   ebx: e66818e4   ecx: c03e85e0   edx: c03736d0
esi: e6681800   edi: da9e3580   ebp: e66818e4   esp: d755de84
ds: 007b   es: 007b   ss: 0068
Process cpio (pid: 32707, threadinfo=d755c000 task=d9f70ce0)
Stack: c030f040 c030f5b4 c030f007 0000046c c030f5e0 00002f40 00000069 00000000 
       d832f6e4 c6f0b4c0 c01936d0 e042ca00 e50c2e0c d76df1a4 e042ca00 d76df1a4 
       d80f62a0 e5dfc000 00008000 e5dfc000 00000000 d832f660 e5e73400 e5e72d20 
Call Trace:
 [<c01936d0>] ext3_new_inode+0x210/0x664
 [<c0199658>] ext3_create+0x40/0x8c
 [<c0168ecb>] vfs_create+0x67/0x8c
 [<c01691cd>] open_namei+0x165/0x3e0
 [<c01584ab>] filp_open+0x3b/0x5c
 [<c0158993>] sys_open+0x37/0x78
 [<c01090b3>] syscall_call+0x7/0xb

Code: 54 24 1c f0 0f ab 02 83 7f 14 00 75 29 68 e0 f5 30 c0 68 6c 04 00 00 68 07 f0 30 c0 68 b4 f5 30 c0 68 40 f0 30 c0 e8 db 14 f8 ff <0f> 0b 6c 04 07 f0 30 c0 83 c4 14 8b 47 14 3b 44 24 10 74 63 3b 

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
