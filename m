Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWFMXpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWFMXpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWFMXpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:45:52 -0400
Received: from web25218.mail.ukl.yahoo.com ([217.146.176.204]:5208 "HELO
	web25218.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932180AbWFMXpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:45:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=OYfZTIXU1bXb5tCbr4lDo/i67khayVW8NnA7RcJcTzFzvM9lcTMRmIQD/rvOIjh1KXvxw1V+WktDiIaOxr9uoG6pF+8bxr3b5F3PLkKpJwLS6ySr0pIZRfxLpzuJECTI5s2NQyMJDZOA+PMiBIHVaihwlhVQARfjEABtxrae2fk=  ;
Message-ID: <20060613234551.69651.qmail@web25218.mail.ukl.yahoo.com>
Date: Wed, 14 Jun 2006 01:45:51 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [UML] Problems building and running 2.6.17-rc4 on x86-64
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060613182129.GA4619@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Tue, Jun 13, 2006 at 11:57:18AM -0300, Alberto Bertogli wrote:
> > I just wanted to report that this went away when trying
> 2.6.17-rc6 as a
> > host. It also works fine as a guest (after I patch it with
> >
>
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf
> > so that it builds).

> > Besides, the random segfault problems I had with previous guests
> > versions also seem to be fixed.

> These two problems are related, and were both on the host.  Bodo
> Stroesser reported a while ago that ptrace, by returning via sysret
> rather than iret, could cause register corruption when tracing
> sigreturn.

> The UML crash seems to have been caused by the fix to that problem.

If that problem has been fixed, this would imply that SKAS should
work on x86-64... or not? Well, I remember that problem being on IA32
emulation and IA32 wasn't included in the patch (for what I can see).
Can you ask more information about this? Also, could you verify if at
least with noprocmm and a host SKAS-V9 it works? Two things are to
check:
* Uml64 should use /proc/mm64 (unimplemented)
* Uml64 should use the right version of PTRACE_FAULTINFO (I don't
remember what I did, if I introduced PTRACE_EX_FAULTINFO or if I
directly added the missing trap_no field in PTRACE_FAULTINFO; please
verify).

I won't have the time to check this at least until the 22 June.

Bye

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
