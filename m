Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUBDK1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 05:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266321AbUBDK1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 05:27:50 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:27565 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262030AbUBDK1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 05:27:49 -0500
From: Duncan Sands <baldrick@free.fr>
To: emmanuel@netlab.hut.fi, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeing skbuff (was: Re: Sending built-by-hand packet and kernel panic.)
Date: Wed, 4 Feb 2004 11:27:45 +0100
User-Agent: KMail/1.5.4
References: <401E62C3.60503@netlab.hut.fi> <200402021602.56242.baldrick@free.fr> <401E8E33.7050305@netlab.hut.fi>
In-Reply-To: <401E8E33.7050305@netlab.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402041127.45346.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks a lot for pointing out these problems. I had completely missed them.
> However, my overall problem is not solved. As far as my investigations
> led me, my sk_buff structure is never released after having been sent on
> the wire. So I guess I need an explicit destructor function in my
> sk_buff as the following is present in the definition of struct sk_buff:
> void         (*destructor)(struct sk_buff *);    /* Destruct function
>     */

Hi Emmanuel, maybe the call that sends to skb (NF_HOOK) is returning
a non-zero error code.  In that case it is your responsability [1] to free the
skb.

Duncan.

[1] This is true for many parts of the kernel but not all.  I don't know what
NF_HOOK is so this may not apply here.
