Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTHWRE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbTHWRCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:02:00 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:33448
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263406AbTHWQwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 12:52:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH]O18.1int
Date: Sun, 24 Aug 2003 02:58:33 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
References: <200308231555.24530.kernel@kolivas.org> <20030823023231.6d0c8af3.akpm@osdl.org> <3F4738BE.6060007@cyberone.com.au>
In-Reply-To: <3F4738BE.6060007@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308240258.33924.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003 19:49, Nick Piggin wrote:
> Andrew Morton wrote:
> >We have a problem.   See the this analysis from Steve Pratt.

> >Steve has done some preliminary testing which indicates that the
> > volanomark and specjbb regressions are due to the CPU scheduler changes.

> >It might help if you or a buddy could get set up with volanomark on an
> > OSDL 4-or-8-way so that you can more closely track the effect of your
> > changes on such benchmarks.

Ok here goes. 
This is on 8way:

Test4:
Average throughput = 11145 messages per second

Test4-O18.1:
Average throughput = 9860 messages per second

Test3-mm3:
Average throughput = 9788 messages per second


So I grabbed test3-mm3 and started peeling back the patches
and found no change in throughput without _any_ of my Oxint patches applied, 
and just Ingo's A3 patch:

Test3-mm3-A3
Average throughput = 9889 messages per second


Then finally I removed that patch so there were no interactivity patches:
Test3-mm3-ni
Average throughput = 11052 messages per second


I performed each run 3 times and have the results and profiles posted here:
http://kernel.kolivas.org/2.5/volano

wli suggested inlining sched_clock from A3 to see if that helped but at 3am I 
think it can wait. At least I've been able to track down the drop. Thanks 
zwane for the iron access.

Con

