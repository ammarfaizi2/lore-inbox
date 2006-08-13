Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWHMXtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWHMXtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWHMXtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 19:49:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64447
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751730AbWHMXtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 19:49:12 -0400
Date: Sun, 13 Aug 2006 16:49:34 -0700 (PDT)
Message-Id: <20060813.164934.00081381.davem@davemloft.net>
To: phillips@google.com
Cc: a.p.zijlstra@chello.nl, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: David Miller <davem@davemloft.net>
In-Reply-To: <44DF9817.8070509@google.com>
References: <1155132440.12225.70.camel@twins>
	<20060809.165846.107940575.davem@davemloft.net>
	<44DF9817.8070509@google.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Phillips <phillips@google.com>
Date: Sun, 13 Aug 2006 14:22:31 -0700

> David Miller wrote:
> > The reason is that there is no refcounting performed on these devices
> > when they are attached to the skb, for performance reasons, and thus
> > the device can be downed, the module for it removed, etc. long before
> > the skb is freed up.
> 
> The virtual block device can refcount the network device on virtual
> device create and un-refcount on virtual device delete.

What if the packet is originally received on the device in question,
and then gets redirected to another device by a packet scheduler
traffic classifier action or a netfilter rule?

It is necessary to handle the case where the device changes on the
skb, and the skb gets freed up in a context and assosciation different
from when the skb was allocated (for example, different from the
device attached to the virtual block device).
