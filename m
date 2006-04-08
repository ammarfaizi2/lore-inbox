Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWDHUdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWDHUdq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWDHUdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:33:46 -0400
Received: from [212.33.163.172] ([212.33.163.172]:19219 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751403AbWDHUdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:33:45 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Sat, 8 Apr 2006 23:31:56 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200604031459.51542.a1426z@gawab.com> <200604080032.28911.a1426z@gawab.com> <443711EC.7070003@bigpond.net.au>
In-Reply-To: <443711EC.7070003@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604082331.56715.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > Can you try the attached mem-eater passing it the number of kb to be
> > eaten.
> >
> > 	i.e. '# while :; do ./eatm 9999 ; done'
> >
> > This will print the number of bytes eaten and the timing in ms.
> >
> > Adjust the number of kb to be eaten such that the timing will be less
> > than timeslice (120ms by default for spa).  Switch to another vt and
> > start pressing enter.  A console lockup should follow within seconds for
> > all spas except ebs.
>
> This doesn't seem to present a problem (other than the eatme loop being
> hard to kill with control-C) on my system using spa_ws with standard
> settings.  I tried both UP and SMP.  I may be doing something wrong or
> perhaps don't understand what you mean by a console lock up.

Switching from one vt to another receives hardly any response.

This is especially visible in spa_no_frills, and spa_ws recovers from this 
lockup somewhat and starts exhibiting this problem as a choking behavior.

Running '# top d.1 (then shift T)' on another vt shows this choking behavior 
as the proc gets boosted.

> When you say "less than the timeslice" how much smaller do you mean?

This depends on your machine's performance.  On my 400MhzP2 UP 128MB, w/ 
spa_no_frills default settings, looping eatm 9999 takes 63ms per eat and 
causes the rest of the system to be starved.  Raising kb to 19999 takes 
126ms which is greater than the default 120ms timeslice and causes no system 
starvation.

What numbers do you get?

Thanks!

--
Al

