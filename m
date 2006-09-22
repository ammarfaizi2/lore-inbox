Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWIVBeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWIVBeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 21:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWIVBeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 21:34:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:49599 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932181AbWIVBeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 21:34:05 -0400
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
	kernel BUG at mm/slab.c:2698!
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Christoph Lameter <clameter@engr.sgi.com>
In-Reply-To: <20060921174134.4e0d30f2.akpm@osdl.org>
References: <1158884252.5657.38.camel@keithlap>
	 <20060921174134.4e0d30f2.akpm@osdl.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 21 Sep 2006 18:34:03 -0700
Message-Id: <1158888843.5657.44.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 17:41 -0700, Andrew Morton wrote:
> On Thu, 21 Sep 2006 17:17:31 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > I wanted to just give 2.6.18 a spin and I tripped over something I
> > didn't expect. 
> > 
> > 
> > cpu_up: attempt to bring up CPU 4 failed
> > kfree_debugcheck: bad ptr c15f6000h.
> > ------------[ cut here ]------------
> > kernel BUG at mm/slab.c:2698!
> > invalid opcode: 0000 [#1]
> > SMP
> > Modules linked in:
> > CPU:    0
> > EIP:    0060:[<c106ce51>]    Not tainted VLI
> > EFLAGS: 00010046   (2.6.18 #1)
> > EIP is at kfree_debugcheck+0x7f/0x90
> > eax: 00000028   ebx: 000015f6   ecx: c1025289   edx: c7653540
> > esi: c15f6000   edi: c15f6000   ebp: c764af38   esp: c764af28
> > ds: 007b   es: 007b   ss: 0068
> > Process swapper (pid: 1, ti=c764a000 task=c7653540 task.ti=c764a000)
> > Stack: c122c68d c15f6000 c1635000 00000004 c764af5c c106ef93 00000286
> > c76a77d0
> >        00000004 00000001 c1635000 00000004 00000004 c764af6c c10557f6
> > c1274eac
> >        c12743dc c764af84 c1207467 00000004 c12734c0 00000004 00000004
> > c764af98
> > Call Trace:
> >  [<c106ef93>] kfree+0x24/0x1d8
> >  [<c10557f6>] pageset_cpuup_callback+0x40/0x58
> >  [<c1207467>] notifier_call_chain+0x20/0x31
> >  [<c1031530>] blocking_notifier_call_chain+0x1d/0x2d
> >  [<c103f80c>] cpu_up+0xb5/0xcf
> >  [<c1000372>] init+0x78/0x296
> >  [<c1002005>] kernel_thread_helper+0x5/0xb
> 
> I think we have two problems here:
> 
> a) CPU4 didn't come up.  To diagnose that I think we'll need to ask you
>    to into cpu_up(), add debug printks to blocking_notifier_call_chain(),
>    work out which entry on that chain returned NOTIFY_BAD, then work out
>    why it did so.

That unhappy caller in the chain is cpuup_callback in mm/slab.c.  I am
still working out as to why, there is a lot going on if this function. 

> b) pageset_cpuup_callback()'s CPU_UP_CANCELED path possibly hasn't been
>    tested before.  I'd be guessing that we're not zeroing out the
>    zone.pageset[] array when the `struct zone' is first allocated, but I
>    don't immediately recall where that code lives.

Thanks,
  Keith 


