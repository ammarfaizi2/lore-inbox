Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269070AbUIRAWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269070AbUIRAWH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 20:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUIRAWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 20:22:07 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:42375 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269070AbUIRAWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 20:22:00 -0400
Message-ID: <9e47339104091717215e9be08b@mail.gmail.com>
Date: Fri, 17 Sep 2004 20:21:51 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
Cc: David Gibson <david@gibson.dropbear.id.au>, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20040917112744.190f6f3e.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040917062042.GE6523@zax>
	 <20040917112744.190f6f3e.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still OOPsing at boot in fib_disable_ip+21 from
fib_netdev_event+63. Both e1000 and tg3 are effected. I have current
linus bk as of time of this message.

It only occurs when Redhat goes through the scaning for new hardware
phase during boot. Is RH loading the drivers in some special way
during this phase? If I load the drivers manually after I'm booted
they load ok. I'm running with the drivers as modules, I'll try
switching to compiled in.

The change referenced in this thread is in my kernel:
fib_semantics.c, 604
                } else {
                        memset(new_info_hash, 0, bytes);
                        memset(new_laddrhash, 0, bytes);

                        fib_hash_move(new_info_hash, new_laddrhash, new_size);
                }



On Fri, 17 Sep 2004 11:27:44 -0700, David S. Miller <davem@davemloft.net> wrote:
> 
> Thanks David, I'll push this upstream asap.
> 
> I can't believe in all the route testing I did I never
> triggered this on my sparc64 boxes, must have been lucky :(
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
Jon Smirl
jonsmirl@gmail.com
