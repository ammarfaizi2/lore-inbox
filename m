Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263654AbTCUQBM>; Fri, 21 Mar 2003 11:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263652AbTCUQBL>; Fri, 21 Mar 2003 11:01:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48910 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263650AbTCUQBF>; Fri, 21 Mar 2003 11:01:05 -0500
Date: Fri, 21 Mar 2003 17:12:06 +0100
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: Oops in ext3 in 2.5.64
Message-ID: <20030321161206.GA5476@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I got a following oops from the friend of mine:
The kernel oopsed while doing 'sync' after compiling wine.
The system is 2.5.64 with two Athlons, acls & extended attributes
enabled.
  The system also has problems (both on 2.5.64 and 2.5.65) when
running 'make -j4 install' in wine - processes get stuck in D state -
probably because pdflush is stuck in __make_request and other processes
are waiting on locks it's holding... Trace of stuck processes is
attached.

							Honza


Assertion failure in journal_stop() at fs/jbd/transaction.c:1334: "transaction->t_updates > 0"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1334!
invalid operand: 0000
CPU:    0
EIP:    0060:[journal_stop+473/496]    Not tainted
EFLAGS: 00010286
EIP is at journal_stop+0x1d9/0x1f0
eax: 00000062   ebx: 00000000   ecx: 00000012   edx: c03f2580
esi: df09c3c0   edi: 00000000   ebp: dba7de00   esp: dfdadd60
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 11, threadinfo=dfdac000 task=dfdae680)
Stack: c03a3080 c0389ba1 c03a0d77 00000536 c03a0d8c dfc8da00 00000000 dba7de00
       00000000 dbd8c6c8 c019a5b1 dba7de00 d6b3a570 00000000 00001000 00000000
       c019a370 00000001 d6b3a570 c1373c50 dbd8c75c dfdac000 dfdadf80 c017b6ac
Call Trace:
 [ext3_writepage+561/848] ext3_writepage+0x231/0x350
 [bput_one+0/16] bput_one+0x0/0x10
 [mpage_writepages+684/896] mpage_writepages+0x2ac/0x380
 [mpage_writepages+684/896] mpage_writepages+0x2ac/0x380
 [ext3_writepage+0/848] ext3_writepage+0x0/0x350
 [do_writepages+54/64] do_writepages+0x36/0x40
 [__sync_single_inode+271/688] __sync_single_inode+0x10f/0x2b0
 [sync_sb_inodes+419/656] sync_sb_inodes+0x1a3/0x290
 [writeback_inodes+136/304] writeback_inodes+0x88/0x130
 [background_writeout+198/272] background_writeout+0xc6/0x110
 [__pdflush+254/528] __pdflush+0xfe/0x210
 [pdflush+0/32] pdflush+0x0/0x20
 [pdflush+15/32] pdflush+0xf/0x20
 [background_writeout+0/272] background_writeout+0x0/0x110
 [kernel_thread_helper+0/24] kernel_thread_helper+0x0/0x18
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Code: 0f 0b 36 05 77 0d 3a c0 e9 39 fe ff ff 8d 76 00 8d bc 27 00

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--+QahgC5+KEYLbs62
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="tasks.out.bz2"
Content-Transfer-Encoding: base64

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

--+QahgC5+KEYLbs62--
