Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSGZSjS>; Fri, 26 Jul 2002 14:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317979AbSGZSjR>; Fri, 26 Jul 2002 14:39:17 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:1257 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317977AbSGZSjO>;
	Fri, 26 Jul 2002 14:39:14 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15681.38933.698148.860188@napali.hpl.hp.com>
Date: Fri, 26 Jul 2002 11:42:29 -0700
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: performance experiment
In-Reply-To: <Pine.LNX.4.44.0207261107140.1561-100000@blue1.dev.mcafeelabs.com>
References: <200207261746.g6QHkjUp005023@napali.hpl.hp.com>
	<Pine.LNX.4.44.0207261107140.1561-100000@blue1.dev.mcafeelabs.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Jul 2002 11:09:31 -0700 (PDT), Davide Libenzi <davidel@xmailserver.org> said:

  Davide> On Fri, 26 Jul 2002, David Mosberger wrote:
  >> Below is a patch that implements an alternate version of the core-loop
  >> of do_select().  I'm interested in hearing how the two versions
  >> (original and new) compare on various architectures.  The new loop
  >> happens to perform better on ia64 and I suspect the same will be true
  >> for most RISC platforms.  It wouldn't surprise me if the new loop
  >> performed better even on some instances of x86.  I suspect on older
  >> x86s (e.g., 80486), the old loop does better.  If someone is running
  >> Linux on a Transmeta Crusoe chip, I'd be *very* interested in hearing
  >> how the two loops perform there.
  >> 
  >> Here is what I'm proposing to do: if a couple of people are willing to
  >> try out the patch below, I'll collect the results and post a summary.
  >> To make sure we're comparing apples to apples, I'd like to suggest to
  >> run LMbench 2 with and without the patch below.  Then send me the
  >> select results from the raw results file.  For example, you would run
  >> lmbench like so:
  >> 
  >> $ make rerun
  >> 
  >> Then look at the results file, which is stored in
  >> results/CONFIG/HOSTNAME.N.  For example, on a Pentium III machine
  >> called "adler", the results of the first run would be stored in
  >> 
  >> results/i686-pc-linux-gnu/adler.0
  >> 
  >> I'd prefer if you sent me the complete result files, but if you don't
  >> want to do that, it should be good enough to mail me the first and
  >> second line of the file, all the lines starting with "Select", and a
  >> description of the machine you were testing (CPU type, clock speed,
  >> chipset, memory size, and compiler version would be ideal).  For the
  >> above example, the lines of interest would be:

  Davide> i posted a 95% matching patch about one year ago but it fell
  Davide> inside the Alan drop basket :-) basically

Yes, there is nothing deep in the patch.  If it wasn't for
register-starved architectures such as x86, it would be the obviously
correct thing to do.  Actually, it's a lot easier to convert register
accesses into memory accesses than vice versa, so in principle, the
new loop should do better even on x86 (this reasoning is what triggers
my interest in how Crusoe fares).

Of course, principles get often hit by that nasty thing called reality
(such as the reality of a poor compiler), so I do think some
experimentation is in place.  (I should probably also say that my
primary aim is not to speed up select(); if that's an outcome of this
work, fine, but it I'm really more interest in how the two loops
perform across different architectures and implementations).

  Davide> Alan requested perf numbers that i did not have time to
  Davide> supply. glad you did them ...

Well, I have _not_ done them.  I really do need help from others here,
as I have access only to so many types of machines.

Thanks,

	--david
