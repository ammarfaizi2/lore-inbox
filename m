Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWGKRCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWGKRCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWGKRCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:02:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751101AbWGKRCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:02:16 -0400
Date: Tue, 11 Jul 2006 10:02:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel@vger.kernel.org, efault@gmx.de
Subject: Re: [patch] i386: handle_BUG(): don't print garbage if debug info
 unavailable
In-Reply-To: <44B382DD.5070202@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0607110959160.5623@g5.osdl.org>
References: <200607101034_MC3-1-C497-51F7@compuserve.com>
 <20060711012755.59965932.akpm@osdl.org> <44B382DD.5070202@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jul 2006, Nick Piggin wrote:
> 
> OK but you don't need a do/while(0) here.

Actually, the way Andrew wrote it, it _is_ needed. It does two things:

 - it's the block scope that allows the private variables
 - if the "get_user()" fails, the "break" means that you don't have to 
   have a goto.

That said, I think it's wrong to use "__get_user()", which can hang on the 
MM semaphore if something is bogus. We should probably mark us as being 
"in_atomic()" to make sure that the page fault handler, if it is entered, 
will not try to get the semaphore or page anything in.

But that's a separate issue.

		Linus
