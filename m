Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266101AbUFPDOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUFPDOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbUFPDND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:13:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:62600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266086AbUFPDLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:11:22 -0400
Date: Tue, 15 Jun 2004 20:10:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Herbert Xu <herbert@gondor.apana.org.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, mingo@elte.hu,
       kernel@kolivas.org, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, akpm@osdl.org, wli@holomorphy.com,
       markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
In-Reply-To: <40CFB8FD.2010601@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0406152009220.4142@ppc970.osdl.org>
References: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au> <40CFB8FD.2010601@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Jun 2004, Nick Piggin wrote:
> 
> I think balance on clone probably needs to be turned off by default
> presently.
> 
> It slows down a simple thread creation test by a factor of 7(!) here,
> and has quite a few not too difficult to imagine performance problems.

I agree. However, I still think we should do my suggested
"wake_up_new(p,clone_flags)" thing, and then have the logic on whether to 
try to care about threading or not be in schedule.c, not in kernel/fork.c.

The fact is, fork.c shouldn't try to make scheduling decisions. But it 
could inform the scheduler about the new process, and THAT can then make 
the decisions.

		Linus
