Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288254AbSAHTNL>; Tue, 8 Jan 2002 14:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288250AbSAHTMw>; Tue, 8 Jan 2002 14:12:52 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:51393 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288055AbSAHTMr>;
	Tue, 8 Jan 2002 14:12:47 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15419.17581.990574.160248@napali.hpl.hp.com>
Date: Tue, 8 Jan 2002 19:12:45 +0000
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: can we make anonymous memory non-EXECUTABLE?
In-Reply-To: <20020107.220208.23012783.davem@redhat.com>
In-Reply-To: <200201080025.QAA26731@napali.hpl.hp.com>
	<20020107.220208.23012783.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 07 Jan 2002 22:02:08 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> I assume this hack is "have a software EXECUTE bit, initially
  DaveM> only set the software one, when we take a fault on execute
  DaveM> set the hardware bit and maybe flush the Icache".  If so,
  DaveM> what is the big deal? :-)

Yes.  Hey, don't get me wrong: I'm *proud* of that solution, but if
the alternative is to completely get rid of the problem in the first
place, that is always preferable (simplicity rules).

  DaveM> I think changing this behavior is going to silently break
  DaveM> things on many architectures.

I don't consider SIGSEGV to be a silent failure.  Also, I think
all the evidence is that it's unlikely to break many existing
apps:

	o The bug I described has been present for *years* on
	  Alpha and probably all other platforms other than x86;
	  even on ia64 it took almost two years before someone
	  noticed.  It's possible that nobody noticed because
	  the code generators were part of a larger program,
	  but it's very likely that anyone writing a test program
	  would have allocated the non-executable memory, so you'd
	  expect *someone* to have run into it at some point.

	o Certain libraries such as the Boehm Garbage Collector
	  already turn off execute permission by default.  While
	  there may not be that many apps that use it in a production
	  environment, it is my impression that many developers are
	  using it as a memory-leak detector (e.g., Mozilla does that).


  DaveM> Secondly, I do not see any
  DaveM> real gain from any of this and my ports are those that have
  DaveM> I-cache coherency issues :-)

I think that's fine.  If the consensus is that apps *should* use
mprotect() to get executable permission (Linus implied as much) and
it's an architecture specific choice as to whether this is enforced,
I'm happy.  My belief is that we could make this change on ia64
without undue burden on programmers.  If not, I'm sure I'll find out
about it and I'm willing to take the responsibility.

	--david
