Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWIFIsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWIFIsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWIFIsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:48:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23983 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750701AbWIFIsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:48:40 -0400
Date: Wed, 6 Sep 2006 10:40:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Hua Zhong <hzhong@gmail.com>
Cc: "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Daniel Walker'" <dwalker@mvista.com>
Subject: Re: lockdep oddity
Message-ID: <20060906084021.GA30856@elte.hu>
References: <20060906080129.GD6898@osiris.boeblingen.de.ibm.com> <004901c6d18d$acc45620$0200a8c0@nuitysystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004901c6d18d$acc45620$0200a8c0@nuitysystems.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4932]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hua Zhong <hzhong@gmail.com> wrote:

> We are just trading accuracy for speed here.

no, we are trading _both_ accuracy and speed here! a global 'likeliness' 
pointer for commonly executed codepaths is causing global cacheline 
ping-pongs - which is as bad as it gets.

the right approach, which incidentally would also be perfectly accurate, 
is to store an alloc_percpu()-ed pointer at the call site, not the 
counter itself.

the current code needs more work before it can go upstream i think.

	Ingo
