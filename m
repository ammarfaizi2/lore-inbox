Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUCKCvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 21:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbUCKCvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 21:51:08 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:6784 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S261202AbUCKCvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 21:51:04 -0500
Date: Wed, 10 Mar 2004 18:48:16 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jt@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040311024816.GC3738@jm.kir.nu>
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com> <404F5097.4040406@pobox.com> <20040310175200.GA9531@bougret.hpl.hp.com> <404F5744.1040201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F5744.1040201@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 12:58:28PM -0500, Jeff Garzik wrote:

> So here is my suggested plan:
> * I merge prism54 upstream
> * I create wireless-2.6 queue
> * somebody (you, Jouni(sp?)) submits HostAP to me
> * I merge HostAP

Sounds good to me. I have the Kconfig/Makefile(etc.) patches ready and
the current CVS snapshot of Host AP driver supports 2.6.x kernel
versions, so in theory it is ready to be submitted.

When this topic came up some time ago, I got one concrete comment about
needed changes before the merge (I think it was from you) and that was
to replace the internal encryption algorithms with crypto API ones. I'm
currently in the process of doing this and submitting needed changes for
crypto API. WEP and TKIP have the needed parts as crypto API components
(RC4 is already in kernel tree, Michael MIC patch is pending). CCMP
requires some work (new encryption mode, counter with CBC-MAC, but AES
is already in crypto API).

What would be the preferred order for the HostAP submission? I'm
currently doing the crypto changes in the Host AP CVS repository, but I
can do this also in another repository since you mentioned a new
non-mainline queue for wireless-2.6. I have also some other cleanup
things in my to do list (like getting rid of 2.4 and old wireless
extensions compatibility code, because this would not be needed in the
kernel tree anymore). Again, this is currently proceeding in my CVS
repository, but it can also be done elsewhere, if that is desired.

I'm going to be at the IEEE 802.11 meeting for the next week which is
probably going to take more or less all of my time, but I should be able
to allocate more time after that. If people are interested in reviewing
the current Host AP code from the viewpoint of what would need to happen
before it can be merged into the kernel tree, the latest version is
available as a snapshot from my CVS tree (pserver or tarball) at
http://hostap.epitest.fi/. The current version is almost 20k lines, so
there is certainly quite a bit of code to review. I hope to get this to
about 15k lines, though, with the crypto API and backwards
compatibility cleanup.

-- 
Jouni Malinen                                            PGP id EFC895FA
