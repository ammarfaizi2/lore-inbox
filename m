Return-Path: <linux-kernel-owner+w=401wt.eu-S1753249AbWLWLGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbWLWLGR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 06:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbWLWLGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 06:06:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48929 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbWLWLGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 06:06:16 -0500
Date: Sat, 23 Dec 2006 12:03:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
Message-ID: <20061223110350.GA25279@elte.hu>
References: <20061221124327.GA17190@elte.hu> <458AD71D.2060508@goop.org> <20061221235732.GA32637@elte.hu> <20061222120422.eb28953b.akpm@osdl.org> <1166839610.1573.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166839610.1573.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> WARN_ON is still a BUG, but we know enough about it that we can just 
> cripple the system so that it doesn't break anything. [...]

well - a WARN_ON() can be /anything/. It is the same as BUG_ON(), but it 
doesnt crash the box immediately and on purpose. In that sense all 
existing BUG_ON()s should be converted to WARN_ON()s or to panic()s 
(whichever fits best for that particular BUG_ON()).

[ or all WARN_ON()s should be converted to BUG_ON()s and the behavior of
  BUG_ON() should be changed to /not/ crash the system on purpose - and
  for those cases where we really do not want to continue, panic()
  should be used. That way the user can set panic policy himself. ]

i can whip up a patch for any of these conversions, but i dont think we 
need this flux right now.

	Ingo
