Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTE3Gdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTE3Gdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:33:36 -0400
Received: from cs.rice.edu ([128.42.1.30]:58319 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S263305AbTE3Gde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:33:34 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
References: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
	<1054267067.2713.3.camel@rth.ninka.net>
	<oyd3cixc9ev.fsf@bert.cs.rice.edu>
	<20030529.232440.122068039.davem@redhat.com>
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: 30 May 2003 01:46:12 -0500
In-Reply-To: <20030529.232440.122068039.davem@redhat.com>
Message-ID: <oydof1l2aq3.fsf@bert.cs.rice.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003 23:24:40 -0700 (PDT), "David S. Miller" <davem@redhat.com> writes:

>    From: Scott A Crosby <scrosby@cs.rice.edu>
>    Date: 30 May 2003 00:04:24 -0500
>    
>    Have you seen the current dcache function?
>    
>    /* Linux dcache */
>    #define HASH_3(hi,ho,c)  ho=(hi + (c << 4) + (c >> 4)) * 11
>    
> Awesome, moving the Jenkins will actually save us some
> cycles :-)

Tricky though, because what if you want to hash more than 64 bits? You
have to somehow chain Jenkin's together.

Let H(a,b,c) be a jenkin's hash that does  '' mix(a,b,c) ; return a ''

Let a,b,c,d,e be inputs to be hashed, and R,S,T,U be random keys.


Its not safe to do anything like

 H(H(a,b,c),H(d,e,f),R)

Because an attacker can brute-force to find tuples (a,b,c),
(a',b',c'), ... so that H(a,b,c) == H(a',b',c') == ....

A better approach (which I make with no formal analysis of its
quality) might be to construct this:

 H(a,b,R) ^ H(c,d,S) ^ H(e,f,T)

Perhaps the best approach is to visit Usenix Security 2003 this August
and ask the experts there.

Scott
