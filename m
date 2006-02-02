Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422984AbWBBF4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWBBF4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422965AbWBBF4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:56:47 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43172
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422962AbWBBF4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:56:46 -0500
Date: Wed, 01 Feb 2006 21:56:44 -0800 (PST)
Message-Id: <20060201.215644.116024082.davem@davemloft.net>
To: torvalds@osdl.org
Cc: sfr@canb.auug.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH] compat: fix compat_sys_openat and friends
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0602012134150.21884@g5.osdl.org>
References: <20060202161151.58839ffd.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0602012134150.21884@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 1 Feb 2006 21:36:40 -0800 (PST)

> Wouldn't it be _much_ better to declare the argument as a "long", since 
> some architectures (alpha, for example) may assume that 32-bit arguments 
> have been _sign_extended, not zero-extended.
> 
> Then, when the "compat_sys_xxxx()" function passes the "long" down to the 
> _real_ function (which takes an "int"), those architectures (and only 
> those architectures) that actually have assumptions about high bits will 
> have the compiler automatically do the right zero- or sign-extensions at 
> that call-site.

There is the convention that for the compat system calls all the args
will be 32-bit zero extended by the platform syscall entry code before
the C code is invoked.  This topic used to come up a lot and finally
we all decided that was the thing to do.

It's important (at least I think so :-) for all of this generic compat
code to be able to have a well defined argument environment.

Anyways, I think that's how Stephen arrived at his patch.
