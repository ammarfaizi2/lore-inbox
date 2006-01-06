Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWAFBso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWAFBso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWAFBso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:48:44 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:24006 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1750968AbWAFBsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:48:43 -0500
Date: Thu, 5 Jan 2006 17:48:41 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060106014841.GE84622@gaz.sfgoth.com>
References: <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060105233049.GA3441@elte.hu> <43BDB381.6020701@mbligh.org> <20060106004050.GA18727@elte.hu> <43BDBFE5.5020405@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BDBFE5.5020405@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 05 Jan 2006 17:48:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> But we were just discussing here ... wouldn't it be worth moving 
> "unlikely" sections of code completely out of line? If they were calls 
> to separate functions, all this optimisation stuff could just work at a 
> function level, and would be pretty trivial to do?

...assuming that they don't need to access many local variables.   And don't
have any "goto" statements... and... etc, etc.

> we'd have
> 
> if (unlikely(conditon)) {
> 	call_oh_shit();
> }
> 
> __rarely_called void call_oh_shit()
> {
> 	do;
> 	some;
> 	stuff;
> 	BUG();
> 	error();
> 	oh_dear();
> }

As I described in my other mail on this thread, the _ideal_ solution would
be to tell the compiler that BUG() is a __rarely_called function (well, it's
a macro now but it could be made into an inline function) and let the
compiler figure the rest out without further annotation

> Moving that out of line would seem 
> to make more difference to icache footprint to me than just cacheline 
> packing functions.

Assuming "-funit-at-a-time" (which all archs will probably be using soon)
you'd probably get exactly the same opcodes either way.

-Mitch
