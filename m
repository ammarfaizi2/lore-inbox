Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWHHVfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWHHVfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWHHVfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:35:13 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:63687 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S965053AbWHHVfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:35:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=lQw3DPrI2leu5PuRquVml+ZWiJ1yLELMQw6s0wSJM2b64tOeXKqY2D0BPv3l8Ce8;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <04a001c6bb32$79a39380$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>, "Jes Sorensen" <jes@sgi.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
References: <f19298770608080407n5788faa8x779ad84fe53726cb@mail.gmail.com><p73y7tzo4hl.fsf@verdi.suse.de><f19298770608080447l3e31465fqb6fbc8cfed71cb80@mail.gmail.com> <yq03bc7v3uy.fsf@jaguar.mkp.net>
Subject: Re: Time to forbid non-subscribers from posting to the list?
Date: Tue, 8 Aug 2006 14:34:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120e26356c0b0470470511693093adbbcdf3f5372688b950fe8350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.182.36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jes Sorensen" <jes@sgi.com>
>>>>>> "Alexey" == Alexey Zaytsev <alexey.zaytsev@gmail.com> writes:

> Just install a proper spam filter like everyone else.

There is a modest problem with that, Jes. What looks like spam in
most emails is often ham for this list, particularly with regards
to bug reports and patches.

With SpamAssasssin I have made an ad-hoc fix that works quite nicely
for the several "open" mailing lists I am on.

The first fix is a generic one I made once I was sure the BAYES
filter was well trained with ham and spam such that it seldom if
ever made a real mistake at the extremes of the score ranges. I
then increased the BAYES_95 rule score slightly. And have been
able to raise BAYES_99 to a full threshold of 5 score without
any false positives. YMMV here. But it does help on personal
installations.

First I developed a "feature" detection scheme for each of the lists.
Not all of them are straight forward for detection. Each list has its
own __L_RULE.... These rules are combined into a __LIST_RELAY meta
rule. Finally I create a series of meta rules that fire if BAYES_XX
and __LIST_RELAY are true. These raise the high BAYES scores and
lower the low BAYES scores.

Today I noticed one single spam out of 263 waiting messages when I
got to this mailing list. It was in a foreign language so I simply
fed it to BAYES to raise it from BAYES_80 to BAYES_99. Since it's
score was already 4.5 "it won't happen again."

I thought I'd pass along this "list amplifier" score trick for
SpamAssassin because it appears some folks here are seriously
troubled by the spam getting through.

(SUSE runs SpamAssassin. Unfortunately their BAYES is horridly mis-
trained. So it misfires left and right. I wish they'd fix that. Quite
often lists require some level of tweaking on the BAYES scores when
processing list messages.)

{^_^}   Joanne
