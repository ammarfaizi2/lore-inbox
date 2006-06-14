Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWFNS0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWFNS0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 14:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWFNS0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 14:26:16 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17128 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750806AbWFNS0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 14:26:15 -0400
Date: Wed, 14 Jun 2006 20:25:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 7/8] lock validator: s390 use raw_spinlock in mcck handler
Message-ID: <20060614182516.GB31243@elte.hu>
References: <20060614142318.GH1241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614142318.GH1241@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5164]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Machine checks on s390 are always enabled (except in the machine check 
> handler itself). Therefore use a raw_spinlock in the machine check 
> handler to avoid deadlocks in the lock validator.

hm, couldnt you use the ->lockdep_recursion mechanism to take care of 
such cases? Just call lockdep_off() when entering a machine exception 
handler, and lockdep_on() when exiting it.

	Ingo
