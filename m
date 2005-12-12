Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVLLSSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVLLSSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLLSSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:18:10 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:9622 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932106AbVLLSSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:18:09 -0500
Message-ID: <439DD082.9508C87C@tv-sign.ru>
Date: Mon, 12 Dec 2005 22:33:22 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
Cc: Keith Owens <kaos@ocs.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of 
 nohz_cpu_mask ]
References: <1134344716.5937.11.camel@localhost.localdomain> <18382.1134348547@ocs3.ocs.com.au> <20051212084112.GA3934@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> 
> Oleg, with all these inputs, I consider the patch I had sent to be correct.

Yes, I think so. My suspects were due to my misunderstanding.
I was wrong when I said that we can ignore rmb() part of mb()
in case when start_hz_timer() runs after rcu_start_batch().

	rcp->cur++;
	// ->cur will be visible to other cpus
	// _before_ we will *READ* nohz_cpu_mask.
	// we don't have any 'timing' problems.
	// In other words: if another cpu does not
	// see the new value - we did not read this
	// mask yet.
	smp_mb();

Thanks for your patience.

> P.S :- Thanks to everybody who reponded clarifying this subject.

Yes! it was really helpful, thanks to all. I think it would be great
to have Paul's very clear (and short!) explanation somewhere in
Documentation/.

Oleg.
