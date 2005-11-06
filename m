Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVKFXCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVKFXCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVKFXCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:02:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35050 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751233AbVKFXCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:02:07 -0500
Date: Sun, 6 Nov 2005 15:02:02 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       mingo@elte.hu, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Additional/catchup RCU signal fixes for -mm
Message-ID: <20051106230202.GD22876@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1086.EE67F433@tv-sign.ru> <436E1731.16CFAE41@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436E1731.16CFAE41@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 05:46:09PM +0300, Oleg Nesterov wrote:
> Oleg Nesterov wrote:
> > 
> > "Paul E. McKenney" wrote:
> > >
> > > +       if (p->sighand == NULL) {
> > > +               ret = 1;
> > 
> > Oh, I think there is another problem here. I'll post a separate
> > message.
> 
> Sorry, I was not clear. This problem is unrelated. Yes, I think we
> should drop the signal. But please note that ret = 1 (sig_ignored)
> means (surprise!) "reschedule and re-arm this timer right now" in
> cpu-timer case. It is not critical, but may be ret = 0 is better.

OK.  Seems like the next firing of the timer would then see the
changed situation, so the current code should at least be safe.

Thoughts?

						Thanx, Paul
