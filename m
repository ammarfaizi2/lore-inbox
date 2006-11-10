Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946096AbWKJJql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946096AbWKJJql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946221AbWKJJql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:46:41 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:22920 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1946096AbWKJJqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:46:40 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64: Make the NUMA hash function nodemap allocation dynamic and remove NODEMAPSIZE
Date: Fri, 10 Nov 2006 10:46:49 +0100
User-Agent: KMail/1.9.5
Cc: Amul Shah <amul.shah@unisys.com>, LKML <linux-kernel@vger.kernel.org>
References: <1163029076.3553.36.camel@ustr-linux-shaha1.unisys.com> <200611100748.30889.ak@suse.de> <200611101043.14749.dada1@cosmosbay.com>
In-Reply-To: <200611101043.14749.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101046.49806.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 10:43, Eric Dumazet wrote:
>
> Therefore I suggest to use a structure like that :
>
> struct memnode {
>  	int shift;
> 	unsigned int mapsize; /* no need to use 8 bytes here */
> 	u8 *map;
> 	u8 embedded_map[64-8]; /* total size = 64 bytes */
>  } ____cacheline_aligned;
>

Arg... [64 - 16] sorry


> and make memnode.map point to memnode.embedded_map if mapsize <= 56 ?

mapsize <= 48

>
> This way, most AMD64 dual/quad processors wont waste a full PAGE to store
> few bytes in it, and should use only one cache line.
>
> Thank you
>
> Eric
>
