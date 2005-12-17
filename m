Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVLQAlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVLQAlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVLQAlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:41:55 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:6528 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964901AbVLQAly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:41:54 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Fri, 16 Dec 2005 16:41:49 -0800
User-Agent: KMail/1.9
Cc: torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <Pine.LNX.4.64.0512160829180.3060@g5.osdl.org> <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org> <20051216.145306.132052494.davem@davemloft.net>
In-Reply-To: <20051216.145306.132052494.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161641.49571.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 16, 2005 2:53 pm, David S. Miller wrote:
> When the write comes along, the next transaction occurs to kick it
> out the other cpu(s) caches and then the local line is placed into
> Owned state.
>
> I'll have to add "put write prefetch in CAS sequences" onto my sparc64
> TODO list :-)

Note that under contention prefetching with a write bias can cause a lot 
more cache line bouncing than a regular load into shared state (assuming 
you do a load and test before you try the CAS).  We actually saw this on 
large Altix machines, 
http://lia64.bkbits.net:8080/to-linus-2.5/cset%403f2082b3xCvMG9OSeNu3aWhoe6jnOg?nav=index.html|
src/.|src/include|src/include/asm-ia64|
related/include/asm-ia64/spinlock.h fixed things up for us.

Jesse
