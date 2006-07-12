Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWGLHWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWGLHWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 03:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWGLHWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 03:22:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55261
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750777AbWGLHWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 03:22:06 -0400
Date: Wed, 12 Jul 2006 00:22:55 -0700 (PDT)
Message-Id: <20060712.002255.45063957.davem@davemloft.net>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparse annotation question 
From: David Miller <davem@davemloft.net>
In-Reply-To: <28491.1152686564@kao2.melbourne.sgi.com>
References: <20060711.231409.121242621.davem@davemloft.net>
	<28491.1152686564@kao2.melbourne.sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Owens <kaos@ocs.com.au>
Date: Wed, 12 Jul 2006 16:42:44 +1000

> I tried various combinations of __force, but kept getting this:
> 
> warning: incorrect type in argument 1 (different address spaces)
>    expected unsigned long *addr
>    got unsigned long [noderef] [force] *[addressable] bsp<asn:1>
> 
> What finally worked was
> 
>  	unsigned long i, *bsp, __user *ubsp;
> 	...
> 	ubsp = (unsigned long __user *) bsp;
> 	put_user(*contents, ubsp);
> 

Right, I guess if you try to do the cast in the put_user() macro
argument, you'll run into troubles because the __chk_user_ptr(ptr)
call wants an absolutely pure __user pointer, not one that is part of
a __force cast.
