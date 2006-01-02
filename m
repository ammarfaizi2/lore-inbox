Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWABU3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWABU3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWABU3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:29:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750724AbWABU3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:29:30 -0500
Date: Mon, 2 Jan 2006 15:28:03 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       mingo@elte.hu, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102202803.GJ22293@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <20060102110341.03636720.akpm@osdl.org> <20060102191720.GI22293@devserv.devel.redhat.com> <Pine.LNX.4.64.0601021130300.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601021130300.3668@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 11:41:24AM -0800, Linus Torvalds wrote:
> > Where does this certainity come from?  gcc-3.x (as well as 2.x) each had
> > its own heuristics which functions should be inlined and which should not.
> > inline keyword has always been a hint.
> 
> NO IT HAS NOT.
> 
> This is total revisionist history by gcc people. It did not use to be a 
> hint. If you asked for inlining, you got it unless there was some 
> technical reason why gcc couldn't inline it (ie recursive inlining, and 
> trampolines and some other issues). End of story. 

One of the "technical reasons" was if the function was bigger than some
threshold.  And in that case I think it is ok to speak about inline keyword
as a hint.  The default inline limit (in rtx count after constant folding,
but not other optimizations) was bigger than in the GCC 3.x era, sure, but
there was a limit and GCC wasn't inlining functions bigger than that limit,
even if they could be simplified due to constant arguments to something
much smaller.

	Jakub
