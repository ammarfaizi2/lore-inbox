Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135795AbRAGF2R>; Sun, 7 Jan 2001 00:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135807AbRAGF2H>; Sun, 7 Jan 2001 00:28:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:58378 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135795AbRAGF1v>;
	Sun, 7 Jan 2001 00:27:51 -0500
Date: Sun, 7 Jan 2001 06:27:44 +0100
From: Andi Kleen <ak@suse.de>
To: Ben Greear <greearb@candelatech.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010107062744.A15198@gruyere.muc.suse.de>
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de> <3A580B31.7998C783@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A580B31.7998C783@candelatech.com>; from greearb@candelatech.com on Sat, Jan 06, 2001 at 11:22:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 11:22:41PM -0700, Ben Greear wrote:
> At the time I was doing this, I downloaded the latest nettools version.
> The hashing made a very noticable difference on 4000 interfaces, but
> I haven't run any real solid benchmarkings at other levels.  Can
> you tell me some distinguishing mark (version?) on ifconfig that I
> can look for?

Just get the latest release.

> 
> I'm willing to run such benchmarks, but what would make a good benchmark,
> other than ifconfig -a?

ifconfig -a is fine IMHO. Everything else I know is just a single pass through
the lists (which even at 4000 is not very significant) 

> Suppose I bind a raw socket to device vlan4001 (ie I have 4k in the list
> before that one!!).  Currently, that means a linear search on all devices,
> right?  In that extreme example, I would expect the hash to be very
> useful.

Nope, it doesn't. Raw binding works via IP addresses, and the IP address resolution
works via the routing table, which is extensively hashed.

Packet socket binding or SO_BINDTODEVICE will search the list, but it is unlikely
that these paths are worth optimizing for.


> Binding to IP addresses have the same issue??

No, uses the fib.

> Also, though hashing by name is not horribly exact, hashing on the device
> index should be nearly perfect, so finding device 666 might take a search
> through only 5 or so devices (find the hash-bucket, walk down the list in
> that bucket).

Just why? It is not in any critical path I can see at all. 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
