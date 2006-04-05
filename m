Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWDEWzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWDEWzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWDEWzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:55:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51931
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932118AbWDEWzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:55:46 -0400
Date: Wed, 05 Apr 2006 15:51:06 -0700 (PDT)
Message-Id: <20060405.155106.125371395.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Improve usage of memory barriers and remove IRQ
 disablement
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <44338CAE.6060206@yahoo.com.au>
References: <20060404095529.31311.3892.stgit@warthog.cambridge.redhat.com>
	<29064.1144226770@warthog.cambridge.redhat.com>
	<44338CAE.6060206@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Wed, 05 Apr 2006 19:23:58 +1000

> David Howells wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > | 	int atomic_inc_and_test(atomic_t *v);
> > | 	int atomic_dec_and_test(atomic_t *v);
> > | 
> > | These two routines increment and decrement by 1, respectively, the
> > | given atomic counter.  They return a boolean indicating whether the
> > | resulting counter value was zero or not.
> > | 
> > | It requires explicit memory barrier semantics around the operation as
> > | above.
> > 
> > Note the last paragraph.  "It requires" should be "They require", but the
> > sense would seem to be obvious.  However, it's not clear on a second reading
> > as to whether this is an instruction to the _caller_ or an instruction to the
> > arch _implementer_.
> > 
> 
> Yes, I remember Dave M clarified this sometime ago (on lkml I guess). It
> is a little confusing, but I think the wording is for the implementer's
> point of view. Dave will pull me up if I'm wrong...

Any routine which returns state must have the barriers in the arch
implementation.  These two routines returns state.
