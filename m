Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267628AbUHWWXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267628AbUHWWXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267293AbUHWWTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:19:51 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:5519 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267628AbUHWWSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:18:38 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 23 Aug 2004 15:18:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408231516460.3222@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <20040823233249.09e93b86.ak@suse.de> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Linus Torvalds wrote:

> On Mon, 23 Aug 2004, Davide Libenzi wrote:
> > 
> > The eventually double GPF would happen only on TSS-IObmp-lazy tasks, ie 
> > tasks using the I/O bitmap.
> 
> You could also check for the error code (at least the low 16 bits) being 
> 0, I guess, just to cut down the noise.

Yep, that's right there available.



> >	 The check for the I/O opcode can certainly be 
> > done though, even if it'd make the code a little bit more complex.
> 
> Have to be very careful there to avoid nasty security issues. And with
> ins/outs, you can have various prefixes etc, so decoding is not as trivial
> as it could otherwise be. Even the regular in/out can have a data size
> overrides..
> 
> in/out is also commonly used from vm86 mode, so decoding it really needs
> to get all of the segmentation base crap right too. Nasty nasty nasty. 
> 
> In short, I think that if we do this at all, I'd much rather just do the
> simple "trap twice" thing that Davide did. It's too easy to get it wrong
> otherwise.

IMHO since the GPF path is not a fast path like a page fault, we shouldn't 
be in bad shape with the current approach. No?



- Davide

