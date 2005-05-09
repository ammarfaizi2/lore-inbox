Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVEIJRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVEIJRV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 05:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVEIJPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 05:15:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42680 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261174AbVEIJLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 05:11:53 -0400
Date: Mon, 9 May 2005 11:11:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050509091133.GA25959@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407> <427C6D7D.878935F1@tv-sign.ru> <20050509073043.GA12976@elte.hu> <427F1A99.58BCCB88@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427F1A99.58BCCB88@tv-sign.ru>
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

> > i've uploaded my latest tree to:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> > 
> 
> Ok, I'll try to do it. Do you have any comments/objections to
> "[RFC][PATCH] alternative implementation of Priority Lists", see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111547290706136
> ?

i havent reviewed them closely, but on the face of it the changes seem 
plausible.

What would be nice to achieve are [low-cost] reductions of the size of 
struct rt_mutex (in include/linux/rt_lock.h), upon which all other 
PI-aware locking objects are based. Right now it's 9 words, of which 
struct plist is 5 words. Would be nice to trim this to 8 words - which 
would give a nice round size of 32 bytes on 32-bit.

	Ingo
