Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752498AbWCQBWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbWCQBWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWCQBWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:22:30 -0500
Received: from [81.2.110.250] ([81.2.110.250]:20441 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1752498AbWCQBW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:22:28 -0500
Subject: Re: Remapping pages mapped to userspace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <adapsklnaby.fsf@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	 <adad5gmne20.fsf_-_@cisco.com>
	 <1142553361.15045.19.camel@serpentine.pathscale.com>
	 <adapsklnaby.fsf@cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 01:28:28 +0000
Message-Id: <1142558909.23236.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-16 at 17:12 -0800, Roland Dreier wrote:
> Oh yeah... but getting rid of the mapping so userspace gets a segfault
> might be a good idea too.  However, leaving the old PCI mapping there
> seems rather risky to me: I think it's entirely possible that accesses
> to that area after the device is gone could trigger machine checks or
> worse.

Not really. After all the hot remove can race an actual mmio cycle so
you can't close that window to nothing. In other words if it does make
the PCI bridge burp at you - well hotplug has to handle it.

That means on the positive side that all you need to do is refcount
properly and destroy the PCI device when you have finished with it. If a
mapping continues to exist then fine, because the device is still
logically there. If the device is logically there then the resources
have not been unmapped. If the resources have not been unmapped they are
not free for allocation to another device.

Config space looks more problematic but memory maps of PCI space appear
to be ok.

Alan

