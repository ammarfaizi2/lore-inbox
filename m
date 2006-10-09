Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWJIHAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWJIHAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWJIHAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:00:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44739 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751687AbWJIHAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:00:31 -0400
Date: Mon, 9 Oct 2006 08:53:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] lockdep-design.txt
Message-ID: <20061009065308.GA5577@elte.hu>
References: <cc723f590610050859l11cdf15cmbfad829872d086e4@mail.gmail.com> <cc723f590610060244x45d482b3v9a645bc1406ae21a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc723f590610060244x45d482b3v9a645bc1406ae21a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
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


* Aneesh Kumar <aneesh.kumar@gmail.com> wrote:

> I was looking at lockdep-desing.txt and i guess i am confused with the 
> changes with respect to fd7bcea35e7efb108c34ee2b3840942a3749cadb. It 
> says
> 
> +   '.'  acquired while irqs enabled
> +   '+'  acquired in irq context
> +   '-'  acquired in process context with irqs disabled
> +   '?'  read-acquired both with irqs enabled and in irq context
> +
> 
> 
> But the get_usage_chars() function does this for '-'
> if (class->usage_mask & LOCKF_ENABLED_HARDIRQS)
>                        *c1 = '-';
> 
> 
> 
> So i guess what would be correct would be
> '.'  acquired while irqs disabled
> '+'  acquired in irq context
> '-'  acquired with irqs enabled
> '?' read acquired in irq context with irqs enabled.
> 
> Is this correct ?

indeed, that's correct.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
