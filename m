Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWDHKOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWDHKOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 06:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWDHKOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 06:14:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50372
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964835AbWDHKOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 06:14:10 -0400
Date: Sat, 08 Apr 2006 03:14:04 -0700 (PDT)
Message-Id: <20060408.031404.111884281.davem@davemloft.net>
To: heiko.carstens@de.ibm.com
Cc: shemminger@osdl.org, jgarzik@pobox.com, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       fpavlic@de.ibm.com, davem@sunset.davemloft.net
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060408100213.GA9412@osiris.boeblingen.de.ibm.com>
References: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com>
	<20060407074627.2f525b2e@localhost.localdomain>
	<20060408100213.GA9412@osiris.boeblingen.de.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Sat, 8 Apr 2006 12:02:13 +0200

> Ok, so the problem seems to be that inet_init gets called after qeth_init.
> Looking at the top level Makefile this seems to be true for all network
> drivers in drivers/net/ and drivers/s390/net/ since we have
> 
> vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
> 
> The patch below works for me... I guess there must be a better way to make
> sure that any networking driver's initcall is made before inet_init?
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

We could make inet_init() a subsystem init but I vaguely recall
that we were doing that at one point and it broke things for
some reason.

Perhaps fs_initcall() would work better.  Or if that causes
problems we could create a net_initcall() that sits between
fs_initcall() and device_initcall().

Or any other ideas?
