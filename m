Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTEEQxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTEEQxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:53:16 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:4812
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S263650AbTEEQvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:51:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16054.38799.132644.16835@panda.mostang.com>
Date: Mon, 5 May 2003 09:55:43 -0700
To: Richard Henderson <rth@twiddle.net>
Cc: David.Mosberger@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
In-Reply-To: <20030505163444.GB9342@twiddle.net>
References: <20030502004014$08e2@gated-at.bofh.it>
	<20030503210015$292c@gated-at.bofh.it>
	<20030504063010$279f@gated-at.bofh.it>
	<ugade16g78.fsf@panda.mostang.com>
	<20030505074248.GA7812@twiddle.net>
	<16054.32214.804891.702812@panda.mostang.com>
	<20030505163444.GB9342@twiddle.net>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: David.Mosberger@acm.org
X-URL: http://www.mostang.com/~davidm/
From: davidm@mostang.com (David Mosberger-Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 5 May 2003 09:34:44 -0700, Richard Henderson <rth@twiddle.net> said:

  Richard> On Mon, May 05, 2003 at 08:05:58AM -0700, David
  Richard> Mosberger-Tang wrote: Why?  Certainly it isn't needed for
  Richard> x86.
  >>  Certain applications (such as debuggers) want to know.  Sure,
  >> you can do symbol matching (if you have the symbol table) or
  >> code-reading (assuming you know the exact sigreturn sequence),
  >> but having a marker would be more reliable and faster.

  Richard> Eh.  The whole point was to *eliminate* the special cases.

Signal handlers have special significance on UNIX-like operating
systems.  An application might want to know when it's in a signal
frame.  If it's a problem to do this with DWARF2 info, fine.  If not,
please consider adding a marker (my current version of libunwind for
x86 does code-reading to detect signal-frames; not pretty, but it
works reasonable well in practice; it would be nicer to get rid of the
code-reading though, in the future).

	--david
