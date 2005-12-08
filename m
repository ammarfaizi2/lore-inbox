Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbVLHX4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbVLHX4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbVLHX4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:56:50 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:50169 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932754AbVLHX4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:56:50 -0500
Subject: Re: [PATCH] Decrease number of pointer derefs in nfnetlink_queue.c
From: Steven Rostedt <rostedt@goodmis.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, laforge@netfilter.org, jmorris@intercode.com.au,
       coreteam@netfilter.org, linux-kernel@vger.kernel.org,
       jesper.juhl@gmail.com
In-Reply-To: <20051208.145148.36886043.davem@davemloft.net>
References: <200512082336.01678.jesper.juhl@gmail.com>
	 <20051208.145148.36886043.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 18:56:25 -0500
Message-Id: <1134086185.6279.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 14:51 -0800, David S. Miller wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Date: Thu, 8 Dec 2005 23:36:01 +0100
> 
> > Here's a small patch to decrease the number of pointer derefs in
> > net/netfilter/nfnetlink_queue.c
> > 
> > Benefits of the patch:
> >  - Fewer pointer dereferences should make the code slightly faster.
> >  - Size of generated code is smaller
> >  - improved readability
> 
> And you verified the compiler isn't making these transformations
> already?  It should be doing so via Common Subexpression Elimination
> unless the derefs are scattered around with interspersed function
> calls in which case the compiler cannot prove that the memory
> behind the pointer does not change.

Even if point one and two are not true, if it doesn't hurt size or
performance, point three (improved readability) is definitely worth
adding.

-- Steve


