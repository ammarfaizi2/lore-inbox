Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVDANJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVDANJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVDANJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:09:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56527 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262745AbVDANIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 08:08:04 -0500
Date: Fri, 1 Apr 2005 15:07:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] timers fixes/improvements
Message-ID: <20050401130713.GA3802@elte.hu>
References: <424D373F.1BCBF2AC@tv-sign.ru> <424D37B2.2CE24C67@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424D37B2.2CE24C67@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> struct timer_list {
> 	...
> 	timer_base_t *_base;
> };

namespace cleanliness: i'd suggest s/_base/base.

another detail:

> int __mod_timer(struct timer_list *timer, unsigned long expires)
[...]
> 		/* Ensure the timer is serialized. */
> 		if (base != &new_base->t_base
> 			&& base->running_timer == timer)
> 			goto unlock;

> unlock:
> 		spin_unlock_irqrestore(&base->lock, flags);
> 	} while (ret < 0);

so we keep looping in __mod_timer() when the timer is running? Couldnt 
this be a performance hit?

	Ingo
