Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVBBLh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVBBLh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 06:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVBBLh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 06:37:57 -0500
Received: from mx1.elte.hu ([157.181.1.137]:59570 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262254AbVBBLhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 06:37:45 -0500
Date: Wed, 2 Feb 2005 12:37:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050202113705.GA25012@elte.hu>
References: <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bwfo8br.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> Remember when I asked how you handle changes to sizeof(struct rusage)?
> That was a serious question.  I hope there's a solution. [...]

what does any of what we've talking about have to do with struct rusage? 

One of the patches i wrote adds a new rlimit. It has no impact on
rusage, at all. A new rlimit can be added transparently, we routinely
add new rlimits, and no, most of them have no matching rusage fields!

> But, I got no answer, only handwaving.

i very much replied to your point:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=110672338910363&w=2

" > Does getrusage() return anything for this?  How can a field be added
  > to the rusage struct without breaking binary compatibility?  Can we
  > assume that no programs ever use sizeof(struct rusage)?

  rlimits are easily extended and there are no binary compatibility
  worries. The kernel doesnt export the maximum towards userspace.
  getrusage() will return the value on new kernels and will return 
  -EINVAL on old kernels, so new userspace can deal with this 
  accordingly. "

(and here i meant getrlimit(), not getrusage() - getrusage() is not
affected by the patch at all.)

	Ingo
