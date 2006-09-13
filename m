Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWIMKIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWIMKIY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 06:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWIMKIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 06:08:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37564 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751417AbWIMKIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 06:08:23 -0400
Date: Wed, 13 Sep 2006 11:59:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
Message-ID: <20060913095942.GA10075@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45075829.701@goop.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> [...]  The basic inner loop is:
> 
> 	push %segreg
> 	mov  %selectorreg, %segreg
> 	add  $1,%segreg:offset	# use the segment register
> 	pop  %segreg

well, the most important thing i believe you didnt test: the effect of 
mixing two descriptors on the _same_ selector: one %gs selector value 
loaded and used by glibc, and another %gs selector value loaded and used 
by the kernel, intermixed. It's the mixing that causes the descriptor 
cache reload. (unless i missed some detail about your testcase)

	Ingo
