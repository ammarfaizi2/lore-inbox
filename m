Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVAKCgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVAKCgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVAKCfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:35:54 -0500
Received: from waste.org ([216.27.176.166]:21183 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262600AbVAJVUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:20:55 -0500
Date: Mon, 10 Jan 2005 13:20:19 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050110212019.GG2995@waste.org>
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzvkxxck.fsf@sulphur.joq.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 12:12:59AM -0600, Jack O'Quin wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> > * Christoph Hellwig (hch@infradead.org) wrote:
> >> So to make forward progress I'd like the audio people to confirm whether
> >> the mlock bits in 2.6.9+ do help that half of their requirement first
> >
> > It sure should, but I guess they can reply on that.
> 
> That does seem to work now (finally).  It looks like that longstanding
> CAP_IPC_LOCK bug is finally fixed, too.
> 
> I find it hard to understand why some of you think PAM is an adequate
> solution.

The best we can do _here_ is present something that userspace can use
sensibly. We can't make userspace actually use it that way though. 

Rlimits are neither UID/GID or PAM-specific. They fit well within
the general model of UNIX security, extending an existing mechanism
rather than adding a completely new one. That PAM happens to be the
way rlimits are usually administered may be unfortunate, yes, but it
doesn't mean that rlimits is the wrong way.

> Running `nice --20' is still significantly worse than SCHED_FIFO, but
> not the unmitigated disaster shown in the middle column.  But, this
> improved performance is still not adequate for audio work.  The worst
> delay was absurdly long (~1/2 sec).

Let's work on that. It'd be _far_ better to have unprivileged near-RT
capability everywhere without potential scheduling DoS.

-- 
Mathematics is the supreme nostalgia of our time.
