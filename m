Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVL2EMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVL2EMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 23:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVL2EMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 23:12:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16781 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965010AbVL2EMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 23:12:07 -0500
Date: Wed, 28 Dec 2005 20:11:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, arjan@infradead.org, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-Id: <20051228201150.b6cfca14.akpm@osdl.org>
In-Reply-To: <20051228214845.GA7859@elte.hu>
References: <20051228114637.GA3003@elte.hu>
	<Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	<1135798495.2935.29.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	<20051228212313.GA4388@elte.hu>
	<20051228214845.GA7859@elte.hu>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> I think gcc should arguably not be forced to inline things when doing 
> -Os, and it's also expected to mess up much less than when optimizing 
> for speed. So maybe forced inlining should be dependent on 
> !CONFIG_CC_OPTIMIZE_FOR_SIZE?

When it comes to inlining I just don't trust gcc as far as I can spit it. 
We're putting the kernel at the mercy of future random brainfarts and bugs
from the gcc guys.  It would be better and safer IMO to continue to force
`inline' to have strict and sane semamtics, and to simply be vigilant about
our use of it.

IOW: I'd prefer that we be the ones who specify which functions are going
to be inlined and which ones are not.


If no-forced-inlining makes the kernel smaller then we probably have (yet
more) incorrect inlining.  We should hunt those down and fix them.  We did
quite a lot of this in 2.5.x/2.6.early.  Didn't someone have a script which
would identify which functions are a candidate for uninlining?
