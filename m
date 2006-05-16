Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWEPAIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWEPAIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWEPAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:08:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53900
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750860AbWEPAIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:08:42 -0400
Date: Mon, 15 May 2006 17:08:35 -0700 (PDT)
Message-Id: <20060515.170835.126804002.davem@davemloft.net>
To: shemminger@osdl.org
Cc: ranjitm@google.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060515164101.054afa29@localhost.localdomain>
References: <20060515.142645.94689626.davem@davemloft.net>
	<Pine.LNX.4.56.0605151602330.29636@ranjit.corp.google.com>
	<20060515164101.054afa29@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Mon, 15 May 2006 16:41:01 -0700

> kfree_skb(NULL) is legal so the conditional here is unneeded.
> 
> But the increased calls to kfree_skb(NULL) would probably bring the
> "unlikely()" hordes descending on kfree_skb, so maybe:

And unfortunately as Patrick McHardy states, we can't use
this trick here because things like tc actions can do stuff
like pskb_expand_head() which cannot handle shared SKBs.

We need another solution to this problem, because cloning an
extra SKB is just rediculious overhead so isn't something we
can seriously consider to solve this problem.

Another option is to say this anomaly doesn't matter enough
to justify the complexity we're looking at here just to fix
this glitch.

Other implementation possibility suggestions welcome :-)
