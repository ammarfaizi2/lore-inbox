Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265237AbSJRQtd>; Fri, 18 Oct 2002 12:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265215AbSJRQtd>; Fri, 18 Oct 2002 12:49:33 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:13578 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S265220AbSJRQsq>;
	Fri, 18 Oct 2002 12:48:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] remove sys_security
Date: Fri, 18 Oct 2002 18:54:36 +0200
User-Agent: KMail/1.4.3
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <200210181830.28354.russell@coker.com.au> <20021018173339.A7481@infradead.org>
In-Reply-To: <20021018173339.A7481@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210181854.36031.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002 18:33, Christoph Hellwig wrote:
> On Fri, Oct 18, 2002 at 06:30:28PM +0200, Russell Coker wrote:
> > So how does it harm the mainline kernel to have a system call reserved
> > for LSM and then not allow anything in the mainline kernel that uses it? 
> > Then we can deploy modules using the current LSM design without harming
> > the mainline kernel.
>
> IT adds infrastructure to implement syscalls without peer review.

It is no easier to add syscalls without peer revies in the LSM model than it 
is to add them directly.  LSM merely avoids the risk of syscall conflict.

Adding syscalls without review starting at a number 1000 greater than the 
current highest syscall should remove the risk of number conflict to merely a 
risk of patch conflict.

Removing the LSM syscall does not remove this problem.

> > The only code that we really want to see in the mainline kernel is the
> > hooks for permission checks.  Personally I would not mind if no security
> > module ever gets included in Linus' source tree.
>
> And exactly these hooks harm.  They are all over the place, have
> performance and code size impact and mess up readability.  Why can't you
> just maintain an external patch like i.e. mosix folks that nead similar
> deep changes?

One problem with maintaining an external patch that makes lots of deep changes 
is that any patch of note will conflict with it.  For most people who use 
such patches that's a huge problem.  I'm not a great kernel coder, so most of 
the kernel coding that I do is involved with resolving such patches not 
actually doing anything interesting.  I'd prefer to be able to spend that 
time on other tasks, which would include working on some of the issues with 
coreutils we discussed.

If we remove make-work tasks from other programmers (such as repeated work to 
keep a patch up to date and in-sync with other patches) then they can spend 
their time productively on other tasks.

Another issue with LSM is that it's not as easy to test as Mosix.  With Mosix 
you can test that everything works, although these tests may not be easy 
(Mosix is complex) they can give a satisfactory result.  For security you 
can't test it in an authoritative fashion, if a certain parameter to a 
syscall results in a permission check being skipped you can't determine this 
by testing.  Part of the solution to this is to have the LSM code in the 
mainline kernel so we are all working on the same version.  Another part is 
the ongoing research that IBM people are performing on validating kernel 
hooks.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

