Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVAOXCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVAOXCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVAOXCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:02:24 -0500
Received: from mail.joq.us ([67.65.12.105]:43906 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262354AbVAOXCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:02:20 -0500
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
	<20050115134922.GA10114@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 15 Jan 2005 17:02:41 -0600
In-Reply-To: <20050115134922.GA10114@elte.hu> (Ingo Molnar's message of
 "Sat, 15 Jan 2005 14:49:22 +0100")
Message-ID: <874qhiwb1q.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Jack O'Quin <joq@io.com> wrote:
>
>> OK, I reran with just 5 processes reniced from -10 to -5.  On my
>> system they were: events, khelper, kblockd, aio and reiserfs.  In
>> addition, I reniced loop0 from -20 to -5.
>
>> One major problem: this `nice --20' hack affects every thread, not
>> just the critical realtime ones.  That's not what we want.  Audio
>> applications make very conscious choices which threads run with high
>> priority and which do not.
>
> how much did this problem affect your test? Could the source of the 500
> msec delays be the non-highprio components of the test that somehow
> became nice --20?

Some interference is definitely possible.  But, the test does not
involve any graphical interface, so I'd expect that to be small.
Looking at jack_test3_client.cpp, the main thread just does a sleep()
while the process cycle is running.

Still, it's hard to be sure.  

Probably, the best way to tell would be patching JACK so it uses
nice(-20) instead of pthread_setschedparam() for the realtime threads.
As a hack, that looks easy.  I'll build a working directory with just
that change, so we can experiment with it better.
-- 
  joq
