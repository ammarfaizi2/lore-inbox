Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270583AbRHIUsD>; Thu, 9 Aug 2001 16:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270590AbRHIUrx>; Thu, 9 Aug 2001 16:47:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34322 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270583AbRHIUrk>; Thu, 9 Aug 2001 16:47:40 -0400
Date: Thu, 9 Aug 2001 17:47:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <20010809125033.E1200@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.33L.0108091740470.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Ingo Oeser wrote:

> Are there any races I have to consider?

Well, this IS a big issue against swap over network.

Swap over network is inherently prone to deadlock
situations, due to the following three problems:

1) we swap pages out when we are close to running
   out of free memory
2) to write pages out over the network, we need to
   allocate space to assemble network packets
3) we need to have memory to receive the ACKs on
   the packets we sent out

The only real solution to this would be memory
reservations so we know this memory won't be used
for other purposes.

What we can do right now is be careful about how
many writeouts over the network we do at the same
time, but that will still get us killed in case of
a ping flood ;)

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

