Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267616AbUBTAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267628AbUBTAn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:43:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:61418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267616AbUBTAdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:33:06 -0500
Date: Thu, 19 Feb 2004 16:37:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Tridgell <tridge@samba.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <16437.20949.701574.932001@samba.org>
Message-ID: <Pine.LNX.4.58.0402191625060.2244@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
 <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org>
 <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org>
 <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org>
 <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org>
 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org>
 <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <16437.18605.71269.750607@samba.org>
 <Pine.LNX.4.58.0402191549500.2244@ppc970.osdl.org> <16437.20949.701574.932001@samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004 tridge@samba.org wrote:
> 
> yes, I've acknowledged that. I know you aren't going to give me the
> ideal solution, I'm just exploring how far this is from the ideal and
> trying to get a feel for how much it actually gains us compared to
> what we do now. 

I suspect the only way to know that is to code something up.

The kernel side (with the full "readdir()" loop and a TENTATIVE flag etc)  
is not likely to be that many lines of code, but it's definitely something
where the person who writes those lines needs to really understand the
kernel code to get anywhere at all. And it's in an "interesting" area of
the kernel, so you have to be really careful. And you'd need somebody who
is used to samba too, in order to do the path component walk side in user
space work right with the new interface. So..

I an try to see if I can write something - I'd not do the actual
comparison function, but I have the rough framework in my mind. I won't
get to it for another day or two, at _least_, though.

With that set up, getting numbers and doing a kernel profile to see where
the time goes is probably not hard - again, if you have a samba setup with
benchmarks already set up. I just don't know anybody who knows both pieces
of the puzzle..

(This, btw, was the big problem with pthreads too. The 2.6.x threading
improvements were things that had been discussed for years, but it took
until Ingo, Uli and Roland actually sat down and looked at both the user
side and the kernel side before anything really happened).

		Linus
