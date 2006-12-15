Return-Path: <linux-kernel-owner+w=401wt.eu-S1751936AbWLOL1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWLOL1M (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 06:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWLOL1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 06:27:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44490 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbWLOL1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 06:27:11 -0500
Date: Fri, 15 Dec 2006 12:24:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19, more unwinder problems ...
Message-ID: <20061215112435.GA14824@elte.hu>
References: <20061215101546.GA2296@elte.hu> <45828D19.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45828D19.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <jbeulich@novell.com> wrote:

> validating that the item read is between current and previous stack 
> pointer, which in turn are being derived from register state and 
> unwind information.

i still dont quite get it - and i feel deja vu. Didnt we agree that the 
right way to go about this is to validate all stack information based on 
what the kernel already knows about all the stacks that the task may 
use? I.e. only allow pointers into the kernel stack and into the various 
kernel stacks. No 'probe kernel pointer' or anything. If the unwind data 
or register state ever points outside that basic filter, abandon the 
walk. Am i missing something?

	Ingo
