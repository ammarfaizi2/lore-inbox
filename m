Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbUDFWgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264055AbUDFWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:36:09 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:64014 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264036AbUDFWf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:35:57 -0400
Message-ID: <407335B3.1070200@techsource.com>
Date: Tue, 06 Apr 2004 18:56:51 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040406220521.56509.qmail@web40513.mail.yahoo.com>
In-Reply-To: <20040406220521.56509.qmail@web40513.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergiy Lozovsky wrote:
> --- Timothy Miller <miller@techsource.com> wrote:
> 
>>
>>Horst von Brand wrote:

>>>OK, so you need the policy to be interpreted
>>in-kernel (dunno why a
>>>largeish high-level general purpose language is
>>needed for that, when a
>>>tiny interpreter for a specialized language will
>>do very well, and has been
>>>shown to work fine), and written in a "high level
>>language" so that your
>>>garden variety sysadmin _can_ write her own
>>policy, but it really doesn't
>>>matter because she'll never have to do so...
>>>Completely lost me.
>>
>>I was getting hung up on that one too, but I didn't
>>know how to say it. 
>>  You did a nice job.  :)
> 
> 
> Can you guys be more specific? I don't see any
> technical objections. The only one is that performance
> would suffer because of use of higher level language
> than C or Assembler.

That IS one of the objections, but it's not the objection HERE.

The objection here is that we see an inconsistency:

A) You support the idea of using LISP because it's a high-level language 
that sysadmins can use to develop policies.

B) But then you say that sysadmins won't be developing policies.

Therefore, you invalidate your reason for wanting to use LISP.

> 
> There is a reason people use languages like PERL, Java
> and so on. I would prefer to spend less time writing
> actual code - this is what these high level languages
> for. If performance would be most important - people
> would do everything in Assembler, but they don't. I'd
> better write a small Assembler subroutine which will
> handle stack problems for me and benefit from using
> the high level language after that.

As a matter of fact, the only reason people object to using LISP is 
because you want to do it IN THE KERNEL.

If you want the interpreter to live in the kernel, then you have to use 
something MUCH SIMPLER and something which doesn't eat stack like LISP does.

On the other hand, if you were to put hooks into the kernel so that 
people could use ANY LANGUAGE THEY WANTED, IN USER SPACE, then people 
would be very happy with you.  This way, you can waste all the memory 
you want on the interpreter, but it's okay because it's:

(1) extremely optional
(2) extremely replacable (interpretor can be any language)
(3) swappable
(4) can't clobber the kernel
(5) can use as much stack space as it wants
(6) minimally impacts what IS in the kernel, etc.

You down-play the performance impact of using LISP above, but you 
contradict that by saying you want to put the interpreter in the kernel 
for performance reasons.  You can't have it both ways.  Either you're 
concerned about performance (and you use something efficient and 
compact), or you're not concenred about performance (and you use 
whatever high-level language you want IN USERSPACE).


> 
> There were times when userland projects were written
> in Assembler. Now people are using other languages,
> too. May be it's time to try something new in the
> kernel, too :-) Or we will not consider that because
> nobody did that before? Someone should be the first
> :-)

The kernel is not the appropriate place for this.  An OS kernel exists 
to provide a minimal set of services necessary for applications to make 
efficient use of resources.  (Microkernels take this to the extreme with 
their layering.)  Only when something CANNOT be accomplished in 
userspace (or performance in userspace is terrible) should something be 
put into the kernel.

As I've said before, the overhead of actually interpreting a high-level 
language is probably great enough that the context-switch overhead you 
don't want would diminish.

