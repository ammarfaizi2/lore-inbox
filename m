Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbTISFxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 01:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTISFxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 01:53:09 -0400
Received: from ns.suse.de ([195.135.220.2]:35538 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261329AbTISFxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 01:53:05 -0400
Date: Fri, 19 Sep 2003 07:53:04 +0200
From: Andi Kleen <ak@suse.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Andi Kleen <ak@suse.de>, Grant Grundler <iod00d@hp.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030919055304.GE16928@wotan.suse.de>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au> <20030919043847.GA2996@cup.hp.com> <20030919044315.GC7666@wotan.suse.de> <16234.36238.848366.753588@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16234.36238.848366.753588@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is what I changed:
> 
> ===== drivers/net/ns83820.c 1.19 vs edited =====
> --- 1.19/drivers/net/ns83820.c  Thu Jun  5 13:50:00 2003
> +++ edited/drivers/net/ns83820.c        Fri Sep 19 13:49:23 2003
> @@ -567,7 +567,7 @@
>                 res = (long)skb->tail & 0xf;
>                 res = 0x10 - res;
>                 res &= 0xf;
> -               skb_reserve(skb, res);
> +               skb_reserve(skb, res+2);

You must add the 2 bytes in dev_alloc_skb() too.

(it also add 16 bytes by itself, but they are used for other things)

-Andi
