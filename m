Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWGGKZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWGGKZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWGGKZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:25:04 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:49061 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932121AbWGGKZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:25:02 -0400
Date: Fri, 7 Jul 2006 06:21:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] spinlocks: remove 'volatile'
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>
Message-ID: <200607070623_MC3-1-C45A-2429@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0607061333190.3869@g5.osdl.org>

On Thu, 6 Jul 2006 13:34:14 -0700, Linus Torvalds wrote:

> > So I _think_ that we should change the "=m" to the much more correct "+m" 
> > at the same time (or before - it's really a bug-fix regardless) as 
> > removing the "volatile".
> 
> Here's a first cut (UNTESTED!) for x86. I didn't check any other 
> architectures, I bet they have similar problems.

>  #define __raw_spin_unlock_string \
>       "movb $1,%0" \
> -             :"=m" (lock->slock) : : "memory"
> +             :"+m" (lock->slock) : : "memory"
 
This really is just an overwrite of whatever is there.  OTOH I can't see
how this change could hurt anything..

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
