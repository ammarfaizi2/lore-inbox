Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWFMJ1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWFMJ1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 05:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWFMJ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 05:27:13 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:18697 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750818AbWFMJ1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 05:27:13 -0400
Message-ID: <448E84EE.9000503@argo.co.il>
Date: Tue, 13 Jun 2006 12:27:10 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: use C code for current_thread_info()
References: <20060613064311.GA27543@rhlx01.fht-esslingen.de>
In-Reply-To: <20060613064311.GA27543@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2006 09:27:11.0189 (UTC) FILETIME=[8C69D850:01C68ECB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
>
> An entirely different way would be to store the stack base value in a
> global variable and update that on each context switch, but it would 
> increase
> context switch overhead and have >= 2 cycles access time for L1 cache 
> (which
> would be the best memory access case!), which would most likely be more
> combined overhead than an AGI stall (I was mistaken in declaring the 
> stall
> a pipeline flush - it's only a stall for a couple cycles, not a full 
> flush
> wasting ~ 15 cycles).
>

That wouldn't work on SMP.  You'd need per-cpu variables, which are 
likely even slower.

[One way around that would be to use a segment register for the per-cpu 
areas]

-- 
error compiling committee.c: too many arguments to function

