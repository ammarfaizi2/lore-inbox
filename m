Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbUBPWRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUBPWRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:17:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:12760 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265937AbUBPWRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:17:15 -0500
Date: Mon, 16 Feb 2004 14:17:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: stty utf8
In-Reply-To: <20040216220356.GC18853@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402161413550.30742@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216150501.GC16658@mail.shareable.org>
 <20040216220356.GC18853@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Jamie Lokier wrote:
> 
> I little thought and an experiment later, and I discovered:
> 
> When you edit a line with the kernel's terminal line editor, when you
> press the Delete key, it writes backspace-space-backspace and removes
> one byte from the input.  That fails to do the right thing on UTF-8
> terminals.

Yes. I looked at that a year ago, and it should be pretty easy to make the 
backspace code look more like the "delete word" code - except the "word" 
is just a utf character.

(Btw, that's one of the things I like about UTF-8, and shows how _well_ 
designed it is - it's trivial to find the beginning of a UTF-8 character, 
even when just doing a stupid scan backwards).

I didn't care enough to really bother fixing it - the fact is, that people 
who care about UTF-8 tend to have to be in graphics mode anyway, and there 
is something to be said for keeping the text console simple even if it 
means it lacks functionality.

But if somebody cares more than I do (hint, hint ;), I do think it should 
be fixed.

> There is no fancy environment setting which corrects this problem.
> The kernel needs to know it's dealing with a UTF-8 terminal for basic
> line editing to work.

Yes. And I'd happily take patches for it.

		Linus
