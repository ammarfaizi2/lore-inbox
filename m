Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbTFEMko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbTFEMko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:40:44 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:7627 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264659AbTFEMkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:40:43 -0400
Subject: Re: /proc/bus/pci
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, bcollins@debian.org,
       wli@holomorphy.com, tom_gall@vnet.ibm.com,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <1054814759.22103.6114.camel@cube>
References: <Pine.LNX.4.44.0306042117440.2761-100000@home.transmeta.com>
	 <1054814759.22103.6114.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054816995.1000.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 14:43:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So sysfs then has:
> 
> devices/pci2/02:0b.0 -> ../hose0/bus2/dev11/fn0
> devices/hose0/bus2/dev11/fn0/config-space
> devices/hose0/bus2/dev11/fn0/bar0
> devices/hose0/bus2/dev11/fn0/bar1
> devices/hose0/bus2/dev11/fn0/bar2
> devices/hose0/bus2/dev11/fn0/class
> devices/hose0/bus2/dev11/fn0/power
> devices/hose0/bus2/dev11/fn0/subsystem_vendor
> devices/hose0/bus2/dev11/fn0/and-so-on

The first entry (devices/pci2/....) is wrong imho.

With multiple domains, we can have several busses with the same bus number,
one in each domain. So it's a matter of taking the current set of pciN
entries and moving them below a "pci-domain" entry (or hose, or whatever
Linus prefers).

Also, the node name for individual PCI devices must include the domain
number, the current bus:dev.fn notation isn't enough, that will break
things like /sys/bus/pci/devices when you have several identical bus/devfn
pairs on different domains

Ben.

