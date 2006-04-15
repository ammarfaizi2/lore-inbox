Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWDOXBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWDOXBA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWDOXBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:01:00 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:52547 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932511AbWDOXA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:00:59 -0400
Date: Sun, 16 Apr 2006 01:00:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: shemminger@osdl.org, jgarzik@pobox.com, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       fpavlic@de.ibm.com, davem@sunset.davemloft.net
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
Message-ID: <20060415230049.GA26151@osiris.ibm.com>
References: <20060408100213.GA9412@osiris.boeblingen.de.ibm.com> <20060408.031404.111884281.davem@davemloft.net> <20060415072745.GA17011@osiris.boeblingen.de.ibm.com> <20060415.003457.103031290.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415.003457.103031290.davem@davemloft.net>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > callchain: inet_init() -> inet_register_protosw() -> synchronize_net()
> 
> The problem can't be rcu_init(), that gets done very early
> in init/main.c
> 
> Maybe it's some timer or something else specific to s390?
> 
> It could also be that there's perhaps nothing to context
> switch to, thus the RCU takes forever to "happen".

Changing inet_init to fs_initcall() moves it way up the chain...
There are quite a few __initcall()s (way is this mapped to
device_initcall()?) and module_init()s in places where I would
never have expected them (e.g. kernel/).
After all the dependencies are anything but obvious to me. The
only obvious solution which fixes my problem would be to convert
qeth's module_init() to late_initcall().
