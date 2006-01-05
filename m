Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWAEVAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWAEVAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbWAEVAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:00:22 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:6779 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750863AbWAEVAW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:00:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fZM8BmbT5TMBWxomGFXlbp5htGU/cq1mSPj7Dnu7YtmhRsjwRYuc2YNzsf/ZvAKfBDKCiB4B+brRQk6ufZsaspFUnmp2DY2HM13nuNq87hxs+cElImcqIOrWL1N1AOEBUiDUAqzGk3wGms2YetDo2cIul4bjIs4y6QqOIphM1cU=
Message-ID: <9c21eeae0601051300t1a7decb9k86536870e1cd4597@mail.gmail.com>
Date: Thu, 5 Jan 2006 13:00:18 -0800
From: David Brown <dmlb2000@gmail.com>
To: James Cloos <cloos@jhcloos.com>
Subject: Re: 2.6.15-rt1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <m3r77mv1ma.fsf@lugabout.cloos.reno.nv.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103094720.GA16497@elte.hu>
	 <m3r77mv1ma.fsf@lugabout.cloos.reno.nv.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get this compiling 15-rt1:
>
> ,----
> |   CC      net/ipv6/mcast.o
> | net/ipv6/mcast.c: In function `ipv6_sock_mc_join':
> | net/ipv6/mcast.c:227: error: `RW_LOCK_UNLOCKED' undeclared (first use in this function)
> | net/ipv6/mcast.c:227: error: (Each undeclared identifier is reported only once
> | net/ipv6/mcast.c:227: error: for each function it appears in.)
> | make[2]: *** [net/ipv6/mcast.o] Error 1
> `----
>
> I take it something on the order of this is needed?:
>
> -       mc_lst->sflock = RW_LOCK_UNLOCKED;
> +       mc_lst->sflock = RW_LOCK_UNLOCKED(foo.bar);
>
> for some foo.bar, yes?
>
> Or is it?:
>
> -       mc_lst->sflock = RW_LOCK_UNLOCKED;
> +       rwlock_init(mc_lst->sflock);
>
> I'm trying the latter now, but won't be able to reboot for
> a runtime test for a while....
>

Take a look at the 15-rt1-sr1 patch it has a fix for this
there was also a fix posted earlier in the thread :)

and its:
-       mc_lst->sflock = RW_LOCK_UNLOCKED;
+       mc_lst->sflock = RW_LOCK_UNLOCKED(mc_list->fslock);

- David Brown
