Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262627AbSJBWHC>; Wed, 2 Oct 2002 18:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262673AbSJBWHC>; Wed, 2 Oct 2002 18:07:02 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:49643 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262627AbSJBWHA>;
	Wed, 2 Oct 2002 18:07:00 -0400
Date: Thu, 3 Oct 2002 00:12:28 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cli()/sti() fix for drivers/net/depca.c
Message-ID: <20021003001228.A18629@fafner.intra.cogenit.fr>
References: <200210022005.g92K5Fp31816@Port.imtp.ilyichevsk.odessa.ua> <20021002224059.A18518@fafner.intra.cogenit.fr> <200210022133.g92LX0p32156@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210022133.g92LX0p32156@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Thu, Oct 03, 2002 at 12:26:53AM -0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> :
[...]
> Ho to do it properly? Make a copy on stack under lock, release lock,
> proceed with copy_to_user? That's 88 bytes at least...

Please see ETHTOOL_GSTATS usage in drivers/net/8139cp.c.

> > - on SMP, pktStat can be updated while the copy progresses, see depca_rx().
> 
> Should I place these pktStat updates under lp->lock?

You may.

depca_rx() looks strange:
buf = skb_put(skb, len);
[...]
netif_rx(skb);
[...]
if (buf[0] & ...)

-- 
Ueimor
