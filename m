Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWARXHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWARXHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWARXHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:07:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38823 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030473AbWARXHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:07:11 -0500
Subject: Re: [PATCH 1/8] Notifier chain update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: stern@rowland.harvard.edu, bcrl@kvack.org, akpm@osdl.org,
       sekharan@us.ibm.com, kaos@sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060118.140056.39962680.davem@davemloft.net>
References: <20060118214204.GG16285@kvack.org>
	 <Pine.LNX.4.44L0.0601181656430.4974-100000@iolanthe.rowland.org>
	 <20060118.140056.39962680.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 23:06:25 +0000
Message-Id: <1137625585.1760.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-18 at 14:00 -0800, David S. Miller wrote:
> For example, IPV6 addresses can get added/removed from a device
> in response to packets, and these operations trigger the
> inet6addr_chain notifier in net/ipv6/addrconf.c
> 
> So sleeping in a notifier is indeed illegal.

On the specific example yet. Notifiers get used for many things and
there has never been a rule about them not sleeping. There are lots of
cases where notifiers sleeping make sense including its early use in
power manglement.

Notifiers should not have locks. That was intentional in the original
implementation. You want locks, you implement them in the API *using*
the notifier, because its odds on you actually need to hold that lock
for other things too.

Alan
