Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbTEHHXD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbTEHHXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:23:03 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:55015 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261163AbTEHHXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:23:02 -0400
Date: Thu, 8 May 2003 13:12:37 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: akpm@zip.com.au, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030508074237.GA2760@in.ibm.com>
References: <20030507055103.GA31797@in.ibm.com> <20030508003139.432A617DE0@ozlabs.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508003139.432A617DE0@ozlabs.au.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 04:16:06PM +1000, Rusty Russell wrote:
> In message <20030507055103.GA31797@in.ibm.com> you write:
> > I tried to run a test to compare this implementation, but got an oops.
> > Here is the oops and the patch I was trying...  
> 
> > +	if (!init_committed_space)
> 
> init_committed_space is a function.  You meant to call it 8)

Yeah :(..sorry abt that, I'd actually tested an earlier patch of
yours (one u sent to Dipankar) and I'd got an oops in
__alloc_percpu (Same application but I'd actually called
init_commmited_space earlier).  So when I got a oops  again
with the newer patch, I just mailed it.  
But still, even after actually calling init_committed_space
with the newer patch (The first one which you mailed to Andrew in this
thread) I get an oops at __alloc_percpu.

Here's the oops report...looks like the 
struct pcpu_block *pcpu has NULL...

Thanks,
Kiran

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c014a5de
*pde = 00104001
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c014a5de>]    Not tainted
EFLAGS: 00010246
EIP is at __alloc_percpu+0x4e/0x190
eax: c02f9cbc   ebx: c03a8328   ecx: 00000000   edx: 00000000
esi: 00000001   edi: 00000000   ebp: 00000000   esp: dff7ff94
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dff7e000 task=dff7c040)
Stack: c01070f0 00000003 c03cfe20 c03ad080 c03a8328 00000001 00000020 00000000
       c01392f9 00000004 00000004 c036ccda c036cd26 c03a8328 c03607eb dff7e000
       00000000 c01050c2 00000020 c0105060 00000000 00000000 00000000 c01070f5
Call Trace:
 [<c01070f0>] kernel_thread_helper+0x0/0x10
 [<c01392f9>] init_committed_space+0x9/0x11
 [<c036ccda>] swap_setup+0x1a/0x30
 [<c036cd26>] kswapd_init+0x6/0x40
 [<c03607eb>] do_initcalls+0x3b/0x90
 [<c01050c2>] init+0x62/0x1d0
 [<c0105060>] init+0x0/0x1d0
 [<c01070f5>] kernel_thread_helper+0x5/0x10

Code: 66 83 39 00 0f 84 08 01 00 00 c7 44 24 04 fc ff ff ff 31 f6
 <0>Kernel panic: Attempted to kill init!

