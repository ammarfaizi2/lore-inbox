Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVA0TtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVA0TtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVA0TtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:49:08 -0500
Received: from canuck.infradead.org ([205.233.218.70]:782 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262711AbVA0Tsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:48:53 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0501271121020.2362@ppc970.osdl.org>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net>
	 <1106848051.5624.110.camel@laptopd505.fenrus.org>
	 <41F92D2B.4090302@comcast.net>
	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
	 <41F937C0.4050803@comcast.net>
	 <Pine.LNX.4.58.0501271121020.2362@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 20:48:46 +0100
Message-Id: <1106855326.5624.123.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The fact is, different people have different needs. YOU only need to care
> about yourself. That's not true for a vendor. A single case that doesn't
> work ends up either (a) being ignored or (b) costing them money. See the 
> problem? They can't win. Except by taking small steps, where the breakage 
> is hopefully small too - and more importantly, because it's spread out 
> over time, you hopefully know what broke it.
> 
> And when I say RH, I mean "me". That's the reason I personally hate
> merging "D-day" things where a lot of things change. I much prefer merging
> individual changes in small pieces. When things go wrong - and they will -
> you can look at the individual pieces and say "ok, it's definitely not
> that one" or "Hmm.. unlikely, but let's ask the reporter to check that
> thing anyway" or "ok, that looks suspicious, let's start from there".

this is exactly why the patch series I sent started with 64Kb. In fedora
we use 2Mb actually, and I know of some cornercases where that gives
issues (and the solution is a bit tricky). 64Kb is a nice safe start,
and it means the implementation can be quite simple. Later on, once this
patch has been proven solid and not to break stuff, adding a patch to
bring it up to 2Mb or so (I don't think more makes much sense, but I'm
open to debates about the ideal size for this, it's a tunable) that
needs to deal with stack rlimits < 2Mb and such can be done as a
separate step. Which then will in itself be quite simple again.


