Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWDOHep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWDOHep (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 03:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWDOHep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 03:34:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45721
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751573AbWDOHeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 03:34:44 -0400
Date: Sat, 15 Apr 2006 00:34:57 -0700 (PDT)
Message-Id: <20060415.003457.103031290.davem@davemloft.net>
To: heiko.carstens@de.ibm.com
Cc: shemminger@osdl.org, jgarzik@pobox.com, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       fpavlic@de.ibm.com, davem@sunset.davemloft.net
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060415072745.GA17011@osiris.boeblingen.de.ibm.com>
References: <20060408100213.GA9412@osiris.boeblingen.de.ibm.com>
	<20060408.031404.111884281.davem@davemloft.net>
	<20060415072745.GA17011@osiris.boeblingen.de.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Sat, 15 Apr 2006 09:27:45 +0200

> Tried to figure out what is causing the delays I experienced when I replaced
> module_init() in af_inet.c with fs_initcall(). After all it turned out that
> synchronize_net() which is basicically nothing else than synchronize_rcu()
> sometimes takes several seconds to complete?! No idea why that is...
> 
> callchain: inet_init() -> inet_register_protosw() -> synchronize_net()

The problem can't be rcu_init(), that gets done very early
in init/main.c

Maybe it's some timer or something else specific to s390?

It could also be that there's perhaps nothing to context
switch to, thus the RCU takes forever to "happen".
