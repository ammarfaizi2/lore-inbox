Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbTBUGOE>; Fri, 21 Feb 2003 01:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbTBUGOE>; Fri, 21 Feb 2003 01:14:04 -0500
Received: from [63.205.85.133] ([63.205.85.133]:43271 "EHLO schmee.sfgoth.com")
	by vger.kernel.org with ESMTP id <S267178AbTBUGOD>;
	Fri, 21 Feb 2003 01:14:03 -0500
Date: Thu, 20 Feb 2003 22:24:04 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@locutus.cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [ATM] who 'owns' the skb created by drivers/atm?
Message-ID: <20030220222404.B11525@sfgoth.com>
References: <Pine.LNX.4.44.0302211241070.12797-100000@blackbird.intercode.com.au> <1045808570.22228.2.camel@rth.ninka.net> <20030220221255.A11525@sfgoth.com> <20030220.220035.64239800.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20030220.220035.64239800.davem@redhat.com>; from davem@redhat.com on Thu, Feb 20, 2003 at 10:00:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    Some people seem to be suggesting that we need to zero
>    out ->cb before passing the SKB to netif_rx() but I don't see why
>    that would be neccesary.
> 
> It is true, the whole input mechanism depends upon skb->cb[] being
> clear on new skbs coming in via netif_rx().

Hmmmm.. I guess we've just been getting lucky before in that case - we've
always just left the ATM_SKB() stuff in there.

Chas - I guess you should just do a memset(skb->cb, 0, sizeof(skb->cb))
just before the netif_rx() in {clip,lec,mpc}.c and before the ppp_input()
in pppoatm.c to make sure it's zeroed correctly.

-Mitch
