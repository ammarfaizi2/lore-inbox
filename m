Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272378AbTHEDBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272390AbTHEDBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:01:39 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:47002
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272378AbTHEDBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:01:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 13:06:38 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au>
In-Reply-To: <3F2F149F.1020201@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051306.38180.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 12:21, Nick Piggin wrote:
> >I've already posted a better solution in O13.1
>
> No, this still special-cases the uninterruptible sleep. Why is this
> needed? What is being worked around? There is probably a way to
> attack the cause of the problem.

Sure I'm open to any and all ideas. Cpu hogs occasionally do significant I/O. 
Up until that time they have been only losing sleep_avg as they have spent no 
time sleeping; and this is what gives them a lower dynamic priority. During 
uninterruptible sleep all of a sudden they are seen as sleeping even though 
they are cpu hogs waiting on I/O. Witness the old standard, a kernel compile. 
The very first time you launch a make -j something, the higher the something, 
the longer all the jobs wait on I/O, the better the dynamic priority they 
get, which they shouldn't. 

No, this is not just a "fix the scheduler so you don't feel -j kernel 
compiles" as it happens with any cpu hog starving other tasks, and the longer 
the cpu hogs wait on I/O the worse it is.  This change causes a _massive_ 
improvement for that test case which usually brings the machine to a 
standstill the size of which is dependent on the number of cpu hogs and the 
size of their I/O wait. I don't think the latest incarnation should be a 
problem. In my limited testing I've not found any difference in throughput 
but I don't have a major testbed at my disposal, nor time to use one if it 
was offered which is why I requested more testing. 

Thoughts?

Con

