Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWEIQNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWEIQNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWEIQNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:13:20 -0400
Received: from fmr17.intel.com ([134.134.136.16]:43224 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751067AbWEIQNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:13:20 -0400
Message-ID: <4460BF8C.1050803@linux.intel.com>
Date: Tue, 09 May 2006 18:13:00 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as unused-for-removal-soon
References: <1146581587.32045.41.camel@laptopd505.fenrus.org> <20060509090202.2f209f32.akpm@osdl.org>
In-Reply-To: <20060509090202.2f209f32.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> So hum.  Don't you think it'd be better to look at each API as a whole,
> make decisions about what parts of it _should_ be offered to modules,
> rather then looking empirically at which parts presently _need_ to be
> exported?

Well so far we as kernel developers have been rather bad at it, with the result
that there are 900 unused ones roughly. Each export takes somewhere between 100
and 150 bytes. *WITHOUT ANY BENEFIT*. The reason to remove them all is to save
that memory NOW. It's easy to add an export back later if it gets used. Yes that
is churn, but it's minor churn. The price for not doing that is a bigger kernel
for everyone, today, without any positive gain of that space..

(and this size excludes even those functions that aren't used at all, but are
only there to be exported. Adrian has been working on removing the really unused
functions in the kernel, via static marking and then gcc noticing the unusedness,
but once they're exported that breaks down)

So I think personally it's worth biting the bullet. I expect 95% of those 900 to
never ever come back. Those 5% will churn, sure. But, to a large degree, the fact
that there's no user is an indication that the API may well not be right in the
first place, or not in demand.
