Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266428AbTGERHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 13:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbTGERHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 13:07:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:49569 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266444AbTGERGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 13:06:51 -0400
Date: Sat, 5 Jul 2003 10:20:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
cc: Christoph Hellwig <hch@infradead.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@osdl.org>, <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoloop
In-Reply-To: <3F068F49.1883BE0D@pp.inet.fi>
Message-ID: <Pine.LNX.4.44.0307051018280.5900-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jul 2003, Jari Ruusu wrote:
>
> This tests only low level cipher functions aes_encrypt() and aes_decrypt()
> from linux-2.5.74/crypto/aes.c with all CryptoAPI overhead removed. In real
> use, including CryptoAPI overhead, these numbers should be a little bit
> smaller.
> 
> key length 128 bits, encrypt speed 68.5 Mbits/sec
...

Note that the issue that started the discussion is somewhat different: the 
performance impact of having to map the pages with sleeping kmap's because 
of the old virtual-address-pointer interfaces.

That won't even show up on most setups, but it can be rather nasty on big 
boxes with lots of ram and several CPU's. Do we care? Possibly not, but I 
think from a design standpoint it would be better to not have the problem.

			Linus

