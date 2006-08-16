Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWHPUql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWHPUql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWHPUql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:46:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15531
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750914AbWHPUqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:46:40 -0400
Date: Wed, 16 Aug 2006 13:46:40 -0700 (PDT)
Message-Id: <20060816.134640.115912460.davem@davemloft.net>
To: jeff@garzik.org
Cc: linas@austin.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, jklewis@us.ibm.com, arnd@arndb.de,
       Jens.Osterkamp@de.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
From: David Miller <davem@davemloft.net>
In-Reply-To: <44E38157.4070805@garzik.org>
References: <44E34825.2020105@garzik.org>
	<20060816203043.GJ20551@austin.ibm.com>
	<44E38157.4070805@garzik.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Wed, 16 Aug 2006 16:34:31 -0400

> Linas Vepstas wrote:
> > I was under the impression that NAPI was for the receive side only.
> 
> That depends on the driver implementation.

What Jeff is trying to say is that TX reclaim can occur in
the NAPI poll routine, and in fact this is what the vast
majority of NAPI drivers do.

It also makes the locking simpler.

In practice, the best thing seems to be to put both RX and TX
work into ->poll() and have a very mild hw interrupt mitigation
setting programmed into the chip.

I'm not familiar with the spidernet TX side interrupt capabilities
so I can't say whether that is something that can be directly
implied.  In fact, I get the impression that spidernet is limited
in some way and that's where all the strange approaches are coming
from :)
