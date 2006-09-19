Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWISXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWISXu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWISXu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 19:50:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:4310 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750877AbWISXu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 19:50:58 -0400
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Waychison <mikew@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <45107ECE.5040603@google.com>
References: <1158274508.14473.88.camel@localhost.localdomain>
	 <20060915001151.75f9a71b.akpm@osdl.org>  <45107ECE.5040603@google.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:50:35 +1000
Message-Id: <1158709835.6002.203.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 16:35 -0700, Mike Waychison wrote:
> Patch attached.
> 
> As Andrew points out, the logic is a bit hacky and using a flag in 
> current->flags to determine whether we have done the retry or not already.
> 
> I too think the right approach to being able to handle these kinds of 
> retries in a more general fashion is to introduce a struct 
> pagefault_args along the page faulting path.  Within it, we could 
> introduce a reason for the retry so the higher levels would be able to 
> better understand what to do.

 .../...

I need to re-read your mail and Andrew as at this point, I don't quite
see why we need that args and/or that current->flags bit instead of
always returning all the way to userland and let the faulting
instruction happen again (which means you don't block in the kernel, can
take signals etc... thus do you actually need to prevent multiple
retries ?)

Ben.


