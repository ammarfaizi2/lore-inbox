Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbTGDJYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbTGDJYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:24:47 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:4358 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S265911AbTGDJYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:24:40 -0400
Date: Fri, 4 Jul 2003 11:39:39 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Joshua Kwan <joshk@triplehelix.org>
cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unable to handle NULL point when doing lsof
In-Reply-To: <20030704085216.GA26432@triplehelix.org>
Message-ID: <Pine.LNX.4.44.0307041125440.26765-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003, Joshua Kwan wrote:

> On Fri, Jul 04, 2003 at 05:34:41PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> > Please try http://bugme.osdl.org/attachment.cgi?id=476&action=view
> > Thanks.
> 
> This does not work, it produces the same segfault - 2.5.74-mm1 with
> fbdev patches.

Well, inclined to say me too - but not exactly:

* happens with 2.5.74 vanilla here (trace below / not tried with -mm)
* for me it's solved with the suggested patch above

Martin

------------------

kfree_debugcheck: out of range ptr 100h.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1537!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0143db5>]    Not tainted
EFLAGS: 00010002
EIP is at kfree+0x35/0x280
eax: 0000002c   ebx: 00040000   ecx: cbcfa080   edx: c02b5d30
esi: c9577848   edi: 00000100   ebp: c9570690   esp: c95c1ef8
ds: 007b   es: 007b   ss: 0068
Process lsof (pid: 1240, threadinfo=c95c0000 task=cbcfa6b0)
Stack: c028b280 00000100 cb7b3cc4 c94fe000 c025b124 cb7b3cc4 00000206 00000000 
       c017a987 cb7b3cc4 00000000 c95c1f34 00000000 00000001 00000000 cb7b3cc4 
       c9577848 c9a11238 c9570690 c017b0e6 00000100 c9577848 cbff4854 c9a11238 
Call Trace:
 [<c025b124>] raw_seq_start+0x44/0x50
 [<c017a987>] seq_read+0x187/0x2e0
 [<c017b0e6>] seq_release_private+0x16/0x2e
 [<c015a9e2>] __fput+0x32/0xd0
 [<c01640a0>] sys_fstat64+0x20/0x30
 [<c015928d>] filp_close+0x10d/0x120
 [<c015933f>] sys_close+0x9f/0xe0
 [<c0109417>] syscall_call+0x7/0xb

Code: 0f 0b 01 06 4d a8 28 c0 5a 59 6b eb 28 8b 15 98 1c 35 c0 8d 
 



