Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280457AbRKJE65>; Fri, 9 Nov 2001 23:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280460AbRKJE6r>; Fri, 9 Nov 2001 23:58:47 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:16147 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280457AbRKJE6h>;
	Fri, 9 Nov 2001 23:58:37 -0500
Date: Sat, 10 Nov 2001 15:56:03 +1100
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011110155603.B767@krispykreme>
In-Reply-To: <p731yj8kgvw.fsf@amdsim2.suse.de> <20011109110532.B6822@krispykreme> <20011109064540.A13498@wotan.suse.de> <20011108.220444.95062095.davem@redhat.com> <20011109073946.A19373@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011109073946.A19373@wotan.suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> I'm assuming that walking on average 5-10 pages on a lookup is not too big a 
> deal, especially when you use prefetch for the list walk. It is a tradeoff
> between a big hash table thrashing your cache and a smaller hash table that
> can be cached but has on average >1 entries/buckets. At some point the the 
> smaller hash table wins, assuming the hash function is evenly distributed.
> 
> It would only get bad if the average chain length would become much bigger.
> 
> Before jumping to real conclusions it would be interesting to gather
> some statistics on Anton's machine, but I suspect he just has an very
> unevenly populated table.

You can find the raw data here:

http://samba.org/~anton/linux/pagecache/pagecache_data_gfp.gz
http://samba.org/~anton/linux/pagecache/pagecache_data_vmalloc.gz

You can see the average depth of the get_free_page hash is way too deep.
I agree there are a lot of pagecache pages (17GB in the gfp test and 21GB
in the vmalloc test), but we have to make use of the 32GB of RAM :)

I did some experimentation with prefetch and I dont think it will gain
you anything here. We need to issue the prefetch many cycles before
using the data which we cannot do when walking the chain.

Anton
