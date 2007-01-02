Return-Path: <linux-kernel-owner+w=401wt.eu-S1755413AbXABVPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbXABVPd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbXABVPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:15:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:59140 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755413AbXABVPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:15:32 -0500
In-Reply-To: <1167768494.6165.63.camel@localhost.localdomain>
References: <459714A6.4000406@firmworks.com> <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr> <20061231.124531.125895122.davem@davemloft.net> <1167709406.6165.6.camel@localhost.localdomain> <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org> <1167768494.6165.63.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c7212f93de62c2f7f50be71f257c8974@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       David Miller <davem@davemloft.net>, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 22:15:50 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Are you really suggesting that using a kernel copy of the
>> device tree is the correct thing to do, and the only correct
>> thing to do -- with the sole argument that "that's what the
>> current ports do"?
>
> Well, there are reasons why that's what the current ports do :-)

Sure.  It might have been a good choice for the current two ports
(probably was even, at least at that point in time the choice was
made -- doesn't mean you can't ever step back on it).

That doesn't mean it's a good choice for everything and certainly
it's not the only realistic choice for everything.

> We could of course have the interface work either on a copy of the tree
> or on a real OF

Yes.  I'd like to steer in that direction eventually.

> (though that means changing things like get_property on
> powerpc

You can keep the function name, and have it redirect through
a struct device_tree_ops or similar.

> and fixing the gazillions of users)

which isn't needed if we can manage to keep the function arguments
identical.

We also can keep the old names as compatibility accessors for
PowerPC only for a while, until everything is converted -- SPARC
can do the same then.  You can't really keep the old PowerPC names
in kernel-wide code anyway, "get_property" is a way too generic
name for that for example.

> but I tend to think that
> working on a copy always is more efficient.

In general, nothing using the device tree cares about a few
cycles extra (well, a few thousand perhaps).  The sole exception
would seem to be the filesystem; and it could easily keep a cache,
one with a global invalidate (via callback?) on any device tree
change even -- changes are infrequent, and basically non-existent
after early kernel boot.  Does any generic such cache for all
simple filesystems exist already?


Segher

