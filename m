Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVAOXiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVAOXiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVAOXhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:37:40 -0500
Received: from mail.joq.us ([67.65.12.105]:57218 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262363AbVAOXh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:37:26 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050110212019.GG2995@waste.org>
	<200501111305.j0BD58U2000483@localhost.localdomain>
	<20050111191701.GT2940@waste.org>
	<20050111125008.K10567@build.pdx.osdl.net>
	<20050111205809.GB21308@elte.hu>
	<20050111131400.L10567@build.pdx.osdl.net>
	<20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>
	<20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 15 Jan 2005 17:38:11 -0600
In-Reply-To: <874qhiwb1q.fsf@sulphur.joq.us> (Jack O'Quin's message of "Sat,
 15 Jan 2005 17:02:41 -0600")
Message-ID: <871xcmuuu4.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> * Jack O'Quin <joq@io.com> wrote:
>>> One major problem: this `nice --20' hack affects every thread, not
>>> just the critical realtime ones.  That's not what we want.  Audio
>>> applications make very conscious choices which threads run with high
>>> priority and which do not.

> Ingo Molnar <mingo@elte.hu> writes:
>> how much did this problem affect your test? Could the source of the 500
>> msec delays be the non-highprio components of the test that somehow
>> became nice --20?

Jack O'Quin <joq@io.com> writes:
> Probably, the best way to tell would be patching JACK so it uses
> nice(-20) instead of pthread_setschedparam() for the realtime threads.
> As a hack, that looks easy.  I'll build a working directory with just
> that change, so we can experiment with it better.

Bah!  Nothing is ever as easy as it looks.

According to the manpage, nice(2) is per-process not per-thread.  That
does not give the granularity we need.  

Is that correct?  If so, I can't think of any way to make this work.
Suggestions?

We need to allow both realtime and non-realtime threads in the same
process.  Anything less would require an enormous rewrite for most
audio programs, an unreasonable thing to ask.
-- 
  joq
