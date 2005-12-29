Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVL2SpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVL2SpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 13:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVL2SpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 13:45:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750831AbVL2SpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 13:45:23 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mpm@selenic.com
In-Reply-To: <1135881735.2935.66.camel@laptopd505.fenrus.org>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <1135881735.2935.66.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 19:45:19 +0100
Message-Id: <1135881920.2935.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 19:42 +0100, Arjan van de Ven wrote:
> > 
> > One thing we could do: I think modern gcc's at least have an option to 
> > warn when they don't inline something. It might make sense to just enable 
> > that warning, and see _which_ functions -Os and -funit-at-a-time say are 
> > too large to be inlined.
> 
> 
> with -Os gcc gets a bit picky and warns a LOT; with -O2... you get the
> following fixes (all huge functions)
> 


btw this caught one bug that the forced attribute was hiding: there was
a function which was "inline" and which uses a variable sized array.
normally gcc refuses to inline that (rightfully; esp relative addressing
gets rather really complex in that scenario), but the force attribute
causes it to be inlined anyway. No idea if the result is sane in that
case...


