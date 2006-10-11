Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWJKJBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWJKJBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWJKJBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:01:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32699 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965177AbWJKJBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:01:43 -0400
Date: Wed, 11 Oct 2006 10:52:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 000 of 4] Introduction
Message-ID: <20061011085255.GA6051@elte.hu>
References: <20061011155522.7915.patches@notabene>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011155522.7915.patches@notabene>
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


* NeilBrown <neilb@suse.de> wrote:

> Following 4 patches address issues with lockdep, particularly around 
> bd_mutex.
> 
> They are against 2.6.18-mm3 and do *not* apply against -linus as -mm 
> already has some changes to the handling of bd_mutex nesting.  2-4 
> probably apply on top of -linus plus 
> -mm/broken-out/remove-the-old-bd_mutex-lockdep-annotation.patch
> 
> I believe they are probably ok for 2.6.19.

agreed.

they look quite nice in that they also simplify the underlying locking. 
(instead of just trying to clone whatever locking yuckiness there is, 
into the lockdep space.)

> The last fixes a tangentially related lockdep problem in md - there is 
> a false relationship between bd_mutex and md->reconfig_mutex which 
> needs to be clarified.

> md_open takes ->reconfig_mutex which causes lockdep to complain. This 
> (normally) doesn't have deadlock potential as the possible conflict is 
> with a reconfig_mutex in a different device.
>
> I say "normally" because if a loop were created in the array->member 
> hierarchy a deadlock could happen.  However that causes bigger 
> problems than a deadlock and should be fixed independently.

ok to me. Sidenote: shouldnt we algorithmically forbid that "loop" 
scenario from occuring, as that possibility is what causes lockdep to 
complain about the worst-case scenario?

	Ingo
