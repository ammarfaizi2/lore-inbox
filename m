Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVKXAxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVKXAxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVKXAxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:53:13 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30891
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932530AbVKXAxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:53:12 -0500
Date: Wed, 23 Nov 2005 16:53:14 -0800 (PST)
Message-Id: <20051123.165314.125752078.davem@davemloft.net>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       ak@muc.de
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0511231526340.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511230849380.13959@g5.osdl.org>
	<20051123.152031.02282381.davem@davemloft.net>
	<Pine.LNX.4.64.0511231526340.13959@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 23 Nov 2005 15:29:53 -0800 (PST)

> Add a new "__smp_only__" thing, and do something like
> 
> 	#ifdef CONFIG_SMP
> 	  #define __smp_only__
> 	#else
> 	  #define __smp_only \
> 		__attribute__((__unused__, section("discard")))
> 	#endif
> 
> (Yeah, I didn't look up the section syntax, because I'm lazy, but you get 
> the point - put it explicitly in some section that will be thrown away, 
> and that we can make the build-checking tools verify isn't linked to).

If we mark it correctly, the linker will not even try to link it in to
the final object, and we'll get a flat out link failure.

Yes, something like this would be great.
