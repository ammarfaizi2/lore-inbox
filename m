Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVLMOEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVLMOEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVLMOEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:04:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:31406 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932263AbVLMOEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:04:30 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Oliver Neukum <oliver@neukum.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20051213131312.GJ9286@parisc-linux.org>
References: <439E122E.3080902@yahoo.com.au> <20051213101300.GA2178@elte.hu>
	 <20051213103420.GA6681@elte.hu> <200512131347.30464.oliver@neukum.org>
	 <1134479371.11732.19.camel@localhost.localdomain>
	 <20051213131312.GJ9286@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 14:04:06 +0000
Message-Id: <1134482647.11732.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-13 at 06:13 -0700, Matthew Wilcox wrote:
> > Some platforms already do this for certain sets of operations like
> > atomic_t. The downside however is that you no longer control the lock
> > contention or cache line bouncing. It becomes a question of luck rather
> > than science as to how well it scales.
> 
> s/luck/statistics/

Unfortunately not always. Statistical probability models generally
assume that samples are independent, as does just growing the hash
table. If there are correlations then how those correlations and the
hash function interact isn't simple statistics so growing the hash might
not work as well as would be hoped.

A second problem with the hash is it makes priority inversions
entertaining and unpredictable when using Ingo's -rt work. That isn't a
big problem with the atomic_t stuff in the parisc tree because atomic_t
is effectively the top of the lock ordering for the system.

Growing the hash while it may improve the behaviour isn't going to work
as well as embedding the lock in the object.

Alan

