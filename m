Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130609AbQKGHQU>; Tue, 7 Nov 2000 02:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQKGHQK>; Tue, 7 Nov 2000 02:16:10 -0500
Received: from Cantor.suse.de ([194.112.123.193]:54026 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130459AbQKGHQG>;
	Tue, 7 Nov 2000 02:16:06 -0500
Date: Tue, 7 Nov 2000 08:16:04 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, jordy@napster.com, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
Message-ID: <20001107081604.A2410@gruyere.muc.suse.de>
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <20001107080342.A2159@gruyere.muc.suse.de> <200011070659.WAA02448@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011070659.WAA02448@pizda.ninka.net>; from davem@redhat.com on Mon, Nov 06, 2000 at 10:59:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 10:59:04PM -0800, David S. Miller wrote:
>    Date: Tue, 7 Nov 2000 08:03:42 +0100
>    From: Andi Kleen <ak@suse.de>
> 
>    It looks very like to me like a poster child for the non timestamp
>    RTT update problem I just described on netdev. Linux always
>    retransmits too early and there is never a better RTT estimate
>    which could fix it.
> 
> I thought so too, _BUT_ see my analysis of the Linux side vs.
> Win98 side logs, they don't match up and therefore something
> is mangling the packets in the middle.  The TCP sequence numbers are
> being changed!

Hmm. One of these weird bandwidth limiters again? 

> 
> Also, if your theory were true then 2.2.x would be affected
> by it as well.

2.2 does not save RTTs between connections. The RTT is lower than 2.2's
initial 3s RTT, so 2.2 would never see it. One useful experiment would 
be to flush the routing cache between attempts or turn off the tcp metrics 
saving (why don't we have a sysctl for that btw?) 
 
-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
