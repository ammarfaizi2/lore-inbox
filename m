Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbVKYNzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbVKYNzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVKYNzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:55:35 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:16071 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932691AbVKYNze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:55:34 -0500
Date: Fri, 25 Nov 2005 14:55:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Schultheiss, Christoph" <Christoph.Schultheiss@eurocopter.com>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: duration of udelay differs with activated realtime-preempt patch?
Message-ID: <20051125135533.GA12823@elte.hu>
References: <B7DA45CF87D412408436D5ECAAB9B90F6E7A06@sma2906.cr.eurocopter.corp> <1132925285.6694.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132925285.6694.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > after measuring the duration of the function udelay (with oscilloscope
> > at parallel port), I figured out that udelay (5usec) with activated
> > realtime- preempt patch lasts a little bit longer. Without the patch the
> > time is exact.
> > All kernel debug switches are turned off at compile time.
> > Can anyone suggest why this happens?
> 
> Well, the -rt patch, has changed the udelay function.  BTW, you are 
> using the constant udelay, right?  Maybe an example of the code you 
> used to test might be useful.
> 
> Ingo or John?

yes, i found this problem too, a week ago or so. It's due to the GTOD 
changes to i386's __delay() function. Does it still occur with -rt15 
[which has the -B11 GTOD patchset] ?

	Ingo
