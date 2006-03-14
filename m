Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWCNON7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWCNON7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWCNON7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:13:59 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:52424 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752041AbWCNON7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:13:59 -0500
Subject: Re: 2.6.16-rc6-rt3
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>
In-Reply-To: <4416C6DD.80209@cybsft.com>
References: <20060314084658.GA28947@elte.hu>  <4416C6DD.80209@cybsft.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 09:13:24 -0500
Message-Id: <1142345604.4237.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 07:36 -0600, K.R. Foley wrote:
> Ingo Molnar wrote:
> > i have released the 2.6.16-rc6-rt3 tree, which can be downloaded from 
> > the usual place:
> > 
> 
> This one doesn't want to boot on the old SMP box. Log and config attached.
> 

[...]

> Freeing unused kernel memory: 280k freed
> Could not allocate 8 bytes percpu data
> BUG: Unable to handle kernel paging request at virtual address f3010000
>  printing eip:
> c0131c79
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP 
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0131c79>]    Not tainted VLI
> EFLAGS: 00010297   (2.6.16-rc6-rt3 #19) 
> EIP is at __find_symbol+0x37/0x1da
> eax: ffffffff   ebx: 000004b0   ecx: c02fe964   edx: c02fab00
> esi: f3010000   edi: e08255d0   ebp: de78fe9c   esp: de78fe8c
> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> Process insmod (pid: 804, threadinfo=de78e000 task=de4f9840 stack_left=7768 worst_left=-1)
> Stack: <0>000004b0 e082adc0 e082bc80 e08255d0 de78fec8 c0132cc6 e08255d0 de78feb4 
>        de78feb8 00000001 00000000 e082adc0 e082adc0 00000370 00000032 de78fef0 
>        c013321c e0824930 0000000b e08255d0 e082bc80 00000000 e0824930 e082bc8d 
> Call Trace:
>  [<c01038fb>] show_stack_log_lvl+0xa5/0xad (44)
>  [<c0103a67>] show_registers+0x137/0x1a0 (44)
>  [<c0103c3b>] die+0xf3/0x16f (56)
>  [<c0111e19>] do_page_fault+0x36f/0x48a (88)
>  [<c010357f>] error_code+0x4f/0x54 (76)
>  [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
>  [<c013321c>] simplify_symbols+0x81/0xf4 (40)
>  [<c0133e2d>] load_module+0x637/0x968 (168)
>  [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
>  [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
> ---------------------------
> | preempt count: 00000001 ]

Hmm, you didn't do a make modules_install, then change some of the
config options, do a make install and forget to do a modules_install did
you?  That error looks like the error I get when I do something like
that.

If you have done more than one make and install, could you do a make
clean and start again?  Just to make sure it's not a incompatibility
between makes.

Thanks,

-- Steve


