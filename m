Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWG0OwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWG0OwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWG0OwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:52:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40870 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751287AbWG0OwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:52:04 -0400
Date: Thu, 27 Jul 2006 16:45:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org, aia21@cantab.net,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [BUG?] possible recursive locking detected
Message-ID: <20060727144542.GA27451@elte.hu>
References: <200607261805.26711.eike-kernel@sf-tec.de> <20060726225311.f51cee6d.akpm@osdl.org> <44C86271.9030603@yahoo.com.au> <1153984527.21849.2.camel@imp.csi.cam.ac.uk> <20060727003806.def43f26.akpm@osdl.org> <1153988398.21849.16.camel@imp.csi.cam.ac.uk> <20060727015356.f01b5644.akpm@osdl.org> <1153992484.21849.36.camel@imp.csi.cam.ac.uk> <20060727094617.GA5955@elte.hu> <1154010677.21849.66.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154010677.21849.66.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> Note that even the above patch is not a 100% solution.  What 
> guarantees are there that the page faulted in will still be around 
> when it is read a few lines down the line in the code?  Given 
> sufficient parallel memory pressure/io pressure it can still cause the 
> page to be evicted again immediately after it is faulted in...
>
> All the above patch does is to _dramatically_ reduce the race window 
> for this happening but it does not eliminate it in theory (AFAICS).
> 
> So if your stance is that deadlocks are completely unacceptable it 
> still is not fixed.  If your stance is that _really_ unlikely 
> deadlocks are acceptable then it is fixed.

my 'stance' is pretty common-sense: exploitable deadlocks (it's possible 
to force eviction of a page), or even hard-to-trigger but possible 
deadlocks (which are not associated with hopeless resource exhaustation) 
must be fixed.

couldnt we exclude the case of 'write writing to the same page it is 
reading from' abuse, to avoid the deadlock problem?

	Ingo
