Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVKFNcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVKFNcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 08:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVKFNcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 08:32:16 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:35237 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750830AbVKFNcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 08:32:15 -0500
Message-ID: <436E1731.16CFAE41@tv-sign.ru>
Date: Sun, 06 Nov 2005 17:46:09 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, mingo@elte.hu, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Additional/catchup RCU signal fixes for -mm
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1086.EE67F433@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> "Paul E. McKenney" wrote:
> >
> > +       if (p->sighand == NULL) {
> > +               ret = 1;
> 
> Oh, I think there is another problem here. I'll post a separate
> message.

Sorry, I was not clear. This problem is unrelated. Yes, I think we
should drop the signal. But please note that ret = 1 (sig_ignored)
means (surprise!) "reschedule and re-arm this timer right now" in
cpu-timer case. It is not critical, but may be ret = 0 is better.

Oleg.
