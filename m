Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUCCXId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUCCXId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:08:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:54473 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261238AbUCCXIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:08:31 -0500
Date: Wed, 3 Mar 2004 15:14:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: David Dillow <dave@thedillows.org>, Bill Davidsen <davidsen@tmr.com>,
       Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <Pine.LNX.4.53.0403031737130.14503@chaos>
Message-ID: <Pine.LNX.4.58.0403031509520.1094@ppc970.osdl.org>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
  <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it> 
 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it> 
 <4045106D.8060902@tmr.com>  <Pine.LNX.4.53.0403021817050.9351@chaos>
 <1078286221.4302.23.camel@ori.thedillows.org> <Pine.LNX.4.53.0403031313270.12900@chaos>
 <Pine.LNX.4.58.0403031419280.3000@ppc970.osdl.org> <Pine.LNX.4.53.0403031737130.14503@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Mar 2004, Richard B. Johnson wrote:
> 
> And YES! If I clear the flag only after it is read. It "fixes" the
> observed problem!

Ok. That solves one problem, but it does seem to point to the fact that 
2.6.x calls down to poll() more than 2.4.x does.

It really _is_ normal to have multiple calls to "poll()" for the same fd 
as a result of a single "poll()" system call, but if we actually get a 
positive hit (ie the ->poll() call returns a bit that we consider to be a 
success by comparing it to what we _wanted_ to see), then we should have 
stopped doing that.

And since your test program always sets "POLLIN", any ->poll() call that 
has the POLLIN flag set should have ended up being the last one (since it 
would have marked a "success"). 

So there's still something I don't understand, and that seems to differ
between 2.4.x and 2.6.x. Can anybody else see it?

		Linus
