Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUBKG6C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUBKG6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:58:02 -0500
Received: from dictum-ext.geekmail.cc ([204.239.179.245]:22446 "EHLO
	mailer01.geekmail.cc") by vger.kernel.org with ESMTP
	id S263637AbUBKG54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:57:56 -0500
Message-ID: <4029D267.40307@swapped.cc>
Date: Tue, 10 Feb 2004 22:57:43 -0800
From: Alex Pankratov <ap@swapped.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [1/2] hlist: replace explicit checks of hlist fields
 w/ func calls
References: <4029CB7B.3090409@swapped.cc> <20040213231407.208204c4.ak@suse.de>
In-Reply-To: <20040213231407.208204c4.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:

> On Tue, 10 Feb 2004 22:28:11 -0800
> Alex Pankratov <ap@swapped.cc> wrote:
> 
> 
>>Second patch removes if's from hlist_xxx() functions. The idea
>>is to terminate the list not with 0, but with a pointer at a
>>special 'null' item. Luckily a single 'null' can be shared
>>between all hlists _without_ any synchronization, because its
>>'next' and 'pprev' fields are never read. In fact, 'next' is
>>not accessed at all, and 'pprev' is used only for writing.
> 
> I disagree with this change. The problem is that in a loop
> you need a register now to store the terminating element
> and compare to it instead of just testing for zero. This can generate 
> much worse code  on register starved i386 than having the conditional.

Ugh, yeah, I thought about this. However my understand was that
since hlist_null is statically allocated variable, its address
will be a known constant at a link time (whether it's a static
link or dynamic/run-time link - btw, excuse my lack of proper
terminology here). So comparing something to &null would be
equivalent to comparing to the constant and not require an
extra register.

Alex


