Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVAKCGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVAKCGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVAKCFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:05:10 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:44195 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262737AbVAKCDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:03:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=J3doqQziTBWJuFXnpBLTkqkmGp9BRNYKJLLqs2jkK3oIASBW3pHklZJtOZ2m15JsizuFftKkK1hMOpQSAzy8YpqLLwqQaBldeqQENG5CsC2BNjDYxmPv9Dt1SSqg8EEMKMQxVcGkGroMF/grh601Hu4YTXXQV3kIDCdeoB+20hM=
Message-ID: <4d6522b90501101803523eea79@mail.gmail.com>
Date: Tue, 11 Jan 2005 04:03:48 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: tglx@linutronix.de
Subject: Re: User space out of memory approach
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1105403747.17853.48.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some points on Thomas comments,

> 
> I have no objections against the userspace provided candidate list
> option, but as long as the main sources of trouble
> 
>         - invocation
>         - reentrancy
>         - timed, counted, blah ugly protection
>         - selection problem
> 
> are not fixed properly, we don't need to discuss the inclusion of a
> userspace provided candidate list.

Any solution that doesn't  offer a proper approach to the above issues
should not be discussed anyway. By allowing the ranking goes up to the
user space is not meant only for user testing ranking, but to keep the
OOM Killer kernel code simpler and clean. As a matter of fact, even
protected.

Consider the invocation for example. It comes in two phases with this proposal:
1) ranking for the most likely culprits only starts when memory consumption
    gets close to the red zone (for example 98% or something like that).
2) killing just gets the first candidate from the list and kills it.
No need to calculate
    at kernel level.

The selection problem is very dependent on the ranking algorithm. For PCs it
may not be a trouble, but for emdedded devices? yes it is. The ranking at the
kernel level uses only int type of integer. If you get the log file
for the ranking
in any embedded device you will notice that many processes end up with
the same ranking point. Thus, there will never be the best choice in this way.

By moving just the ranking to the user space fix this problem 'cause you may
use float to order PIDs with different indexes. The good side effect is that we 
allow better ways of choosing the culprit by means of diffrent calculations to 
meet different patterns of memory consumtion.


> Postpone this until the main problem is fixed. There is a proper
> confirmed fix for this available. It was posted more than once.
> 
> Merging a fix which helps only 0,001 % of the users to hide the mess
> instead of fixing the real problem is a real interesting engineering
> aproach.
> 
> I don't deny, that after the source of trouble is fixed it is worth to
> think about the merging of this addon to allow interested users to
> define the culprits instead of relying on an always imperfect selection
> algorithm.

br

Edjard
-- 
"In a world without fences ... who needs Gates?"
