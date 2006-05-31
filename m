Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWEaWce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWEaWce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWEaWce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:32:34 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61403 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965213AbWEaWce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:32:34 -0400
Date: Thu, 1 Jun 2006 00:32:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@google.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531223243.GC5269@elte.hu>
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org> <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447E16E6.7020804@google.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5020]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin Bligh <mbligh@google.com> wrote:

> >>OK. So what's the perf impact of the new version on a 32 cpu machine? 
> >>;-) Maybe it's fine, maybe it's not.
> >
> >
> >no idea, but it shouldnt be nearly as bad as say SLAB_DEBUG.
> 
> The "no idea" is hardly reassuring ;-)
> The latter point is definitely valid though, it's not an isolated issue.

> Adding new runs is easy. Changing the harness is hard ;-)

ok. How about a CONFIG_DEBUG_NO_OVERHEAD option, that would default to 
disabled but which you could set to y. Then we could make all the more 
expensive debug options:

	default y if !CONFIG_DEBUG_NO_OVERHEAD

this would still mean you'd have to turn off CONFIG_DEBUG_NO_OVERHEAD, 
but it would be automatically maintainable for you after that initial 
effort, and we'd be careful to always flag new debugging options with 
this flag, if they are expensive. And initially i'd define "expensive" 
as "anything that adds runtime overhead".

would this be acceptable to you?

	Ingo
