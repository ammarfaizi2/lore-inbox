Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbRBZXXb>; Mon, 26 Feb 2001 18:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbRBZXXW>; Mon, 26 Feb 2001 18:23:22 -0500
Received: from ns.suse.de ([213.95.15.193]:49165 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129213AbRBZXXM>;
	Mon, 26 Feb 2001 18:23:12 -0500
To: Michael Peddemors <michael@linuxmagic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net> <20010225163836.A12173@metastasis.f00f.org> <20010225045420.B10281@sith.mimuw.edu.pl> <0102261546570H.02007@mistress>
From: Andi Kleen <ak@suse.de>
Date: 27 Feb 2001 00:23:04 +0100
In-Reply-To: Michael Peddemors's message of "26 Feb 2001 23:38:22 +0100"
Message-ID: <oupg0h1jag7.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Peddemors <michael@linuxmagic.com> writes:

> A few things.. why is ip.h not part of the linux/include/net rather than 
> linux/include/linux hierachy?

Because it needs to be user visible for raw sockets (linux is exported to the user,
net isn't) 

> Defined items that are not used anywhere in the source..
> Can any of them be deleted now?

nope. they can be useful for the user.

> Also, I was looking into some RFC 1812 stuff. (Thanks for nothing Dave :) and 
> was looking at 4.2.2.6 where it mentions that a router MUST implement the End 
> of Option List option..  Havent' figured out where that is implememented yet..

It is (see net/ipv4/ip_options:ip_options_compile())

> Also was trying to figure out some things. 
> I want to create a new ip_option for use in some DOS protection experiments.
> I have a whole 40 bytes (+/-) to share...  Now although I don't see anything 
> explicitly prohibiting the use of unused IP Header option space, I know that 
> it really was designed for use by the sending parties, and not routers in 
> between.. Has anyone seen any RFC that explicitly says I MUST NOT?

Using IP options is strongly deprecated because it causes a lot of switches/routers
to go from hardware into software switch mode (-> it kills your gigabit routers) 


> IPTOS_PREC_NETCONTROL
[...]
They are implemented, just only implicitely as an array index.


-Andi
