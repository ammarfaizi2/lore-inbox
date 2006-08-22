Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWHVAcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWHVAcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWHVAcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:32:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64657
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751336AbWHVAcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:32:10 -0400
Date: Mon, 21 Aug 2006 17:32:25 -0700 (PDT)
Message-Id: <20060821.173225.68047257.davem@davemloft.net>
To: rdreier@cisco.com
Cc: linas@austin.ibm.com, arnd@arndb.de, shemminger@osdl.org, akpm@osdl.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens.Osterkamp@de.ibm.com, jgarzik@pobox.com
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
From: David Miller <davem@davemloft.net>
In-Reply-To: <adaac5x3966.fsf@cisco.com>
References: <20060821235244.GJ5427@austin.ibm.com>
	<20060821.165616.107936004.davem@davemloft.net>
	<adaac5x3966.fsf@cisco.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 21 Aug 2006 17:29:05 -0700

> This is a digression from spidernet, but what if a device is able to
> generate separate MSIs for TX and RX?  Some people from IBM have
> suggested that it is beneficial for throughput to handle TX work and
> RX work for IP-over-InfiniBand in parallel on separate CPUs, and
> handling everything through the ->poll() method would defeat this.

The TX work is so incredibly cheap, relatively speaking, compared
to the full input packet processing path that the RX side runs
that I see no real benefit.

In fact, you might even get better locality due to the way the
locking can be performed if TX reclaim runs inside of ->poll()
