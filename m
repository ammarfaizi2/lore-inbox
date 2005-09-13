Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVIMXwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVIMXwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVIMXwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:52:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751171AbVIMXwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:52:41 -0400
Date: Tue, 13 Sep 2005 16:52:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
In-Reply-To: <4327611D.7@oberhumer.com>
Message-ID: <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org>
References: <43273CB3.7090200@oberhumer.com> <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org>
 <4327611D.7@oberhumer.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Sep 2005, Markus F.X.J. Oberhumer wrote:
>
> > You seem to be expecting that the address be aligned "before the return 
> > address push", which is a totally different thing. Quite frankly, I don't 
> > know which one gcc prefers or whether there's an ABI specifying any 
> > preferences.
> 
> I'm pretty sure that on both amd64 and i386 the alignment has to be 
> _before_ the address push from the call, though I cannot find any exact ABI 
> specs at the moment. Experts please advise.
> 
> What do you get when running this slightly modified version of your test 
> program? My patch would fix the alignment of Aligned16 here.

Your test program does seems to imply that gcc wants the alignment before
the return address (ie it prints out an address that is 4 bytes offset),
but on the other hand I'm not even sure how careful gcc is about this
alignment thing at all.

In the "main()" function, gcc will actually generate a "andl $-16,%esp" to 
force the alignment, but ot in the handler function. Just a gcc special 
case? Random luck?

Andi - you know the gcc people, is there some documented rules somewhere? 
How does gcc itself try to align the stack when it generates the calls?

		Linus
