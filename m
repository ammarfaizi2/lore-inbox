Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRH3IQk>; Thu, 30 Aug 2001 04:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270121AbRH3IQb>; Thu, 30 Aug 2001 04:16:31 -0400
Received: from elin.scali.no ([62.70.89.10]:29971 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S270031AbRH3IQY>;
	Thu, 30 Aug 2001 04:16:24 -0400
Subject: Re: Multithreaded core dumps (CLONE_THREAD and elf)
From: Terje Eggestad <terje.eggestad@scali.no>
To: Elan Feingold <efeingold@mn.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000c01c13113$91d7c060$0400000a@gorilla>
In-Reply-To: <000c01c13113$91d7c060$0400000a@gorilla>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 30 Aug 2001 10:16:34 +0200
Message-Id: <999159394.23678.285.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Annyoing isn't it....

I just browsed thru the code, got curious myself since Linux has a very
flexible way of specifying the degree of sharing. If two procs share VM,
it is not necessarily said that both shall exit if one do. 

THere is a CLONE_THREAD flag to clone() that sets up a linked list thru
all the procs (shared VM or not) that in 2.4.3 that I currently run
don't seem to be ready for general use, managed to get this:
te       31504 31504  0 10:03 pts/0    00:00:00 [clone2 <defunct>]
te       31505 31504  0 10:03 pts/0    00:00:00 [clone2 <defunct>]

Where a zombie is waiting for the parent to receive it's SIGCHLD, but
it's its own parent. Kinda cute, guess Its time to reboot....

I don't know what kind of behavour it's supposed to have, but if it's
intended to to mark all the clones to die with the coredumping proc, the
data structures are properly in place, and all do_coredump need to do
is to follow the linked list (thread_group), prempth if SMP, and read of
the regs. (plus all the pitfall I don't see of course). 


A COMPLETELY different matter is weither the elf format support multiple
registers sets.... look it up, (I'm not...)

TJ

Den 30 Aug 2001 00:21:06 -0500, skrev Elan Feingold:
> Hi,
> 
> First post (although lurking on and off since 0.99pl14 or so), so please
> be gentle.
> 
> We recently convinced my company to move from VxWorks to (embedded)
> Linux.  For better or worse, our application is heavily multithreaded.
> It seems that current versions of Linux dump single-threaded core.  I've
> done a bit of research and it seems that:
> 
> - GDB is more than happy to load multiple register sets per core file.
> 
> - There are patches to the kernel dump multiple core files, one per LWP.
> This is not really helpful in my case, since we're on an embedded
> platform with little Flash to store cores.  Besides, loading up gdb on
> 10-20 core files looking for the one that had the problem doesn't sound
> very fun, as opposed to saying "info threads".
> 
> Because I am (not so) young and (very) foolish, it doesn't sound that
> hard, at first (and uneducated) glance, to dump register sets for all
> related LWPs to a single core file, even in a portable way across x86
> and PPC architectures.  Under SMP, it might be a bit trickier, but
> Solaris manages to do it, so it can't be impossible, and capturing any
> state for each thread would seem better than nothing at all, since all
> the LWPs are about to die anyways.  I'm considering using some of my
> (copious) spare time and trying to patch the kernel to do this.  I have
> a few questions:
> 
> 0. Am I wrong or confused about the state of postmortem multithreaded
> debugging under Linux?
> 
> 1. Is anyone else working on this?  If not, why not?  Am I missing
> something?
> 
> 2. If this is simply something that nobody is working on because other
> things are more interesting, can anybody give me a few pointers on where
> to start?
> 
> Best regards,
> 
> -elan
> Aspiring Kernel Hacker
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

