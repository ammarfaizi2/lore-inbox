Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUHIL0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUHIL0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUHIL0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:26:10 -0400
Received: from colin2.muc.de ([193.149.48.15]:16657 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266481AbUHIL0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:26:04 -0400
Date: 9 Aug 2004 13:26:03 +0200
Date: Mon, 9 Aug 2004 13:26:03 +0200
From: Andi Kleen <ak@muc.de>
To: S Vamsikrishna <vamsi_krishna@in.ibm.com>
Cc: prasanna@in.ibm.com, linux-kernel@vger.kernel.org, shemminger@osdl.org,
       suparna@in.ibm.com
Subject: Re: [0/3]kprobes-base-268-rc3.patch
Message-ID: <20040809112603.GA25663@muc.de>
References: <OF3CCCD7A9.BF71DED2-ON85256EEB.0006D48C-85256EEB.000CA600@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3CCCD7A9.BF71DED2-ON85256EEB.0006D48C-85256EEB.000CA600@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 10:23:15PM -0400, S Vamsikrishna wrote:
> Hi,
> 
> A few comments/questions on this patch:
> 
> - An unconditional call is added in the do_page_fault hot path. Is this 
> ok? 
>   The version of kprobes that hooks directly into the do_page_fault is 
> better
>   in the common case of page fault occuring outside of the kprobe handler,
>   the overhead is only a global variable load and compare. 

If this should be a problem the notifier can be changed again to do
a quick check inline if the notifier list is empty or not.

The old notifiers were fully inline, but that was changed later.

> 
> - Would the absence of any locking on the read-side of the notifier chains
>   cause any problems, especially when it is in a frequently hit place
>   like the do_page_fault?

The notifiers were intended to not be unloaded originally. But with RCU
you could unload them anyways

(ok would probably need some depends memory barriers in the notifier
walk on Alpha, should work everywhere else) 

-Andi
