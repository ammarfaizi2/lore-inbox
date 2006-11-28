Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936087AbWK1UHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936087AbWK1UHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936083AbWK1UHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:07:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:65428 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936087AbWK1UHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:07:20 -0500
Date: Tue, 28 Nov 2006 21:05:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt7: Kernel BUG at kernel/rtmutex.c:672
Message-ID: <20061128200519.GA25364@elte.hu>
References: <1164737474.15887.10.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164737474.15887.10.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Nov 28 03:26:39 localhost kernel: Kernel BUG at kernel/rtmutex.c:672

hm, this means the lock was taken twice by the same task: enabling 
CONFIG_PROVE_LOCKING ought to tell us the precise locking info and 
backtraces that causes this situation. I looked at the code and it wasnt 
obvious at first sight. (we should only be holding cache_chain_mutex 
here, and l3->list_lock should not be taken at this point.)

	Ingo
