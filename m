Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUGaKTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUGaKTq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 06:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267937AbUGaKTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 06:19:46 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:46087 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267934AbUGaKTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 06:19:44 -0400
Date: Sat, 31 Jul 2004 12:11:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, greearb@candelatech.com,
       akpm@osdl.org, alan@redhat.com, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731101152.GG1545@alpha.home.local>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410B67B1.4080906@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Sat, Jul 31, 2004 at 05:34:41AM -0400, Jeff Garzik wrote:
> Willy Tarreau wrote:
> >  - many (all ?) other drivers already have an MTU parameter, and many
> 
> s/many/almost none/

Ok, sorry, I've just checked, they are 6. But I incidentely used the feature
on 2 of them (dl2k and starfire). But more drivers still have the
'static int mtu=1500' preceeded by a comment stating "allow the user to change
the mtu". Why is it not a #define then, if nobody can change it anymore ?

> For VLAN support you definitely want to let the user increase the size 
> above 1500, and for that you need ->change_mtu

I agree, but my point was that adding MODULE_PARM was only a one liner and
would have done the job too. But since everyone prefers a change_mtu(), I'll
do it.

Jeff, do you know the absolute hardware limit on the tulip ? I've seen the
limitation to PKT_BUF_SZ (1536), but I don't know for example if the
hardware stores the FCS in the buffer or not, nor if the IP headers risk
being aligned or not (which would consume 2 more bytes).
Or does 1536 - 14 (ethernet) - 2 (iphdr alignment) - 4 (FCS) = 1516 seem a
reasonable conservative higher bound ?

Cheers,
Willy
