Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279499AbRKIGkO>; Fri, 9 Nov 2001 01:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279506AbRKIGkE>; Fri, 9 Nov 2001 01:40:04 -0500
Received: from ns.suse.de ([213.95.15.193]:7692 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279499AbRKIGjr>;
	Fri, 9 Nov 2001 01:39:47 -0500
Date: Fri, 9 Nov 2001 07:39:46 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011109073946.A19373@wotan.suse.de>
In-Reply-To: <p731yj8kgvw.fsf@amdsim2.suse.de> <20011109110532.B6822@krispykreme> <20011109064540.A13498@wotan.suse.de> <20011108.220444.95062095.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011108.220444.95062095.davem@redhat.com>; from davem@redhat.com on Thu, Nov 08, 2001 at 10:04:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 10:04:44PM -0800, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: Fri, 9 Nov 2001 06:45:40 +0100
>    
>    Sounds like you need a better hash function instead.
>    
> Andi, please think about the problem before jumping to conclusions.
> N_PAGES / N_CHAINS > 1 in his situation.  A better hash function
> cannot help.

I'm assuming that walking on average 5-10 pages on a lookup is not too big a 
deal, especially when you use prefetch for the list walk. It is a tradeoff
between a big hash table thrashing your cache and a smaller hash table that
can be cached but has on average >1 entries/buckets. At some point the the 
smaller hash table wins, assuming the hash function is evenly distributed.

It would only get bad if the average chain length would become much bigger.

Before jumping to real conclusions it would be interesting to gather
some statistics on Anton's machine, but I suspect he just has an very
unevenly populated table.

-Andi
