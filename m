Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWCTS6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWCTS6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWCTS6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:58:30 -0500
Received: from palrel13.hp.com ([156.153.255.238]:39822 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S964815AbWCTS63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:58:29 -0500
Message-ID: <441EFB51.70102@hp.com>
Date: Mon, 20 Mar 2006 10:58:25 -0800
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Lennert Buytenhek <buytenh@wantstofly.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
References: <20060320090629.GA11352@mellanox.co.il>	<20060320.015500.72136710.davem@davemloft.net>	<20060320102234.GV29929@mellanox.co.il>	<20060320.023704.70907203.davem@davemloft.net>	<20060320112753.GX29929@mellanox.co.il>	<1142855223.3114.30.camel@laptopd505.fenrus.org>	<20060320114933.GA3058@xi.wantstofly.org>	<20060320120407.GY29929@mellanox.co.il> <20060320150941.GD16108@kvack.org>
In-Reply-To: <20060320150941.GD16108@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't it make sense to strech the ACK when the previous ACK is still in 
> the TX queue of the device?  I know that sort of behaviour was always an 
> issue on modem links where you don't want to send out redundant ACKs.

Perhaps, but it isn't clear that it would be worth the cycles to check. 
    I doubt that a simple reference count on the ACK skb would do it 
since if it were a bare ACK I doubt that TCP keeps a reference to the 
skb in the first place?

Also, what would be the "trigger" to send the next ACK after the 
previous one had left the building (Elvis-like)?  Receipt of N in-order 
segments?  A timeout?

If you are going to go ahead and try to do stretch-ACKs, then I suspect 
the way to go about doing it is to have it behave very much like HP-UX 
or Solaris, both of which have arguably reasonable ACK-avoidance 
heuristics in them.

But don't try to do it quick and dirty.

rick "likes ACK avoidance, just check the archives" jones
on netdev, no need to cc me directly
