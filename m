Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVERXek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVERXek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVERXed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:34:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:48567 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262390AbVERXe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:34:27 -0400
Date: Wed, 18 May 2005 16:36:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Coywolf Qi Hunt <coywolf@lovecn.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] time_after_eq fix
In-Reply-To: <20050518224415.GA5768@lovecn.org>
Message-ID: <Pine.LNX.4.58.0505181632190.18337@ppc970.osdl.org>
References: <20050518224415.GA5768@lovecn.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 May 2005, Coywolf Qi Hunt wrote:
> 
> And I don't agree with the the original code comment. I don't think this
> is gcc's fault.  If it is "a good compiler" or "a really good compiler",
> trying to be smarter than human, it wouldn't still be a C compiler.
> So I'd like it be removed.

The original comment is correct, and your changed comment is nonsensical, 
since "<= 0" doesn't actually test the sign of the result like your 
comment says.

Also, your patch itself seems not very sensible. Why do you think your 
patch matters?

> -	 ((long)(a) - (long)(b) >= 0))
> +	 ((long)(b) - (long)(a) <= 0))

Now, tell me why that one line would make any difference, except for the 
(undefined) case where we don't know and the time is as far behind as it 
is ahead?

Notice: you switch the order of the subtraction, and you switch the sign 
of the test. The original code allowed old gcc versions to generate better 
code. Your new code doesn't. 

What am I missing?

		Linus
