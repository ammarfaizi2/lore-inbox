Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVAKOaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVAKOaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVAKOaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:30:25 -0500
Received: from mail.joq.us ([67.65.12.105]:27296 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262772AbVAKOaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:30:11 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
	<20050107134941.11cecbfc.akpm@osdl.org>
	<20050107221059.GA17392@infradead.org>
	<20050107142920.K2357@build.pdx.osdl.net>
	<87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 11 Jan 2005 08:30:50 -0600
In-Reply-To: <20050110212019.GG2995@waste.org> (Matt Mackall's message of
 "Mon, 10 Jan 2005 13:20:19 -0800")
Message-ID: <87d5wc9gx1.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jan 08, 2005 at 12:12:59AM -0600, Jack O'Quin wrote:
>> I find it hard to understand why some of you think PAM is an adequate
>> solution.

Matt Mackall <mpm@selenic.com> writes:
> The best we can do _here_ is present something that userspace can use
> sensibly. We can't make userspace actually use it that way though. 

"O'Quin's law" states that "every system reflects the structure of the
organization creating it".  (Probably not original, I "discovered"
this about 25 years ago, while doing OS development at IBM.)  Compared
to most other operating systems, GNU/Linux has a much larger
organizational gap between kernel development and the rest of the OS.
Like anything else, this is both a strength and a weakness.

> Rlimits are neither UID/GID or PAM-specific. They fit well within
> the general model of UNIX security, extending an existing mechanism
> rather than adding a completely new one. That PAM happens to be the
> way rlimits are usually administered may be unfortunate, yes, but it
> doesn't mean that rlimits is the wrong way.

This whole RLIMITS_MEMLOCK situation with PAM is a good example of how
that disconnect causes systemic troubles.  AFAICT, fixing the
longstanding bug in mlock() introduced a Denial of Service bug in
Debian (and perhaps other distributions) when running 2.6.10.

Clearly, this is not a kernel bug.  In fact, the kernel was broken
before.  But, it is an excellent example of how depending on a
Byzantine mechanism like PAM *harms* system security.  The Debian
developers are very careful about things like this.  If they can't get
the default install right, something is badly amiss, damaging
complexity in the overall system.  The kernel is not solely
responsible for that, but ignoring its contribution would be a
mistake.

>> Running `nice --20' is still significantly worse than SCHED_FIFO, but
>> not the unmitigated disaster shown in the middle column.  But, this
>> improved performance is still not adequate for audio work.  The worst
>> delay was absurdly long (~1/2 sec).
>
> Let's work on that. It'd be _far_ better to have unprivileged near-RT
> capability everywhere without potential scheduling DoS.

"Near-RT" is about the most useless concept I've heard of in a long
time.  It sounds like the answer to a question nobody asked.  ;-)

Linux can and should develop a better unprivileged realtime scheduling
algorithm.  But, this is not an "escape hatch" to avoid confronting
mainline 2.6 security problems.  We still have 2005 problems to solve.
-- 
  joq
