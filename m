Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbUKVS6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUKVS6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUKVS4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:56:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:55995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262266AbUKVSyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:54:22 -0500
Date: Mon, 22 Nov 2004 10:54:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <20041122183956.GA50325@gaz.sfgoth.com>
Message-ID: <Pine.LNX.4.58.0411221047140.20993@ppc970.osdl.org>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
 <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0411211644200.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411221132550.8845@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0411220812580.20993@ppc970.osdl.org> <20041122183956.GA50325@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Mitchell Blank Jr wrote:
> 
> When I want to do that I just use:
> 
> 	#define MAX_SOMETHING (max_of_something + 0)

Yes, I think I've done that too, and that works. My point is that the 
silly comma-expression should _also_ work, and I don't see any _valid_ use 
of the comma-expression as an lvalue.

I suspect (but don't have any real argument to back that up) is that the
gcc "extended lvalues" fell out as a side effect from how gcc ended up
doing some random semantic tree parsing, and it wasn't really "designed"
per se, as much as just a random implementation detail. Then somebody 
noticed it, and said "cool" and documented it.

That's actually in my opinion a really good way to occasionally find a
more generic form of something - the act of noticing that an algorithm
just happens to give unintentional side effects that can actually be
mis-used. So I don't think that it's a bad way per se to add features,
especially as they then are often free (or even "negative cost", since
_not_ adding the feature would entail having to add a check against it).

And for all I know, many of the _good_ gcc features ended up being done 
that way too. 

But I think the (unintentional) downsides of these features are bigger 
than the advantages.

		Linus
