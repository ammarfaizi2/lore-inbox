Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUIBNOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUIBNOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268300AbUIBNOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:14:04 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:59838 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S268299AbUIBNOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:14:00 -0400
Date: Thu, 2 Sep 2004 09:13:59 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: lkml@einar-lueck.de
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Message-ID: <20040902131359.GA11758@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	lkml@einar-lueck.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409021401.42255.elueck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409021401.42255.elueck@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 02:01:42PM +0200, Einar Lueck wrote:
> The complexity of the relevant setups necessitates an easy and 
> requirements-driven configuration and solution approach. The overall 
> concept of setting up a virtual device with a virtual IP adress and 
> assigning this virtual IP adress as a Source VIPA to the devices which should
> allow for a failover is well known from other operating system and expected 
> by relevant enterprise customers.  IP routes and NAT allow to achieve the 
> same effect with the exception mentioned above, but the corresponding 
> configuration overhead is in the opinion of customers having enterprise 
> setups too complex and complicated.  Our overall approach introduces 
> this concept as a facility to address these requirements very clearly. 

The problem here is not the kernel, it's the awful state of network
management in the common initscripts and routing daemons, which have not
evolved far beyond the traditional (static) BSD model of interfaces,
despite the qualitative leap in functionality brought on by Alexey's
contributions to Linux 2.2, netfilter and vlans in 2.4, and now IPsec in 2.6.

While policy routing, traffic control, netfilter, etc., are extremely
powerful separately and in combination, there is no unified mechanism
for managing different aspects of network configuration (addressing,
redundancy, security, QoS, etc.) that cut across each of these kernel
mechanisms.

Several of the routing daemons (Quagga, Bird, etc.) have gotten partway
there, but none is (AFAIK, correct me if I'm wrong) in a state where
one can eliminate all of the other networking-related scripts from
initscripts and just expect the daemon(s) to manage networking.

It seems that effort would be better spent cleaning up userspace, by
looking at use cases, identifying the right abstractions, and reifying
them.  Choose a routing daemon, and turn it into a "Network Mgmt daemon".

Should this be built on top of HAL/D-BUS?  I don't know, will HAL/D-BUS
remain lightweight enough to be used in an embedded router?  I sure
hope so.

Regards,

	Bill Rugolsky
