Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSG0OjX>; Sat, 27 Jul 2002 10:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSG0OjX>; Sat, 27 Jul 2002 10:39:23 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:22569 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318767AbSG0OjV>; Sat, 27 Jul 2002 10:39:21 -0400
Date: Sat, 27 Jul 2002 17:42:29 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About the need of a swap area
Message-ID: <20020727144228.GQ1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <3D42907C.mailFS15JQVA@viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D42907C.mailFS15JQVA@viadomus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(There _must_ be a good document on this somewhere, but I didn't find it.
Besides, I'm by far not the best person to explain this, but I believe the
VM gurus have better things to do than to explain this yet again...)

On Sat, Jul 27, 2002 at 02:22:20PM +0200, you [DervishD] wrote:
>
>     I read a time ago that, no matter the RAM you have, adding a
> swap-area will improve performance a lot. So I tested.

Well, no. I don't know where you read it, but that's wrong.

Adding swap can only improve if the freed physical memory can be used for
something useful. Useful uses would include (obviously) the active programs
(excutable code and data). The rest of the memory can be used for disk
cache. This can help tremendously, since RAM is ~1000 times faster than
harddisk.

Where swap helps perfomance is when you can swap _inactive_ (parts of)
programs out, and use the freed memory for disk cache.

Where swap differs from adding physical memory is that if/when the inactive
programs become active, you need to swap them in, which takes time.

Obviosly, if you are not using large parts of the disk actively, adding disk
cache will not help. Once active program pages and active disk blocks are in
RAM, the performance is in theory optimal.

Of course, "active" is not unambiguous. You can shovel less active program
and disk pages in memory, but the gain goes quickly down.

>     I created a swap area twice as large as my RAM size (just an
> arbitrary size), that is 1G. I've tested with lower sizes too. My RAM
> is never filled (well, I haven't seen it filled, at least) since I
> always work on console, no X and things like those. Even compiling
> two or three kernels at a time don't consume my RAM. What I try to
> explain is that the swap is not really needed in my machine, since
> the memory is not prone to be filled.

So you have 512MB of RAM? All the programs (without X) will fit there
easily. You'll still have plenty for disk cache. 
 
>     Well, I haven't notice any change in performance, and the swap
> area is *never* used.

If it is never used, it doesn't help.

BUT: if something unexpected happens - a programs goes out of control and
eats heaps of memory - the swap can save you.

>  That contradicts what I've read about that, no matter your free RAM size,
> a bit of swap is always used. That is not my case, definitely.

You almost always have inactive programs that could be swapped off. The
freed memory could be used for disk cache. So you could gain _something_.
 
Hope this helps.


-- v --

v@iki.fi
