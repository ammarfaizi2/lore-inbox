Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWJRHgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWJRHgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWJRHgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:36:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33158 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751296AbWJRHgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:36:49 -0400
Date: Wed, 18 Oct 2006 09:28:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
       mgreer@mvista.com, sshtylyov@ru.mvista.com
Subject: Re: [PATCH -rt] powerpc update
Message-ID: <20061018072858.GA29576@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003155358.756788000@dwalker1.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> Pay close attention to the fasteoi interrupt threading. I added usage 
> of mask/unmask instead of using level handling, which worked well on 
> PPC.

this is wrong - it should be doing mask+ack.

also note that you changed:

> -		goto out_unlock;

to:

> +		goto out;

and you even tried to hide your tracks:

>  out:
>  	desc->chip->eoi(irq);
> -out_unlock:
>  	spin_unlock(&desc->lock);

:-)

really, the ->eoi() op should only be called for true fasteoi cases. 
What we want here is to turn the fasteoi handler into a handler that 
does mask+ack and then unmask. Not 'mask+eoi ... unmask' as your patch 
does.

	Ingo
