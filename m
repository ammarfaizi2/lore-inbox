Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136618AbRAHG6N>; Mon, 8 Jan 2001 01:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136778AbRAHG6D>; Mon, 8 Jan 2001 01:58:03 -0500
Received: from james.kalifornia.com ([208.179.0.2]:7292 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136618AbRAHG5z>; Mon, 8 Jan 2001 01:57:55 -0500
Date: Sun, 7 Jan 2001 22:57:45 -0800 (PST)
From: David Ford <david@linux.com>
To: Andi Kleen <ak@suse.de>
cc: Chris Wedgwood <cw@f00f.org>, "David S. Miller" <davem@redhat.com>,
        greearb@candelatech.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <20010108072634.A29753@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10101072232330.12242-100000@Huntington-Beach.Blue-Labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Andi Kleen wrote:
> Who says that it names a device? It names interfaces.
> There are good reasons to have names for ifas, and I see no really good
> convincing reasons not to put these names into the interface name space.
> (in addition it'll save a lot of people a lot of grief) 
> When you're proposing a change that breaks thousands of configuration you
> need a really good reason for it, and so far I cannot see one. It would 
> be different if the older way needed lots of hard to maintain fragile code in 
> the kernel, but that's really not the case. 

If people are upgrading to things like 2.6, then one must expect some
changes.  The eth0:0 style has already been whittled down, it has nothing
now but the IP and mask info. It's a something between two styles.  It
encourages a non-scalable use.  I.e. eth0:2342, or eth0:http.  It came up
because listing w/ ifconfig -a in it's current form wasn't satisfactorily
fast.

Distributions should be encouraged to use ip rather than ifconfig/route.  It
works better and does more, the output is more informative, more concise,
and less confusing.  It doesn't take that much more disk space than ifconfig
and route does, ifconfig and route take 74K, ip takes 89K. I don't think 15k
of disk space is sufficient concern, given that inodes are probably page
size.  That comes out to three pages difference.  Even on a floppy that's
not much.  I didn't even compile optimized for size either.

Due to that, 'eth0:n' becomes a byproduct without much merit.  People who
insist on eth0:n are probably people who also will insist on 1.2.13 for
their router simply because they don't want or need to change it.  The new
form with the new tool is easier, especially if you have any cisco
background.  You can't beat 'ip a a 10.1.1.1/24 brd + dev eth0' for the
netmask and figuring out the broadcast properly without error.  It's shorter
and less prone to error and more easily scriptable because you don't need a
changing label.  It's also more easily parsed by scripts.

-d


--
---NOTICE--- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
