Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbVKRSkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbVKRSkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVKRSkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:40:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:12511 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161080AbVKRSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:40:36 -0500
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: hugh@veritas.com, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051117.155230.25121238.davem@davemloft.net>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com>
	 <20051117.155230.25121238.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Nov 2005 19:12:10 +0000
Message-Id: <1132341130.25914.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-17 at 15:52 -0800, David S. Miller wrote:
> The cases I've seen, and am aware of, I documented in a previous
> mail and those involve MAP_PRIVATE maps of /dev/mem or other
> similar fixed page mapping devices.
> 
> Which case truly needs COW faults on VM_RESERVED memory which
> isn't an application bug of some sort?

lrmi, X, vbetool, ...

In general these applications want to operate with a copy of the real
bios data mapped into the system. It might be possible to read some of
the data objects (eg the 0x400 page) but it is not possible to read the
BIOS ROM area as it may contain paged segments.

I suspect a read only bios map and an r/w read copy of the bios config
pages might work but the new behaviour is a serious regression breaking
legitimate code so it is problematic when it occurs without a years
warning in the middle of a fairly stable sequence of kernels.

