Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTLZEes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 23:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTLZEes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 23:34:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:60614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264464AbTLZEer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 23:34:47 -0500
Date: Thu, 25 Dec 2003 20:34:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
In-Reply-To: <bsgav5$4qh$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
References: <1072403207.17036.37.camel@clubneon.clubneon.com>
 <bsgav5$4qh$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Dec 2003, H. Peter Anvin wrote:
> > 
> > Other than the constant barrage of warnings about the use of compound
> > expressions as lvalues being deprecated* (mostly because of lines 114,
> > 116, and 117 of rcupdate.h, which is included everywhere), the build
> > goes very well.
> > 
> > *It also doesn't like cast or conditional expressions as lvalues.
> > 
> 
> Okay, that's just insane...

Actually, those language extensions (while documented for a long time) are 
pretty ugly. 

Some of that ugliness turns into literal bugs when C++ is used.

The cast/conditional expression as lvalue are _particularly_ ugly 
extensions, since there is absolutely zero point to them. They are very 
much against what C is all about, and writing something like this:

	a ? b : c = d;

is something that only a high-level language person could have come up 
with. The _real_ way to do this in C is to just do

	*(a ? &b : &c) = d;

which is portable C, does the same thing, and has no strange semantics.

Similarly, what the _hell_ does the gcc extension

	int a;

	(char)a += b;

really mean? The whole extension is just braindamaged, again probably 
because there were non-C people involved at some point. It's very much 
against the C philosophy. I bet 99% of the people on this list have no 
clue what the exact semantics of the above are.

		Linus
