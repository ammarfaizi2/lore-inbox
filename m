Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310192AbSB1W6M>; Thu, 28 Feb 2002 17:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310193AbSB1W4Y>; Thu, 28 Feb 2002 17:56:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17298 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310189AbSB1Wxh>;
	Thu, 28 Feb 2002 17:53:37 -0500
Date: Thu, 28 Feb 2002 14:51:17 -0800 (PST)
Message-Id: <20020228.145117.101862422.davem@redhat.com>
To: christopher.leech@intel.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: hardware VLAN acceleration
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C144E@orsmsx118.jf.intel.com>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C144E@orsmsx118.jf.intel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Leech, Christopher" <christopher.leech@intel.com>
   Date: Thu, 28 Feb 2002 13:47:25 -0800

   Is vlan_rx_kill_vid only there to ensure locking between vlan_hwaccel_rx and
   unregister_802_1Q_vlan_dev?  If so, could this be handled outside of the
   driver?
   
It is there because the VLAN layer has no buisness knowing how to lock
out receive interrupt processing in your driver.

The Acenic driver, for example, uses no SMP locking at all and runs
it's RX interrupts %100 lockless requiring a global "cli()" in order
to implement vlan_rx_kill_vid().

   Also, when a vlan dev is unregistered, does the driver need to know that the
   vlan_group passed in to vlan_rx_register is no longer valid?
   
The group is still valid, groups are never destroyed by the VLAN layer
once they are created.

Franks a lot,
David S. Miller
davem@redhat.com
