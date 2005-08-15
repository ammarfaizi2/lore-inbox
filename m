Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVHOPuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVHOPuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 11:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVHOPuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 11:50:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964802AbVHOPuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 11:50:20 -0400
Date: Mon, 15 Aug 2005 08:50:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works
 fine.
In-Reply-To: <43008C9C.60806@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> 
 <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com>
 <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no>
 <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Aug 2005, Helge Hafting wrote:
>
> Ok, I have downlaoded git and started the first compile.
> Git will tell when the correct point is found (assuming I
> do the "git bisect bad/good" right), by itself?

Yes. You should see 

	Bisecting: xxx revisions left to test after this

and the "xxx" should hopefully decrease by half during each round. And t 
the end of it, you should get

	<sha1> is first bad commit

followed by the actual patch that caused the problem.

> Is there any way to make git tell exactly where between rc4 and rc5
> each kernel is, so I can name the bzimages accordingly?

You'd have to use the raw commit names, since these things don't have any 
symbolic names. You can get that by just doing

	cat .git/HEAD

which will give you a 40-character hex string (representing the 160-bit 
SHA1 of the top commit). Not very readable, but it's unique, and if you 
report that hex string to other git users, they can trivially recreate the 
tree you have.

> It takes some time to trigger the bug, so I could possibly end up with
> a falsely ok kernel.  Is there a simple way to restart the search from 
> that point, or will I have to start over with rc4 and rc5 and say
> git bisect good/bad until I reach the point of mistake?

If you remember/save the good/bad commit ID's, you can restart the whole
process and just feed the correct state for the ID's:

	git bisect start
	git bisect bad v2.6.13-rc5
	git bisect good v2.6.13-rc4
	.. here bisect will start narrowing things down ..
	git bisect bad <sha1 of known bad>
	git bisect good <sha1 of known good>
	..

ie you can always feed an arbitrary number of known good/bad points by
naming them by their SHA1 ID (or their symbolic name, as in the
v2.6.13-rcX releases).

		Linus
