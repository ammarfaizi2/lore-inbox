Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265797AbSLIRTy>; Mon, 9 Dec 2002 12:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbSLIRTy>; Mon, 9 Dec 2002 12:19:54 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:16585 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265797AbSLIRTy>;
	Mon, 9 Dec 2002 12:19:54 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.53866.127553.424553@napali.hpl.hp.com>
Date: Mon, 9 Dec 2002 09:27:06 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <Pine.LNX.4.44.0212090828460.3397-100000@home.transmeta.com>
References: <20021209154142.GA22901@nevyn.them.org>
	<Pine.LNX.4.44.0212090828460.3397-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 9 Dec 2002 08:48:13 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> Architecture maintainers, can you comment on how easy/hard it
  Linus> is to do the same thing on your architectures? I _assume_
  Linus> it's trivial (akin to the three-liner register state change
  Linus> in i386/kernel/signal.c).

It's not trivial on ia64: we keep the syscall arguments in registers
(the stacked registers, to be precise), so to modify them, we need to
(a) flush the stacked registers to memory and (b) find the frame that
contains the syscall arguments, (c) patch the values in memory, and
(d) reload the stacked registers.  It's doable (like you say, ptrace()
does it already), but that's about the best I can say about it...

	--david
