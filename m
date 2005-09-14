Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVINQYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVINQYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVINQYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:24:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1206
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030247AbVINQYp (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Sep 2005 12:24:45 -0400
Date: Wed, 14 Sep 2005 09:24:41 -0700 (PDT)
Message-Id: <20050914.092441.87955714.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 4/5] atomic: dec_and_lock use cmpxchg
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <432839F1.5020907@yahoo.com.au>
References: <4328387E.6050701@yahoo.com.au>
	<432838E8.5030302@yahoo.com.au>
	<432839F1.5020907@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Thu, 15 Sep 2005 00:55:45 +1000

> I noticed David posted a patch to do something similar the
> other day. With a generic atomic_cmpxchg available, such a
> patch is no longer objectionable to those architectures
> that don't #define __HAVE_ARCH_CMPXCHG
> 
> Do we want this David? Any other architecture have a super
> optimised atomic_dec_and_lock that surpasses this
> implementation?

I talked to Linus about my patch and he made the good point that the
Alpha optimization is very valid (it avoids loading the GP and other
stuff by doing that fancy assembler entry point).  So we decided that
we'd make the cmpxchg() generic version, but make moving over to that
gradual instead of mandatorily forcing everyone to use the new thing.

So, for example, we'd convert sparc64 (because I want to) and the
architectures using the exact same ppc64 C code, but leave the others
alone.  It'd be up to the remaining platform's maintainers to move
over if they wanted to.

I'll submit that updated patch to him later today.
