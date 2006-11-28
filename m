Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757385AbWK1XHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385AbWK1XHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757761AbWK1XHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:07:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757385AbWK1XHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:07:14 -0500
Date: Tue, 28 Nov 2006 15:06:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Don't compare unsigned variable for <0 in sys_prctl()
In-Reply-To: <9a8748490611281434g3741045v5e7f952f633e08d3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611281459331.4244@woody.osdl.org>
References: <200611282317.14020.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0611281425220.4244@woody.osdl.org>
 <9a8748490611281434g3741045v5e7f952f633e08d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2006, Jesper Juhl wrote:
>
> > Friends don't let friends use "-W".
> 
> Hehe, ok, I'll stop cleaning this stuff up then.
> Nice little hobby out the window there ;)

You might want to look at some of the other warnings gcc spits out, but 
this class isn't one of them.

Other warnings we have added over the years (and that really _are_ good 
warnings) have included the "-Wstrict-prototypes", and some other ones.

If you can pinpoint _which_ gcc warning flag it is that causes gcc to emit 
the bogus ones, you _could_ try "-W -Wno-xyz-warning", which should cause 
gcc to enable all the "other" warnings, but then not the "xyz-warning" 
that causes problems.

Of course, there is often a reason why a warning is in "-W" but not in 
"-Wall". Most of the time it's sign that the warning is bogus. Not always, 
though - we do tend to want to be fairly strict, and Wstrict-prototypes is 
an example of a _good_ warning that is not in -Wall.

		Linus
