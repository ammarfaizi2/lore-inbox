Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVAHJos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVAHJos (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVAHJg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:36:26 -0500
Received: from mail.joq.us ([67.65.12.105]:14209 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261946AbVAHGVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 01:21:01 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Takashi Iwai <tiwai@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050107153328.GD28466@devserv.devel.redhat.com>
	<200501071541.j07FfeQC018553@localhost.localdomain>
	<20050107160350.GB29327@devserv.devel.redhat.com>
	<s5hbrc1w6rq.wl@alsa2.suse.de> <41DF7179.20401@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 08 Jan 2005 00:21:57 -0600
In-Reply-To: <41DF7179.20401@kolivas.org> (Con Kolivas's message of "Sat, 08
 Jan 2005 16:36:57 +1100")
Message-ID: <876528xwxm.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Takashi Iwai wrote:
>> At Fri, 7 Jan 2005 17:03:51 +0100,
>> Arjan van de Ven wrote:
>>>something like a soft realtime flag that acts as if it's the hard realtime
>>>one unless the app shows "misbehavior" (eg eats its timeslice for X times in
>>>a row) might for example be such a solution. And with the anti abuse
>>>protection it can run with far lighter privilegs.

>> This reminds me about the soft-RT patch posted quite sometime ago.
>> I feel such a handy psuedo-RT scheduler class would be useful for
>> other systems than JACK, too...
>
> You've already proven that soft RT does not suit your
> requirements. The current scheduler running a task at nice -20 has
> extremely long periods of cpu availability at the expense of lower
> priority tasks and is close to the behaviour you would get with a soft
> RT patch. Your concern is exactly the scenario where nice -20 fails,
> and would be the same scenario where a soft RT policy would
> fail. Doing this with a scheduling policy, you want cpu time long
> after there is any hope for fairness or safety of hanging. From
> experimentation with such soft RT policies, we find average latencies
> can be reduced but the maximum ones, which are the ones that concern
> professional audio, remain the same.

Yes, this is exactly right.  The corrected test results I just posted
support your contention.  

For realtime, most of the OS tricks we all know and love are
counter-productive.  It's the worst case that matters, not the
average.
-- 
  joq
