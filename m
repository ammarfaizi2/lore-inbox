Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268852AbRHKVDw>; Sat, 11 Aug 2001 17:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268837AbRHKVDn>; Sat, 11 Aug 2001 17:03:43 -0400
Received: from web20001.mail.yahoo.com ([216.136.225.46]:61202 "HELO
	web20001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268848AbRHKVDY>; Sat, 11 Aug 2001 17:03:24 -0400
Message-ID: <20010811210336.39004.qmail@web20001.mail.yahoo.com>
Date: Sat, 11 Aug 2001 14:03:36 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: Re: __asm__ usage ????
To: Daniel Egger <egger@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <997551186.791.68.camel@sonja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Many thanks for ur reply but my actual meaning of
 question 4 and 6 was different. Please see 
 the comments inline below and kindly clarify
 my doubts???

  Thankyou in advance.
  Raghava. 

--- Daniel Egger <egger@suse.de> wrote:
> Am 10 Aug 2001 12:50:04 -0700 schrieb Raghava Raju:
> 
> >    I want some basic insights into assembly level
> code
> > emmbedded in C language. Following is the code of
> > PowerPc ambedded in C languagge:
> 
>  It's not really kernel related but nevertheless...
> 
>  
> > unsigned long old,mask, *p;
> > 
> > 	__asm__ __volatile__(SMP_WMB "\
> > 1:	lwarx 	%0,0,%3
> > 	andc  	%0,%0,%2
> > 	stwcx 	%0,0,%3
> > 	bne 	1b"
> > 	SMP_MB
> > 	: "=&r" (old), "=m" (*p)
> > 	: "r" (mask), "r" (p), "m" (*p)
> > 	: "cc")"
> >         4) I think in power PC we can't access
> > directly the contents of memory, but we should 
> > give addresses of memory in registers then use
> > registers in instructions to access memory. But in
> > above example he is using %3 in lwarx command
> > accessing that memory directly. Is my
> interpretation
> > of above instructions wrong.
> 
> Yes, you're wrong. By issuing an "r" (p) the p
> (which is a
> pointer in this case) is assigned to a register
> which is then
> used in the load command as the absolute address.
> 
   What I meant is that say in command 
    "andc  	%0,%0,%2" he is directly accessing the
    contents of memory and using them in "andc". But
    it seems to be that he should use indirectly, like
   storing the address of variable in register. Then 
   use register in "andc" instead of directly using 
   %0(i.e accessing memory directly). Correct me if 
   I am wrong since powerPC mannual described that 
   we should not use memory directly in instructions.

> >         6) Finally I want to write a simple
> programme
> > to write the contents of a local variable "xyz"
> into
> > register r33, then store the contents of r33 into
> > local variable "abc". Kindly would u give me a
> sample
> > code of doing it.
> 
> Negative for two reasons: There is no register 33
> (at least)
> on 32bit PPC CPUs, and second, you normally don't
> want to
> hardcode registers in inline assembly. If you really
> want to
> then use normal assembly.
> 
> But for your example:
> long xyz, abc;
> 
> __asm__ __volatile__ ("mr %0,%1\n\t": "r" (abc) :
> "r" (xyz));
>  
> However this is a really dumb example.
Here I dont bother about logic of the example, but 
I want know how to load the value of some (valid 
register, if not r33 something else  in powerPC)
register into a local variable xyz and vice versa.


> 
> Servus,
>        Daniel
> 


__________________________________________________
Do You Yahoo!?
Send instant messages & get email alerts with Yahoo! Messenger.
http://im.yahoo.com/
