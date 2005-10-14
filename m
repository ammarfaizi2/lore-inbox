Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVJNEEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVJNEEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVJNEEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:04:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33673 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751156AbVJNEEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:04:15 -0400
Date: Fri, 14 Oct 2005 06:04:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: george@mvista.com, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       dwalker@mvista.com, david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051014040432.GA9073@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129064151.5324.6.camel@cmn3.stanford.edu> <20051012061455.GA16586@elte.hu> <Pine.LNX.4.58.0510120230001.5830@localhost.localdomain> <434D8973.8000706@mvista.com> <1129160470.4633.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129160470.4633.6.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > Or maybe:
> > 'time sleep 10'
> > 
> > Lets the machine time it.
> 
> My first thought was "this can't work" as I imagined the same timing 
> services would be used and you would get always 10 secs or so...

yeah, was my initial thought too. If you have an ssh login on any other 
local box (and have ssh autologin enabled), then there's a good way to 
script this:

	time ssh otherbox "time ssh thisbox \"sleep 10\""

this way you'll get two time measurements of the same timeout, one on 
the other box (which shouldnt be running the buggy kernel :-), one on 
this box, while the timer runs on this box. Here it gives:

earth3:~> time ssh pluto "time ssh earth3 \"sleep 10\""

real    0m10.141s
user    0m0.012s
sys     0m0.008s

real    0m10.278s
user    0m0.024s
sys     0m0.004s

	Ingo
