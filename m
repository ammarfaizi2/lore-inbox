Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbULXGXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbULXGXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 01:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbULXGXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 01:23:33 -0500
Received: from smtp.knology.net ([24.214.63.101]:27812 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261377AbULXGXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 01:23:30 -0500
Subject: Re: [Ipsec] Issue on input process of Linux native IPsec
From: David Dillow <dave@thedillows.org>
To: Park Lee <parklee_sel@yahoo.com>
Cc: Kausty <kkumbhalkar@gmail.com>, ipsec@ietf.org,
       ipsec-tools-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
In-Reply-To: <20041223062905.20979.qmail@web51503.mail.yahoo.com>
References: <20041223062905.20979.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Dec 2004 01:23:27 -0500
Message-Id: <1103869407.3016.7.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 22:29 -0800, Park Lee wrote:
> Thanks.
> But, After a packet was received, It has already been
> processed by xfrm4_rcv(), xfrm4_rcv_encap(),
> ah_input(), esp_input(),etc. so, I think that there is
> no need to search(or created) a bundle everytime a
> packet is recieved, since it has already been
> processed. Am I right?

Are you sure you're not seeing the creation of a reply packet? Unless
you're testing with UDP and a listening socket on the receiver, you're
going to get a response packet if the incoming packet makes it through
the iptables rules. You were testing with ICMP echo requests (ping), if
I recall.

I think either you're basing your idea of the packet flow on printk()'s,
or I'm just too tired and missing where xfrm_lookup() gets called on the
rx path... (yes, sk can be NULL there, but I was wrong about it being
called for Rx'd packets, I think).

However, if your NIC driver does NAPI, you can see an xfrm_lookup() on
the reply packet when the driver calls netif_receive_skb() -- this bit
me recently...
-- 
David Dillow <dave@thedillows.org>
