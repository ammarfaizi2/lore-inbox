Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313483AbSC2RIb>; Fri, 29 Mar 2002 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313482AbSC2RIV>; Fri, 29 Mar 2002 12:08:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:11001 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313481AbSC2RII>;
	Fri, 29 Mar 2002 12:08:08 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15524.40817.306204.292158@napali.hpl.hp.com>
Date: Fri, 29 Mar 2002 09:08:01 -0800
To: Christoph Hellwig <hch@infradead.org>
Cc: davidm@hpl.hp.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
In-Reply-To: <20020329160618.A25410@phoenix.infradead.org>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 29 Mar 2002 16:06:18 +0000, Christoph Hellwig <hch@infradead.org> said:

  Christoph> On Fri, Mar 29, 2002 at 07:46:07AM -0800, David Mosberger
  Christoph> wrote:
  >> Christoph, why do you think the prototype for ia64 is different?

  Christoph> I have stopped to wonder why ia64 does things
  Christoph> differently.

You might want to reconsider that stance.  It could open your mind. ;-)

BTW: this is not at all an ia64-specific issue.  It applies to any
arch that doesn't maintain a frame pointer on the stack.  Basic
compiler technology.

  >> It's because it *has to be*.  In general, you can't do a
  >> backtrace without having the full (preserved) state of the CPU at
  >> the point of which the backtrace begins.

  Christoph> So your suggestion is to move the other architectures to
  Christoph> the ia64 prototype or to not have an
  Christoph> architecture-independand stack-traceback facility at all?

I haven't done such an investigation.  I believe the ia64 prototype is
reasonable and probably implementable on all platforms that can unwind
the stack in the first place, but before making a change to the stable
kernel API, I'd think someone would have to investigate this a bit
further.

One issue to consider is whether it's safe to call the routine on a
task that is running on another processor.  The ia64 implementation
can handle this gracefully, because it's sometimes better to print a
meaningless (garbled) stack trace than to make provably certain that
the task won't be running on any other CPU.  A related question is
whether the routine can be called with interrupts masked.

My sense is this is something that should be considered for 2.5 first.

	--david
