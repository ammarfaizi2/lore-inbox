Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVFPAoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVFPAoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 20:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVFPAoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 20:44:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261694AbVFPAow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 20:44:52 -0400
Date: Wed, 15 Jun 2005 17:46:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bongani Hlope <bonganilinux@mweb.co.za>
cc: Andrew Morton <akpm@osdl.org>, ak@muc.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Tracking a bug in x86-64
In-Reply-To: <200506160139.04389.bonganilinux@mweb.co.za>
Message-ID: <Pine.LNX.4.58.0506151740110.8487@ppc970.osdl.org>
References: <200506132259.22151.bonganilinux@mweb.co.za>
 <200506160020.21688.bonganilinux@mweb.co.za> <Pine.LNX.4.58.0506151536000.8487@ppc970.osdl.org>
 <200506160139.04389.bonganilinux@mweb.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Jun 2005, Bongani Hlope wrote:
> 
> I just tested, 2.6.12-rc6 minus randomisation-top-of-stack-randomization.patch Works For Me (tm)

Ok, that _should_ mean that plain -rc6 should work fine for you, if you do

	echo 0 > /proc/sys/kernel/randomize_va_space 

and it would be good to validate that. But it still leaves the question of 
exactly _why_ that stack randomization matters for you.. Very strange.

Arjan, Ingo, any ideas? The code looks "Obviously Correct(tm)", but maybe 
there's something missing. Does it get the rlimit case wrong? 

Bongani, what does a simple

	cat /proc/self/maps

say for you with randomization enabled? Is there something mapped close to
the stack segment..

(It would be even better to see that for one of the processes that tends 
to core-dump, like "cc1", but that would require you to catch it, probably 
by doign ^Z at just the right time)

		Linus
