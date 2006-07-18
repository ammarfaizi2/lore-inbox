Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWGRMlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWGRMlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGRMlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:41:18 -0400
Received: from mailhub.znyx.com ([208.2.156.141]:65034 "EHLO mailhub.znyx.com")
	by vger.kernel.org with ESMTP id S1750880AbWGRMlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:41:17 -0400
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       netdev@vger.kernel.org
In-Reply-To: <1153218477.3038.46.camel@laptopd505.fenrus.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091958.414414000@sous-sol.org>
	 <1153218477.3038.46.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: unknown
Date: Tue, 18 Jul 2006 08:39:39 -0400
Message-Id: <1153226379.5283.51.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-18-07 at 12:27 +0200, Arjan van de Ven wrote:

> 
> Hmmm maybe it's me, but something bugs me if a NIC driver is going to
> send IP level ARP packets... that just feels very very wrong and is a
> blatant layering violation.... 

It is but the bonding driver has been setting precedence for years now
on sending ARPs from a driver;->
It does make a lot of sense to put it in user space. More interesting
policies may include sending more than just ARPs and once you hard-code
in the kernel you loose that flexibility.

> shouldn't the ifup/ifconfig scripts just
> be fixed instead if this is critical behavior?
> 

I dont think the ifup/ifconfig provide operational status (i.e link
up/down) - or do they? If they can be made to invoke scripts in such
a case then we are set.

Note: you will get netlink events when devices are created or devices
change their admin (via ifconfig) or operational (link down/up) status.
[Try running "ip monitor" to see]

One could write a little daemon that reacts to these specific events.
The problem has been some people claiming that daemons are a bad idea
from a usability perspective. Patrick has mentioned he may be working on
a daemon in user space that does exactly that. The other alternative is
to do the udev thing and have the kernel invoke a script whenever an
event of interest happens.

cheers,
jamal

