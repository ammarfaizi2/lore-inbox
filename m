Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVEWHyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVEWHyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 03:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVEWHyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 03:54:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34181 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261861AbVEWHyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 03:54:01 -0400
Date: Mon, 23 May 2005 09:53:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dwalker@mvista.com,
       Linus Torvalds <torvalds@osdl.org>, kus Kusche Klaus <kus@keba.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01 when RT program dumps core]
Message-ID: <20050523075336.GA9287@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at> <1116503763.15866.9.camel@localhost.localdomain> <1116509820.15866.28.camel@localhost.localdomain> <1116523552.14229.64.camel@dhcp153.mvista.com> <1116524583.21388.299.camel@localhost.localdomain> <1116525953.4097.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116525953.4097.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 2005-05-19 at 18:43 +0100, Alan Cox wrote:
> > On Iau, 2005-05-19 at 18:25, Daniel Walker wrote:
> > > I've seen a RT yield warning on this yield while running the FUSYN
> > > tests .. I can't imagine why it's there either.
> > 
> > Would it not make more sense to kick a task out of hard real time at the
> > point it begins dumping core. The core dumping sequence was never
> > something that thread intended to execute at real time priority
> > 
> 
> That's what I recommended in an earlier email.  I figured I'd wait to 
> see Ingo's response before sending him any patches.  The drop from RT 
> should probably be after the zap_threads, that way it can kill those 
> using the same mm right away.  Which also goes to say, we should get 
> rid of that yield.

i think the yield() is bogus - all of coredumping is (or ought to be) 
fully event-driven. I agree that coredumping itself does not need to run 
with RT priorities - but this does not change the fact that no kernel 
code should break if executing with RT priority.

In my tree i removed one yield() from exec.c and changed the other one 
to msleep(1).

	Ingo
