Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVLMNJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVLMNJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLMNJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:09:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61094 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932110AbVLMNJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:09:55 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <200512131347.30464.oliver@neukum.org>
References: <439E122E.3080902@yahoo.com.au> <20051213101300.GA2178@elte.hu>
	 <20051213103420.GA6681@elte.hu>  <200512131347.30464.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 13:09:31 +0000
Message-Id: <1134479371.11732.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-13 at 13:47 +0100, Oliver Neukum wrote:
> > spinlock to do the cmpxchg. This means that there wont be one single 
> > global spinlock to emulate cmpxchg, but the mutex's own spinlock can be 
> > used for it.
> 
> Can't you use the pointer as a hash input?

Some platforms already do this for certain sets of operations like
atomic_t. The downside however is that you no longer control the lock
contention or cache line bouncing. It becomes a question of luck rather
than science as to how well it scales.

