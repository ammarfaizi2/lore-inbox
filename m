Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVFANNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVFANNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFANNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:13:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31666 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261298AbVFANMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:12:20 -0400
Date: Wed, 1 Jun 2005 15:11:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050601131130.GC32232@elte.hu>
References: <20050601092102.GB13041@elte.hu> <Pine.LNX.4.10.10506010559050.23911-100000@godzilla.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10506010559050.23911-100000@godzilla.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> > > > existing_sp_head:
> > > > 	itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
> > > > 	list_add(&pl->sp_node, &itr_pl2->sp_node);
> > > 
> > > This breaks fifo ordering.
> > 
> > Daniel, is the issue (and other issues) Oleg noticed still present? I'm 
> > still a bit uneasy about the complexity of the plist changes.
> 
> I think this one isn't right. We could make a test quite to check
> correctness. Find the errors before they find us. Oleg may even have
> something like that already half done. 
> 
> Are you concerned with plist as a whole, or just my recent changes?
> 
> There is still a problem with plist_for_each() missing the first list 
> member, which I need to fix.

plist seems pretty stable now, but i'm still worried about behavioral 
correctness. The previous method, while it didnt scale as well, was at 
least more obvious to review.

	Ingo
