Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVAGXJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVAGXJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVAGXHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:07:16 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:44457 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261698AbVAGXAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:00:49 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, Chris Wright <chrisw@osdl.org>,
       alan@lxorguk.ukuu.org.uk, joq@io.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050107221059.GA17392@infradead.org>
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	 <1105132348.20278.88.camel@krustophenia.net>
	 <20050107134941.11cecbfc.akpm@osdl.org>
	 <20050107221059.GA17392@infradead.org>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 18:00:40 -0500
Message-Id: <1105138840.20278.107.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 22:10 +0000, Christoph Hellwig wrote:
> It's not nessecarily a bad idea per, but it doesn't
> really fit into the model we've been working to.  I'd expect quite a few
> unpleasant devices when a user detects that the distibution had been
> binding various capabilities to uids/gids behinds his back.
> 

Point taken, but do keep in mind that this will *certainly* be disabled
by default, unless you run an audio oriented distro, and we assume those
people know what they're doing ;-)

> For that one I really wonder whether the combination of the now actually
> working nicelevels (see Mingo's post)

Ingo said "it should work".  It currently doesn't, as you can see from
Jack's post.  My concern here is, the semantics of SCHED_FIFO are well
defined and stable.  The highest priority runnable SCHED_FIFO process
*always* runs.  The semantics of "nice -20" apparently change from
release to release, as you can see.  We can't have the scheduler
deciding to run something else when jackd needs to run because it
decides jackd is hogging the CPU or whatever.  Everyone knows that when
dealing with realtime constraints the important case is not the average
but the worst.

In a live audio situation an xrun storm and a complete system lockup are
both catastrophic failures.

Lee

