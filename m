Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUDFN0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUDFN0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:26:16 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:51448 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263803AbUDFN0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:26:13 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>,
       Timothy Miller <miller@techsource.com>
Subject: Re: kernel stack challenge
Date: Tue, 6 Apr 2004 08:25:35 -0500
X-Mailer: KMail [version 1.2]
Cc: Chris Wright <chrisw@osdl.org>, John Stoffel <stoffel@lucent.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <20040405234957.69998.qmail@web40509.mail.yahoo.com>
In-Reply-To: <20040405234957.69998.qmail@web40509.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <04040608253500.31915@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 April 2004 18:49, Sergiy Lozovsky wrote:
> --- Timothy Miller <miller@techsource.com> wrote:
> > Sergiy Lozovsky wrote:
> > > LSM use another way of doing similar things :-)
> >
> > I'm
> >
> > > not sure that it is nice to forward system calls
> >
> > back
> >
> > > to userspace where they came from in the first
> >
> > place
> >
> > > :-) VXE use high level language to create security
> > >
> > > models.
> >
> > "Kernel space -> user space -> kernel space" is
>
> To be more precise "user space -> kernel space -> user
> space -> kernel space -> user space"
>
> against ordinary "user space -> kernel space -> user
> space"
>
> So, what happens - task makes system calls and blocks;
> request goes to a user space security server. Will it
> process request right away? No, it will wait for
> scheduler to chose it for execution. Ok server got CPU
> and returns results to the kernel. Will initial task
> continue? No, it will wait for be chosen by scheduler.
> This is what I call overhead (though i understand,
> that can be wrong). My system (VXE) doesn't involve
> scheduler at all.

Depends on what the requirement is. In some cases you
MUST do this - otherwise the tables required for making
the decision would be WAY too large for the kernel.

Some models even require reference to remote hosts
for validation. The current Kerberos authentication
requires this. So do AFS requests.

Other requests can be satisfied by a cached table entry
without waiting.

> So we should not just look into length of this chain
> at the picture. - "user space -> kernel space -> user
> space -> kernel space -> user space" - we should
> remember that it involves to mandatory task switches
> to accomplish jus one system call.

It only depends on the request. If the entire security
context is local, then this is not required.

> > nothing compared to the
> > overhead of a LISP interpreter.
>
> LISP code, is very small actually. And nobody can just
> kill it. I know it's not a real protection, but intent
> was to place a security system in such place where it
> will be more protected by itself. I placed additional
> security mechanisms in the place where designers of
> UNIX placed theirs (file permissions an so on) - in
> the kernel.

LISP code (if compiled machine code) IS small. LISP
VM is not - when you combine it with the lisp code,
the heap management, and garbage collector. And you
can STILL have memory leaks out the wazoo. To prevent
the memory leaks you have to have a mark and sweep GC.
Which still doesn't prevent circular loop leaks. Then
you need a memory pool allocator to relocate all valid
references. The combination is NOT small. BTW, the JVM
suffers from circular loop leaks too, since all it uses
is reference counting (for speed).

> > Doing interpretation of LISP is a monster compared
> > to some piddly
> > context switches.
>
> When people say LISP they mean Common LISP, which is a
> monster and I agree with you. VXE uses stripped down
> version of LISP and syntax of LISP is far simpler than
> C for example.

No - they mean the VM + garbage collector + error handler +
the lisp pcode.
