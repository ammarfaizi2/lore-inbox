Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279570AbRKIHAj>; Fri, 9 Nov 2001 02:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRKIHAU>; Fri, 9 Nov 2001 02:00:20 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:47621 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279570AbRKIHAM>; Fri, 9 Nov 2001 02:00:12 -0500
Message-ID: <3BEB7DA6.BC8793B1@zip.com.au>
Date: Thu, 08 Nov 2001 22:54:30 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "David S. Miller" <davem@redhat.com>, anton@samba.org, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <p731yj8kgvw.fsf@amdsim2.suse.de> <20011109110532.B6822@krispykreme> <20011109064540.A13498@wotan.suse.de> <20011108.220444.95062095.davem@redhat.com>,
		<20011108.220444.95062095.davem@redhat.com>; from davem@redhat.com on Thu, Nov 08, 2001 at 10:04:44PM -0800 <20011109073946.A19373@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Thu, Nov 08, 2001 at 10:04:44PM -0800, David S. Miller wrote:
> >    From: Andi Kleen <ak@suse.de>
> >    Date: Fri, 9 Nov 2001 06:45:40 +0100
> >
> >    Sounds like you need a better hash function instead.
> >
> > Andi, please think about the problem before jumping to conclusions.
> > N_PAGES / N_CHAINS > 1 in his situation.  A better hash function
> > cannot help.
> 
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

I played with that earlier in the year.  Shrinking the hash table
by a factor of eight made no measurable difference to anything on
a Pentium II.  The hash distribution was all over the place though.
Lots of buckets with 1-2 pages, lots with 12-13.

-
