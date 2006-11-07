Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752945AbWKGXyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbWKGXyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbWKGXyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:54:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14265 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752945AbWKGXyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:54:43 -0500
Date: Wed, 8 Nov 2006 00:53:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, rdreier@cisco.com
Subject: Re: locking hierarchy based on lockdep
Message-ID: <20061107235342.GA5496@elte.hu>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com> <20061106200529.GA15370@elte.hu> <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com>
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


* Jason Baron <jbaron@redhat.com> wrote:

> > this would certainly be the simplest thing to do - we could extend 
> > /proc/lockdep with the list of 'immediately after' locks separated by 
> > commas. (that list already exists: it's the lock_class.locks_after list)
>
> So below is patch that does what you suggest, although i had to add 
> the concept of 'distance' to the patch since the locks_after list 
> loses this dependency info afaict. i also wrote a user space program 
> to sort the locks into cluster of interelated locks and then sorted 
> within these clusters...the results show one large clump of 
> locks...perhaps there are a few locks that time them all together like 
> scheduler locks...but i couldn't figure out which ones to exclude to 
> make the list look really pretty (also, there could be a bug in my 
> program :). Anyways i'm including my test program and its output 
> too...

nice!

small detail: i'm wondering why 'distance' is needed explicitly? The 
dependency graph as it is represented by locks_after should be a full 
representation of all locking dependencies. What is the intended 
definition of 'distance' - the distance from the root of the dependency 
tree? (Maybe i'm misunderstanding what you are trying to achieve.)

	Ingo
