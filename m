Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267436AbUHPFBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUHPFBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267437AbUHPFBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:01:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62400 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267436AbUHPFB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:01:29 -0400
Date: Mon, 16 Aug 2004 07:02:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
Message-ID: <20040816050248.GA16522@elte.hu>
References: <1092624221.867.118.camel@krustophenia.net> <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092630122.810.25.camel@krustophenia.net> <20040816043302.GA14979@elte.hu> <1092632236.801.1.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092632236.801.1.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > +	touch_preempt_timing();
> >         while ((readb(ioaddr + MIICmd) & 0x40) && --boguscnt > 0)
> >                 ;
> > +	touch_preempt_timing();
> > 
> > assuming that the latencies still show up even if delimited like this. 
> > (note that this only changes the way the latency is tracked - the
> > latency itself is still there so this isnt a fix.)
> > 
> 
> Sure, but, what would this accomplish, if the latency is still there? 
> Are we just trying to track down exactly where in the network driver
> this is triggered?

yeah. If it's the first chunk then we could perhaps avoid it by doing it
outside of the lock.

	Ingo
