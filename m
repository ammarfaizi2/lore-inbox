Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965563AbWKDRar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965563AbWKDRar (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 12:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965564AbWKDRar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 12:30:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53435 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965563AbWKDRaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 12:30:46 -0500
Date: Sat, 4 Nov 2006 18:29:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Falk Hueffner <falk@debian.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: ipc/msg.c "cleanup" breaks fakeroot on Alpha
Message-ID: <20061104172954.GA3668@elte.hu>
References: <87d583f97t.fsf@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d583f97t.fsf@debian.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Falk Hueffner <falk@debian.org> wrote:

> -	struct msg_msg* volatile r_msg;
> +	volatile struct msg_msg	*r_msg;
>  };
>  
> breaks fakeroot on Alpha (variously hangs or oopses). Backing it out 
> of 2.6.19-rc4 fixes the issue. Is it possible that this change (which 
> clearly does change semantics) was made in error?

correct, it was an error, lets back it out.

Another interesting question is: what in the IPC code relies on the 
volatility of this field, and shouldnt it be converted to explicit 
barriers instead?

	Ingo
