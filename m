Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUCPWHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUCPWHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:07:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:27103 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261741AbUCPWHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:07:01 -0500
Subject: Re: consistent_sync_for_cpu() and friends on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Olaf Hering <olh@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040316104627.47fc1f25.davem@redhat.com>
References: <20040315201616.GA31268@suse.de>
	 <20040315123647.4ce943b7.davem@redhat.com>
	 <1079396621.1967.196.camel@gaston>
	 <20040315164917.6a85966b.davem@redhat.com>
	 <1079400967.2302.213.camel@gaston>
	 <20040316104627.47fc1f25.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1079474087.920.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 08:54:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> See, the direction really doesn't matter for the sync ops.

Well, the direction makes the difference between a flush and an
invalidation ;)

> If you flush the cpu caches at MAP time, and your PCI controller doesn't
> have DMA caching or something like that, then sync for CPU can always be
> a nop.  You will have always previously flushed the cpu caches before
> giving the buffer back to the device, either via MAP or sync for device
> calls.
> 
> So basically, make MAP and sync for device writeback flush the cpu caches.

No, flush on TO_DEVICE and BIDIRECTIONAL, invalidate on FROM_DEVICE,
it's less expensive to invalidate than flush in that case, since we
don't care about writing to real memory whatever junk the cache
contained for this area.

Ben.



