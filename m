Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317687AbSFLMDU>; Wed, 12 Jun 2002 08:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317688AbSFLMDT>; Wed, 12 Jun 2002 08:03:19 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:13744 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317687AbSFLMDS> convert rfc822-to-8bit; Wed, 12 Jun 2002 08:03:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roland Dreier <roland@topspin.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Wed, 12 Jun 2002 14:02:53 +0200
User-Agent: KMail/1.4.1
Cc: <wjhun@ayrnetworks.com>, <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <52y9dl65aa.fsf@topspin.com> <20020611172920.18340@smtp.adsl.oleane.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206121402.53622.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For your example, I don't buy it. You could well design the USB urb
> allocation in such a way that they are passed down the controller of
> a given device.

Urbs are not the problem. An urb abstractly speaking is just a description
of io. It does not contain a buffer, just a pointer to it.

However many drivers allocate some of these buffers together with their
device descriptors, which would, if a special allocator must be used,
become impossible.
Usbcore could allocate bounce buffers, but performance would suck.

If I understand both Davids correctly this is the solution.
Buffers for dma must be allocated seperately using a special allocation
function which is given the device so it can allocate correctly.
David B wants a bus specific pointer to a function in the generic
driver structure, right ?

	Regards
		Oliver

