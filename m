Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUCCWqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbUCCWqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:46:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:45244 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261236AbUCCWqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:46:52 -0500
Date: Wed, 3 Mar 2004 14:52:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: David Dillow <dave@thedillows.org>, Bill Davidsen <davidsen@tmr.com>,
       Roland Dreier <roland@topspin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <Pine.LNX.4.58.0403031419280.3000@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0403031442580.3000@ppc970.osdl.org>
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
  <1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it> 
 <1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it> 
 <4045106D.8060902@tmr.com>  <Pine.LNX.4.53.0403021817050.9351@chaos>
 <1078286221.4302.23.camel@ori.thedillows.org> <Pine.LNX.4.53.0403031313270.12900@chaos>
 <Pine.LNX.4.58.0403031419280.3000@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Mar 2004, Linus Torvalds wrote:
> 
> You should clear the "events pending" flag only when you literally remove 
> the event (ie at "read()" time, not at "poll()" time). Because the 
> select() code _will_ call down to the "poll()" functions multiple times if 
> it gets woken up for any bogus reason.

Hmm.. The above is all still true and your poll() implementation is bad,
but looking at your test program, the problematic case really shouldn't
trigger (we should call poll()  multiple times only when it returns zero).

To trigger that bug, you'd have to occasionally call poll() with the
POLLIN bit clear in the incoming events, which your test program doesn't
ever do.

Anyway, you should move the clearing to read(), but there may well be 
something else going on too.

What's the frequency you are programming the thing to send interrupts at?

		Linus
