Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269908AbTGKLeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 07:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269909AbTGKLeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 07:34:16 -0400
Received: from netcore.fi ([193.94.160.1]:33548 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S269908AbTGKLeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 07:34:15 -0400
Date: Fri, 11 Jul 2003 14:48:54 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Mika Liljeberg <mika.liljeberg@welho.com>
cc: Andre Tomt <andre@tomt.net>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
In-Reply-To: <1057923396.893.16.camel@hades>
Message-ID: <Pine.LNX.4.44.0307111446250.27865-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2003, Mika Liljeberg wrote:
> Here's a valid use for subnet router anycase that isn't working.
> Somebody asked me how to set up 6to4, so I did a little testing.
> 
> Doesn't work:
> 
> hades:~# ip route add ::/0 via 2002:c058:6301::
> RTNETLINK answers: Invalid argument
> 
> Works:
> 
> hades:~# ip route add ::/0 via 2002:c058:6301::1
> 
> Unfortunately the first form is what I need:
> 
> hades:~# host -t AAAA 6to4.ipv6.funet.fi
> 6to4.ipv6.funet.fi has AAAA address 2001:708:0:1::624
> 6to4.ipv6.funet.fi has AAAA address 2002:c058:6301::

I think that in this particular case, if should have configured your 
interface address with 2002:v4:addr::/16, of which subnet anycast router 
address would be 2002::.
 
> So apparently there really is an inappropriate subnet router anycast
> sanity check. Please fix this!

This *may* be caused by another issue too: nexthop's must be given in the
compatible "::192.88.99.1" format, not 2002:xxxx :-(

I sent a patch on over a year or so ago, but it didn't gain that much 
enthusiasm..

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

