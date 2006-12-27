Return-Path: <linux-kernel-owner+w=401wt.eu-S1750866AbWL0Q6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWL0Q6G (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 11:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbWL0Q6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 11:58:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53515 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbWL0Q6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 11:58:05 -0500
Date: Wed, 27 Dec 2006 17:55:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Message-ID: <20061227165500.GB10077@elte.hu>
References: <20061227153855.GA25898@in.ibm.com> <20061227162530.GA23000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227162530.GA23000@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> The real question here is which interface we want people to use for 
> these "combined" applications.  Evgeny is heavily pushing kevent for 
> this while other seem to prefer integration epoll into the aio 
> interface. (1)
> 
> I must admit that kevent seems to be the cleaner way to support this, 
> although I see some advantages for the aio variant.  I do think 
> however that we should not actively promote two differnt interfaces 
> long term.

i see no fundamental disadvantage from doing both. That way the 'market' 
of applications will vote. (we have 2 other fundamental types available 
as well: sync IO and poll() based IO - so it's not like we have the 
choice between 2 or 1 variant, we have the choice between 4 or 3 
variants)

> (1) note that there is another problem with the current kevent
>     interface, and that is that it duplicates the event infrastructure 
>     for it's underlying subsystems instead of reusing existing code 
>     (e.g. inotify, epoll, dio-aio).  If we want kevent to be _the_ 
>     unified event system for Linux we need people to help out with 
>     straightening out these even provides as Evgeny seems to be 
>     unwilling/unable to do the work himself and the duplication is 
>     simply not acceptable.

yeah. The internal machinery should be as unified as possible - but 
different sets of APIs can be offered, to make it easy for people to 
extend their existing apps in the most straightforward way.

(In fact i'd like to see all the 'poll table' code to be unified into 
this as well, if possible - it does not really "poll" anything, it's an 
event infrastructure as well, used via the naive select() and poll() 
syscalls. We should fix that naming mistake.)

	Ingo
