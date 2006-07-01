Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932855AbWGARkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbWGARkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932943AbWGARkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:40:25 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:45473 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932855AbWGARkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:40:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bLNAofUm1X8oWYFmpkmgzyYyBRvGi66U7ClDfi4JYa2E0vkwbiA30OjyzG6djNhkJnAZN5Ql8BSGNaJnBtjcBmeXEw22KjpFEgnBtrBjiYBOKl50M+8h3EC8ckv6bWLfs1IURvMI0BjNeybRZBl3a+3qKMf9s5oj/6u06me7u5U=  ;
Message-ID: <44A6B387.80207@yahoo.com.au>
Date: Sun, 02 Jul 2006 03:40:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [patch 0/2] sLeAZY FPU feature
References: <1151773893.3195.45.camel@laptopd505.fenrus.org>
In-Reply-To: <1151773893.3195.45.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Hi,
> 
> the two patches in this series (the x86-64 on by me, the i386 one by
> Chuck Ebbert) change how the lazy fpu feature works. In the current
> situation, we are 100% lazy, meaning that after every context switch,
> the application takes a trap on the first FPU use, which then restores
> the FPU context.
> 
> The sLeAZY FPU patch changes this behavior; if a process has used the
> FPU for 5 stints at a row, the behavior becomes proactive and the FPU
> context is restored during the regular context switch already. This
> means we can avoid the trap.
> 
> The underlying assumption is that if a process uses 5 times consecutive,
> it's likely to do it the 6th and later times as well (eg it's not a
> one-off behavior).
> 
> There is a limit built in; this proactive behavior resets after 255
> times, so that when a process is long lived and chances behavior, it'll
> still get the right behavior (for performance) after some time.
> 
> Chuck measured a +/- 0.4% performance gain, and my experiments show a
> similar improvement.

What sort of test? Any idea of the results for a best case microbenchmark
(something like two threads ping-pong a couple of futexes between them,
in between doing a single FPU op)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
