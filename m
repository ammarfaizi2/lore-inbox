Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVDLGnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVDLGnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVDLGnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:43:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50908 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262018AbVDLGnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:43:03 -0400
Date: Tue, 12 Apr 2005 08:42:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
Message-ID: <20050412064253.GA1289@elte.hu>
References: <3R6Ir-89Y-23@gated-at.bofh.it> <ugoecowjci.fsf@panda.mostang.com> <20050409070738.GA5444@elte.hu> <16983.33049.962002.335198@napali.hpl.hp.com> <20050409155810.593d8f7b.davem@davemloft.net> <20050410064324.GA24596@elte.hu> <16987.7956.806699.617633@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16987.7956.806699.617633@napali.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.223, required 5.9,
	BAYES_00 -4.90, SUBJ_HAS_UNIQ_ID 2.68
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Mosberger <davidm@napali.hpl.hp.com> wrote:

> Now, Ingo says that the order is reversed with his patch, i.e., 
> switch_mm() happens after switch_to().  That means flush_tlb_mm() may 
> now see a current->active_mm which hasn't really been activated yet.  
> That should be OK since it would just mean that we'd do an early (and 
> duplicate) activate_context().  While it does not give me a warm and 
> fuzzy feeling to have this inconsistent state be observable by 
> interrupt-handlers (and, in particular, IPI-handlers), I don't see any 
> problem with it off hand.

thanks for the analysis. I fundamentally dont have any fuzzy feeling 
from having _any_ portion of the context-switch path nonatomic, but with 
more complex hardware it's just not possible it seems.

	Ingo
