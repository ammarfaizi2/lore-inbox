Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268463AbTCFWZv>; Thu, 6 Mar 2003 17:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268469AbTCFWZv>; Thu, 6 Mar 2003 17:25:51 -0500
Received: from [66.78.32.3] ([66.78.32.3]:16039 "EHLO blacksea.bsdns.net")
	by vger.kernel.org with ESMTP id <S268463AbTCFWZt> convert rfc822-to-8bit;
	Thu, 6 Mar 2003 17:25:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Northup <lkml@digitaleric.net>
Reply-To: mailing-lists@digitaleric.net
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HT and idle = poll
Date: Thu, 6 Mar 2003 17:36:17 -0500
User-Agent: KMail/1.4.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Theurer <habanero@us.ibm.com>
References: <Pine.LNX.4.44.0303061206240.8404-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303061206240.8404-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303061736.17181.lkml@digitaleric.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - blacksea.bsdns.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - digitaleric.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 March 2003 03:08 pm, Linus Torvalds wrote:
> On 6 Mar 2003, Alan Cox wrote:
> > idle=poll probably needs to be doing "rep nop" in a tight loop.
>
> We already do that. It's not enough. The HT thing will still steal cycles
> continually, since the "rep nop" is really only equivalent to a
> "sched_yield()".

(Perhaps a naive idea) Right now, there is a single "rep nop" per poll.  What 
happens if you unroll the loop a few times:

while (!condition) {
	cpu_relax();
	cpu_relax();
	cpu_relax();
}

?  I have no HT hardware so can't test this.

-Eric
