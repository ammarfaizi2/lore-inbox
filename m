Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbUDFXRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUDFXRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:17:46 -0400
Received: from web40505.mail.yahoo.com ([66.218.78.122]:64089 "HELO
	web40505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264066AbUDFXRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:17:35 -0400
Message-ID: <20040406231734.92421.qmail@web40505.mail.yahoo.com>
Date: Tue, 6 Apr 2004 16:17:34 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Timothy Miller <miller@techsource.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
In-Reply-To: <407335B3.1070200@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Timothy Miller <miller@techsource.com> wrote:
> 
> 
> Sergiy Lozovsky wrote:
> > --- Timothy Miller <miller@techsource.com> wrote:
> > 
> >>
> >>Horst von Brand wrote:
> 
> >>>OK, so you need the policy to be interpreted
> >>in-kernel (dunno why a
> >>>largeish high-level general purpose language is
> >>needed for that, when a
> >>>tiny interpreter for a specialized language will
> >>do very well, and has been
> >>>shown to work fine), and written in a "high level
> >>language" so that your
> >>>garden variety sysadmin _can_ write her own
> >>policy, but it really doesn't
> >>>matter because she'll never have to do so...
> >>>Completely lost me.
> >>
> >>I was getting hung up on that one too, but I
> didn't
> >>know how to say it. 
> >>  You did a nice job.  :)
> > 
> > 
> > Can you guys be more specific? I don't see any
> > technical objections. The only one is that
> performance
> > would suffer because of use of higher level
> language
> > than C or Assembler.
> 
> That IS one of the objections, but it's not the
> objection HERE.
> 
> The objection here is that we see an inconsistency:
> 
> A) You support the idea of using LISP because it's a
> high-level language 
> that sysadmins can use to develop policies.
> 
> B) But then you say that sysadmins won't be
> developing policies.
> 
> Therefore, you invalidate your reason for wanting to
> use LISP

If I would say, that policy administrator change
security policy (not system administrator :-). Would
it be an answer to your question? I don't want this
person to be a kernel guru and make him write a C code
for Kernel. I don't want errors of this person to
affect all the system - which is a case with
precompiled loadable C module.

> > 
> > There is a reason people use languages like PERL,
> Java
> > and so on. I would prefer to spend less time
> writing
> > actual code - this is what these high level
> languages
> > for. If performance would be most important -
> people
> > would do everything in Assembler, but they don't.
> I'd
> > better write a small Assembler subroutine which
> will
> > handle stack problems for me and benefit from
> using
> > the high level language after that.
> 
> As a matter of fact, the only reason people object
> to using LISP is 
> because you want to do it IN THE KERNEL.
> 
> If you want the interpreter to live in the kernel,
> then you have to use 
> something MUCH SIMPLER and something which doesn't
> eat stack like LISP does.

What? Give an example. I want something high level, so
Forth will not do. Sure, encapsulation is needed, to
protect kernel from pointer errors and so on.

> On the other hand, if you were to put hooks into the
> kernel so that 
> people could use ANY LANGUAGE THEY WANTED, IN USER
> SPACE, then people 
> would be very happy with you.  This way, you can
> waste all the memory 
> you want on the interpreter, but it's okay because
> it's:
> 
> (1) extremely optional
> (2) extremely replacable (interpretor can be any
> language)
> (3) swappable
> (4) can't clobber the kernel
> (5) can use as much stack space as it wants
> (6) minimally impacts what IS in the kernel, etc.
> 
> You down-play the performance impact of using LISP
> above, but you 
> contradict that by saying you want to put the
> interpreter in the kernel 
> for performance reasons.  You can't have it both
> ways.  Either you're 
> concerned about performance (and you use something
> efficient and 
> compact), or you're not concenred about performance
> (and you use 
> whatever high-level language you want IN USERSPACE).

I'm looking for balance. I want to benefit from high
level language and have reasonable performance.

> 
> 
> > 
> > There were times when userland projects were
> written
> > in Assembler. Now people are using other
> languages,
> > too. May be it's time to try something new in the
> > kernel, too :-) Or we will not consider that
> because
> > nobody did that before? Someone should be the
> first
> > :-)
> 
> The kernel is not the appropriate place for this. 
> An OS kernel exists 
> to provide a minimal set of services necessary for
> applications to make 
> efficient use of resources.  (Microkernels take this
> to the extreme with 
> their layering.) 

This is a good explanation, why I use kernel. You
admitted that microkernels are extreme. I didn't want
to change such basic architectural model of Linux.
What you suggest to do is to make microkernel. Sys
call goes to kernel, instead of serving this request
you suggest to forward this call to the userspace,
than get it back and continue to serv it in the
kernel. Worse of two worlds - kernels serv syscalls
inside, microkernels - outside; you suggest to serv it
both - outside and inside.

It was hard for me to predict performance and
architectural penalties of such solution. For each
syscall perform - task switch (can we predict when
scheduler decided to give control to the userspace
security server and than back to initial
appliaction?), context switch (kernelspace/userspace
and back), priority switch - process which issued sys
call is with one priority, security server - with
another. System behaviour become very complex and
forwarding syscalls to userspace affects basic
architecture of Linux.

> Only when something CANNOT be
> accomplished in 
> userspace (or performance in userspace is terrible)
> should something be 
> put into the kernel.
> 
> As I've said before, the overhead of actually
> interpreting a high-level 
> language is probably great enough that the
> context-switch overhead you 
> don't want would diminish.

This overhead is very predictable (having the size of
particular security policy and defined security
model). So it close to real-time, which is good for
kernel. Switching between tasks, environments and
priorites during the service of just one system call
is not predicatble at all and more complex.

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
