Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030517AbWFVCiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbWFVCiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 22:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbWFVCiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 22:38:52 -0400
Received: from dpc691978010.direcpc.com ([69.19.78.10]:31931 "EHLO
	third-harmonic.com") by vger.kernel.org with ESMTP id S1030517AbWFVCiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 22:38:51 -0400
Message-ID: <449A02BF.6010105@member.fsf.org>
Date: Wed, 21 Jun 2006 22:38:55 -0400
From: john cooper <john.cooper@member.fsf.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>, Ryan McAvoy <ryan.sed@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       John Cooper <john.cooper@member.fsf.org>
Subject: Re: realtime-preempt for MIPS - compile problem with rwsem
References: <642640090606201208g31a0a57bm268910b026ccd335@mail.gmail.com>  <Pine.LNX.4.58.0606210354050.29673@gandalf.stny.rr.com> <642640090606210804k282085efm84476af3a8fa08b1@mail.gmail.com> <Pine.LNX.4.58.0606211125590.29348@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0606211125590.29348@gandalf.stny.rr.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 21 Jun 2006, Ryan McAvoy wrote:

>> I did just that when I first started with these patches and did
>> succeed in getting it compiling and booting.  The resulting kernel,
>> however, is very unstable and hangs frequently with no output.  (It
>> will hang within hours if left idle.  I can hang it more quickly by
>> attempting to use it).

I also had stability issues with 2.6.14+RT+MIPS.
The only point I found it to be stable was under 2.6.13
where it successfully passed a standard battery of QA
tests.  To my knowledge no one has updated MIPS RT
since that time so I'd assume it is either in the
same state as then (best case) or worse (likely) due to
languishing.

Note the MIPS patch under discussion also required a
patch from linux-mips to produce a functional kernel
on the malta 4Kc which was the only MIPS target known
to be supported by that combination.

>> I have deadlock detection turned on and have
>> confirmed that it does produce output at least for some deadlocks:
>> http://groups.google.com/group/linux.kernel/browse_frm/thread/1559667001b7da2d/2558b539a5adc660?lnk=st&q=realtime+preempt+mips&rnum=2&hl=en#2558b539a5adc660
>> In the more common hangs though, I get no output.
> 
> That output looks like it had a deadlock on the serial output of sysrq
> key.  But that back trace looks screwy.

Well, not for MIPS.  There isn't any easy/painless method of
backtracing the stack so the MIPS version of dump_stack()
doesn't even try.  Instead it scans the entirety of the
stack and prints out anything and everything which smells
like a valid kernel text address, hence the screwy output.

>> I decided to review the changes I made in getting it to compile and
>> was hoping that this one may be the cause of the instability.  I
>> thought that perhaps this change was incorrect because
>> include/asm-mips/rwsem.h is introduced by the rt-preempt patch and
> 
> Ha, you're right!  (added John Cooper to this so he can clean up this mess
> ;)

Deselection of RWSEM_GENERIC_SPINLOCK in arch/mips/Kconfig is
a bug.   Unfortunately I don't have an available mips target
ATM and few if any spare cycles, but I'd sure like to get MIPS
through this nagging impasse.

That said, keep in mind due to limitations in the MIPS ABI
which carry over to gcc, latency instrumentation as it
currently exists (or may ever exist) is effectively
unsupportable.  IMHO this is a serious stumbling block for
realistic support of the RT work on this architecture.

-john

-- 
john.cooper@member.fsf.org
