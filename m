Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWF2PaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWF2PaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWF2PaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:30:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:4878 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750787AbWF2PaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:30:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dlXsi3r1U570+LS0BE4jQDrNIfeVxPrk2yHSbcGiW4J6cZB15oQsHDNGkSyH1/xgqUQ+2BL4tr+spo/P2F+0QN1839qtGGvb4ESEO6+BSKMs4YGUPq1+luIWG+PP5riTi4jqFABSFy4NgbWNDzq8On5DY6bUuDc35VigtDtKmww=
Message-ID: <642640090606290830r34ba89d3x6f508299c1c91cc3@mail.gmail.com>
Date: Thu, 29 Jun 2006 09:30:17 -0600
From: "Ryan McAvoy" <ryan.sed@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Re: realtime-preempt for MIPS - compile problem with rwsem]]
Cc: mingo@elte.hu, tglx@linutronix.de, rostedt@goodmis.org,
       "Daniel Walker" <dwalker@mvista.com>,
       "john cooper" <john.cooper@member.fsf.org>, linux-mips@vger.kernel.org,
       "Manish Lachwani" <mlachwani@mvista.com>
In-Reply-To: <44997853.2000207@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44997853.2000207@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have now tried the 2.6.17 kernel (from linux-mips.org) with
2.6.17-rt1 plus the patches provided by Manish, and it works!

That is, it boots and is apparantly stable.  None of the procedures
that would cause my 2.6.15 and 2.6.16 rt kernels to hang reliably hang
this kernel.  As well, it ran over night and is still up.  (The other
rt kernels I built would hang within hours even if left idle).

With respect to my original question regarding
CONFIG_RWSEM_GENERIC_SPINLOCK, I have this option turned off in my
configuration.  (Still have "depends on !PREEMPT_RT for that option).
include/asm-mips/rwsem.h still calls rwsem_down_read_failed which is
still not defined since lib/rwsem.c is not compiled.
But, I don't encounter the link errors in this kernel because the two
offending inline functions in include/asm-mips/rwsem.h __down_read and
__down_write do not seem to be called from anywhere.

Ryan McAvoy

On 6/21/06, Manish Lachwani <mlachwani@mvista.com> wrote:
> Hi !
>
> I have sent a MIPS patch to Ingo and Thomas just yesterday to support
> realtime on MIPS in 2.6.17 and using the 2.6.17-rt1 patch. I have got
> that patch working on Broadcom SWARM board (32-bit UP/SMP).
>
> Try this out and let me know. I have run some stability tests on this
> kernel and have not noticed any hangs so far. So, it will be interesting
> to flush out any bugs.
>
> Thanks
> Manish Lachwani
>
>
>
> ---------- Forwarded message ----------
> From: Daniel Walker <dwalker@mvista.com>
> To: mlachwani@mvista.com
> Date: Wed, 21 Jun 2006 09:31:59 -0700
> Subject: [Fwd: Re: realtime-preempt for MIPS - compile problem with rwsem]
>
>
>
>
> ---------- Forwarded message ----------
> From: "Ryan McAvoy" <ryan.sed@gmail.com>
> To: "Steven Rostedt" <rostedt@goodmis.org>
> Date: Wed, 21 Jun 2006 10:12:29 -0600
> Subject: Re: realtime-preempt for MIPS - compile problem with rwsem
> On 6/21/06, Steven Rostedt wrote:
>
> http://groups.google.com/group/linux.kernel/browse_frm/thread/1559667001b7da2d/2558b539a5adc660?lnk=st&q=realtime+preempt+mips&rnum=2&hl=en#2558b539a5adc660
> > > In the more common hangs though, I get no output.
> >
> > That output looks like it had a deadlock on the serial output of sysrq
> > key.  But that back trace looks screwy.
> >
>
> That problem actually went away with 2.6.16.  All the others remained
> unfortunately.  (I was not that concerned about that one ... I can
> avoid it just by not sending a sysrq ;-).  I posted it though since I
> did actually have output with that hang).
>
> >
> > Perhaps you can post all the changes you made as a patch to see if
> > something else is wrong.  It might also be best to see if you can get the
> > latest working (2.6.17-rtX) and work your way backwards to the kernel
> > version you really need.
> >
>
> I will post the other changes soon.  (I am not at the office where I
> am working on this yet this morning).  I will also try 2.6.17.
> Thanks.
>
> Ryan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
