Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSFELwr>; Wed, 5 Jun 2002 07:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSFELwq>; Wed, 5 Jun 2002 07:52:46 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:49915 "EHLO
	imgserv04.imerge.co.uk") by vger.kernel.org with ESMTP
	id <S315358AbSFELwo>; Wed, 5 Jun 2002 07:52:44 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB09C99A@imgserv04>
From: Ian Collinson <icollinson@imerge.co.uk>
To: "'Andrew Morton'" <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
        Andi Kleen <ak@muc.de>
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de
Subject: RE: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
Date: Wed, 5 Jun 2002 12:53:06 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Fixing it would require boosting keventd's priority either globally 
> or temporarily. E.g. if the original reporter could put this
> (untested/uncompiled) at the beginning of
kernel/context.c:context_thread():
>
>     current->policy = SCHED_RR;
>     current->rt_priority = 99;
>
> it could fix his problem.

OK, I've tried the above fix on 2.4.17, and it seems to work.  Thanks Andi.
We can now get into the box on a high priority console after provoking a
lockup with a lower priority, CPU hogging realtime process.

Are there any potentially negative consequences of this fix, apart from
those already mentioned?

I certainly vote for this feature being preserved, as it is extremely useful
for debugging realtime priority apps.  FYI, we narrowed it down to breaking
in either 2.4.10-pre11 or pre12. 

Cheers
Ian


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


