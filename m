Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVKHM1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVKHM1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVKHM1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:27:37 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:29134 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964995AbVKHM1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:27:36 -0500
Date: Tue, 8 Nov 2005 13:27:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Neil Brown <neilb@suse.de>
Cc: Andre Noll <maan@systemlinux.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: BUG: soft lockup detected on CPU#0! (linux-2.6.14)
Message-ID: <20051108122744.GA3045@elte.hu>
References: <20051106193142.GD26862@skl-net.de> <17262.31781.497775.640424@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17262.31781.497775.640424@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Neil Brown <neilb@suse.de> wrote:

> > Nov  4 12:46:44 p133 kernel: BUG: soft lockup detected on CPU#0!
> 
> This seems to suggest that the nfsd thread is always runnable, which 
> implies a read-only load with everything in cache - at least for the 
> 10 seconds leading up to each of these errors.  Is that likely?
> 
> The following patch might fix it.  Please let me know the result.

>  	try_to_freeze();
> +	cond_resched();

and the NFSd thread never considered preemption in any other place? Then 
this should be the right fix - the kernel was running under !PREEMPT.

	Ingo
