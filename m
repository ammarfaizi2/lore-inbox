Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264317AbTICT7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTICT5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:57:51 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:16527 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S264317AbTICT4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:56:49 -0400
Organization: 
Date: Wed, 3 Sep 2003 22:53:39 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
In-Reply-To: <20030903183242.GH838@suse.de>
Message-ID: <Pine.GSO.4.53.0309032252150.20516@oneiro.csd.uch.gr>
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
 <3F515301.4040305@sbcglobal.net> <3F532C67.6070904@sbcglobal.net>
 <Pine.GSO.4.53.0309020539380.9075@oneiro.csd.uch.gr> <20030901200530.64ad6fb9.akpm@osdl.org>
 <Pine.GSO.4.53.0309032124040.20174@oneiro.csd.uch.gr> <20030903183242.GH838@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Jens Axboe wrote:

> On Wed, Sep 03 2003, Panagiotis Papadakos wrote:
> > With -mm5 I get the followimg Oops when trying to mount the ZIP
> >
> > EIP: 0060:[<c025deb4>] Not tainted VLI
> > ...
> > EIP is at idefloppy_input_buffers+0x34/0x120
> > ...
> > Call Trace:
> > [<c025e5a2>] idefloppy_pc_intr+0x212/0x2d0
> > [<c0127602>] update_one_process+0xb2/0x120
> > [<c024cb7b>] ide_intr+0xeb/0x190
> > [<c025e390>] idefloppy_pc_intr+0x0/0x2d0
> > [<c010c7aa>] handle_IRQ_event+0x3a/0x70
> > [<c010cb31>] do_IRQ+0x91/0x130
>
> Would it be possible to get the entire oops? I'm sure I can fix the bug,
> it would be best if we could talk with lower latency than a few days
> (otherwise just 2-3 patch iterations will last a week :)

Here it is:

*pde = 00000000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c025deb4>]    Not tainted VLI
EFLAGS: 00010202
EIP is at idefloppy_input_buffers+0x34/0x120
eax: 00006b6b   ebx: 6b6b6b6b   ecx: 00010000   edx: dff6cfa0
esi: dff68e78   edi: 00000000   ebp: 00000001   esp: c03bbedc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03ba000 task=c03669c0)
Stack: c042f99c 00000001 00000002 6b6b6b6b df85a00c c042f99c 00000400
df85a00c
       c042f99c 00000001 c025e5a2 c042f99c df85a00c 00000400 00000000
d722d004
       c0127602 00000400 c03ba000 00000282 df7dd004 c042f99c c024cb7b
c042f99c
Call Trace:
 [<c025e5a2>] idefloppy_pc_intr+0x212/0x2d0
 [<c0127602>] update_one_process+0xb2/0x120
 [<c024cb7b>] ide_intr+0xeb/0x190
 [<c025e390>] idefloppy_pc_intr+0x0/0x2d0
 [<c010c7aa>] handle_IRQ_event+0x3a/0x70
 [<c010cb31>] do_IRQ+0x91/0x130
 [<c0107000>] _stext+0x0/0x60
 [<c030fd94>] common_interrupt+0x18/0x20
 [<c0107000>] _stext+0x0/0x60
 [<c0108f13>] default_idle+0x23/0x30
 [<c0108f7c>] cpu_idle+0x2c/0x40
 [<c03bc715>] start_kernel+0x155/0x170
 [<c03bc480>] unknown_bootoption+0x0/0x100
Code: 24 2c 8b 54 24 30 8b 7c 24 34 89 44 24 14 89 54 24 10 8b 42 24 8b 40
30 85 c0 89 44 24 0c 0f 84 a8 00 00 00 8d 76 00 8b 5c
24 0c <0f> b7 43 16 8b 53 24 8d 0c 40 89 c5 0f b7 43 14 8d 34 8a 39 c5
 <0>Kernel panic: Fatal exceptiom in interrupt
In interrupt handler - not syncing
