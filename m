Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVAKQMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVAKQMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVAKQMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:12:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:11653 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262816AbVAKQLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:11:38 -0500
Date: Tue, 11 Jan 2005 08:10:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bastian Blank <bastian@waldi.eu.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
Subject: Re: removing bcopy... because it's half broken
In-Reply-To: <20050111101010.GB27768@wavehammer.waldi.eu.org>
Message-ID: <Pine.LNX.4.58.0501110805560.2373@ppc970.osdl.org>
References: <20050109192305.GA7476@infradead.org> <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
 <20050109203459.GA28788@infradead.org> <Pine.LNX.4.58.0501091240550.2339@ppc970.osdl.org>
 <20050111101010.GB27768@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jan 2005, Bastian Blank wrote:
> 
> Yes. This means IMHO that the image and every module needs to link
> against libgcc to include the required symbols. It is rather annoying to
> see modules asking for libgcc symbols.

Some architectures do that. Not all. My argument has always been that we
don't _want_ any code that gcc cannot generate.

The kernel very much on purpose does not trust gcc. There have been some 
total braindamages over time, like having exception handling turned on by 
default by gcc by default in plain C, and one of the reasons we noticed 
was that the link wouldn't work - libgcc has the exception support, and 
the kernel simply doesn't WANT that kind of crap.

It's also been useful (although at times a bit painful) to find cases
where people did stuff that simply shouldn't be done in the kernel. Things
like FP conversions, or - more commonly - 64-bit divides on hardware where
that is very slow.

It does mean that we have to know about some gcc internals ourselves, and
have our own libgcc versions for the stuff we _do_ want.

			Linus
