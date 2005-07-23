Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVGWRmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVGWRmP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVGWRmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:42:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262375AbVGWRmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:42:13 -0400
Date: Sat, 23 Jul 2005 10:38:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
In-Reply-To: <200507230313_MC3-1-A554-6927@compuserve.com>
Message-ID: <Pine.LNX.4.58.0507231033370.6074@g5.osdl.org>
References: <200507230313_MC3-1-A554-6927@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Jul 2005, Chuck Ebbert wrote:
> 
> This patch (may not apply cleanly to unpatched -rc3) drops overhead
> a few more percent:

That really is pretty ugly.

I'd rather hope for something like function-sections to just make games 
like this be unnecessary. The linker really should be able to do things 
like this for us (ie if it sees that the only reference to a function is 
from another function, it should be able to just put them next to each 
other anyway).

And yes, I realize that "should be able" isn't the same thing as "does", 
but the thing is, doing it by hand ends up being a maintenance problem in 
the long run. It also misses all the other cases where it might be 
beneficial, but where you don't happen to run the right benchmark or look 
at the right place.

So maybe a few hints to the binutils people might just make them go: "try 
this patch/cmdline flag", and solve many more problems. They likely have a 
lot of this kind of code _already_, or have at least been thinking about 
it.

I personally believe that there's likely a lot more to be had from code 
(and data) layout than there is from things like alias analysis or 
aggressive inlining.

		Linus
