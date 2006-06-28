Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWF1NUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWF1NUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbWF1NUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:20:32 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:747 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161013AbWF1NUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:20:31 -0400
Date: Wed, 28 Jun 2006 15:19:55 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unkillable process in last git -- 100% reproducible
Message-ID: <20060628151955.0acdb39a@localhost>
In-Reply-To: <20060628150943.78e91871@localhost>
References: <20060628142918.1b2c25c3@localhost>
	<20060628145349.53873ccc@localhost>
	<20060628150943.78e91871@localhost>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_q9JT.3I6erh.IcLrr8xnO+o
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_q9JT.3I6erh.IcLrr8xnO+o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 28 Jun 2006 15:09:43 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> On Wed, 28 Jun 2006 14:53:49 +0200
> Paolo Ornati <ornati@fastwebnet.it> wrote:
> 
> > > [  430.083347] localedef     R  running task       0  8577   8558  8578               (NOTLB)
> > > [  430.083352] gzip          X ffff81001e612ee0     0  8578   8577                     (L-TLB)
> > > [  430.083358] ffff81001395bef8 ffff81001fd1a310 0000000000000246 ffff81001e612ee0 
> > > [  430.083362]        ffff81001e4c0080 ffff81001e612ee0 ffff81001e4c0258 0000000000000001 
> > > [  430.083366]        0000000000000046 0000000000000046 ffff81001395bf18 0000000000000010 
> > > [  430.083370] Call Trace: <ffffffff80227f6f>{do_exit+2378} <ffffffff802628e9>{vfs_write+288}
> > > [  430.083379]        <ffffffff80228065>{sys_exit_group+0} <ffffffff80209806>{system_call+126}
> > 
> > do_exit() -- kernel/exit.c
> > 
> > 0xffffffff80227f66 <do_exit+2369>:      mov    %rax,0x18(%rbp)
> > 0xffffffff80227f6a <do_exit+2373>:      callq  0xffffffff8048b850 <schedule>
> > 0xffffffff80227f6f <do_exit+2378>:      ud2a
> > 0xffffffff80227f71 <do_exit+2380>:      pushq  $0xffffffff804b7821
> > 0xffffffff80227f76 <do_exit+2385>:      retq   $0x3ba
> > 0xffffffff80227f79 <do_exit+2388>:      jmp    0xffffffff80227f79 <do_exit+2388>
> 
> 
> that is the end of the function:
> 
> ...
>         schedule();
>         BUG();
>         /* Avoid "noreturn function does return".  */
>         for (;;) ;
> }
> 
> 
> So the questions are two:
> 
> 1) why schedule() didn't work?
> 
> 2) why the process is looping around "ud2a" (placed by BUG()) and
> presumibly throwing a lot of "invalid opcode" exceptions?

It seems that the first mail didn't hit LKML (maybe it was too big),
here it is (stripped):

------------------------------------------------------------------------
Running "localedef" triggers an infinite loop in kernel mode (or
something) --> localdef becomes unkillable.

This is dmesg after pressing ALT+SysRQ+T three times:

[CUT]

KERNEL:

--
	Paolo Ornati
	Linux 2.6.17-ga39727f2-dirty on x86_64
	                      ^^^^^^^

The -dirty is because of a fix to PS2 Keyboard auto-repeat, nothing else.
------------------------------------------------------------------------


Full config attached.
--MP_q9JT.3I6erh.IcLrr8xnO+o
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.gz

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

--MP_q9JT.3I6erh.IcLrr8xnO+o--
