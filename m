Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbTAWO34>; Thu, 23 Jan 2003 09:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTAWO3z>; Thu, 23 Jan 2003 09:29:55 -0500
Received: from angband.namesys.com ([212.16.7.85]:1920 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265249AbTAWO3y>; Thu, 23 Jan 2003 09:29:54 -0500
Date: Thu, 23 Jan 2003 17:39:04 +0300
From: Oleg Drokin <green@namesys.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030123173904.A901@namesys.com>
References: <20030123153832.A860@namesys.com> <Pine.LNX.4.44.0301231402290.1589-100000@localhost.localdomain> <20030123172638.A821@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20030123172638.A821@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 23, 2003 at 05:26:38PM +0300, Oleg Drokin wrote:
> > >     My test consists of running "fsx -c 1234 testfile", "iozone -a",
> > >     "dbench 60", "fsstress -p10 -n1000000 -d ." at the same time on the
> > >     tested FS.
> > >     fsx usually breaks just when dbench is finished.
> Also I decided to run same test with ext3 and it deadlocked.
> This time it was not absolutely vanilla kernel, so I am going to try it on
> vanilla kernel and report back if it will be reproducable there.
> (with stacktraces)

Ok, so on vanilla 2.5.59, the above test on ext3 fs crashes my kernel
soon (in several seconds) after dbench is over.

kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
------------[ cut here ]------------
kernel BUG at fs/buffer.c:2545!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0151d86>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bh+0x26/0x110
eax: 00000405   ebx: efe93180   ecx: f7c5a4b4   edx: f1b928a0
esi: 00000001   edi: 00000001   ebp: e1bc1e2c   esp: e1bc1e24
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 204, threadinfo=e1bc0000 task=f7a0c680)
Stack: efe93180 00000000 e1bc1e48 c0151ebd 00000001 efe93180 e1bc1eb0 e0c5e5a0 
       df65ccc0 e1bc1fb0 c01941bc 00000001 00000001 e1bc1eb0 e1bc0000 f7c5a400 
       f7c5a45c 00000000 00000000 00000000 f7c5a4b4 f7c5a45c df65cd10 f7c5a43c 
Call Trace:
 [<c0151ebd>] ll_rw_block+0x4d/0x70
 [<c01941bc>] journal_commit_transaction+0x49c/0x1150
 [<c0118b3a>] schedule+0x3ea/0x4c0
 [<c0196ed6>] kjournald+0x1e6/0x2f0
 [<c0196cf0>] kjournald+0x0/0x2f0
 [<c0196cd0>] commit_timeout+0x0/0x10
 [<c01071b1>] kernel_thread_helper+0x5/0x14

Code: 0f 0b f1 09 7c 31 28 c0 89 f6 83 7b 20 00 75 0a 0f 0b f2 09 

Bye,
    Oleg
