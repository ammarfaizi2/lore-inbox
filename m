Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUH1UhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUH1UhS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUH1Uff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:35:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:8576 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268003AbUH1UR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:17:57 -0400
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408231516460.3222@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
	 <20040823233249.09e93b86.ak@suse.de>
	 <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
	 <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
	 <Pine.LNX.4.58.0408231516460.3222@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093353962.2810.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 Aug 2004 20:15:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 23:18, Davide Libenzi wrote:
> > >	 The check for the I/O opcode can certainly be 
> > > done though, even if it'd make the code a little bit more complex.
> > 
> > Have to be very careful there to avoid nasty security issues. And with
> > ins/outs, you can have various prefixes etc, so decoding is not as trivial
> > as it could otherwise be. Even the regular in/out can have a data size
> > overrides..

And an attacker can be changing the mappings in another thread at the
same time. Now you see it, now you don't. This gets quite fun with
writing fixups to user space code but isnt a big deal for reads.

> > In short, I think that if we do this at all, I'd much rather just do the
> > simple "trap twice" thing that Davide did. It's too easy to get it wrong
> > otherwise.
> 
> IMHO since the GPF path is not a fast path like a page fault, we shouldn't 
> be in bad shape with the current approach. No?

Even the X server doesn't generally make heavy use of I/O port access on
any vaguely modern hardware. The BIOS might but its already doing some
of its own vm86 fixups for this.

