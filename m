Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbTLIHUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 02:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbTLIHUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 02:20:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:61878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265544AbTLIHUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 02:20:13 -0500
Date: Mon, 8 Dec 2003 23:19:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, Nikita Danilov <Nikita@Namesys.COM>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
In-Reply-To: <20031209034935.GA26987@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0312082317450.18255@home.osdl.org>
References: <200312081646.42191.arnd@arndb.de> <3FD4B9E6.9090902@zytor.com>
 <16340.49791.585097.389128@laputa.namesys.com> <3FD4C375.2060803@zytor.com>
 <20031209025952.GA26439@mail.shareable.org> <3FD53FC6.5080103@zytor.com>
 <20031209034935.GA26987@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Dec 2003, Jamie Lokier wrote:
>
> (A long time ago there was a question about whether GCC could ever
> copy the value associated with an "m" operand to a stack slot, and
> pass the address of the stack slot.  After all, GCC _will_ copy the
> value if the operand is an "r", and presumably gives mixed results
> with "rm".  We seem to have concluded that it never will).

We never never concluded that they never would, but we did (I think)
convince the gcc people that a memory operand to an asm should always be
considered a lvalue. That will effectively mean that we know a memory op
will never be moved around - because then it wouldn't be the same lvalue
any more (a lvalue is literally defined by its address).

So yes, I think we can depend on it now, although we historically
couldn't.

		Linus
