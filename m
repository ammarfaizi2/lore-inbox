Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTICLec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTICLec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:34:32 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:7379 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S261898AbTICLe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:34:29 -0400
Date: Wed, 3 Sep 2003 14:31:18 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Justin Ossevoort <iq-0@brains.student.utwente.nl>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6 - Kernel panic with GRE tunneling
In-Reply-To: <1062585476.9134.39.camel@pulse>
Message-ID: <Pine.LNX.4.56.0309031427030.26055@hosting.rdsbv.ro>
References: <1062585476.9134.39.camel@pulse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
Hello!

> I encountered some kernel bug in the ip_gre module. This problem has
> been tested on: 2.6.0-test3, 2.6.0-test4-mm2, 2.6.0-test4-mm4 (In VMWare
> to get stacktrace).
>
> All kernels were build with gcc 3.3 (the latest with 3.3.2 20030831
> Debian prerelease). Tested on 2 systems (one was a VMWare), both running
> Debian Sid.
>
> this is what I did:
>
> modprobe ip_gre
> ip tunnel add test mode gre remote 10.2.0.1 local 10.2.248.255
> ip link set test up
> ip addr add 192.168.0.1 dev test
> ip route add 192.168.0.2/32 dev test
> ping 192.168.0.2
> ***crash***
>
> In order to limit the e-mail's size:
> http://brains.student.utwente.nl/~iq-0/ipgre-2.6-panic/
> there are the paniclog, an attempt to run it through ksymoops and a
> tcpdump.
>
> *note: In this test case I didn't set up the other end-point of the
> tunnel (because the other system is also 2.6 ;), but on a real life
> tunnel the same thing happened. But one doesn't liketo crash his/her
> system more than 10 times a week...
>
> Regards,
>
> justin....

I investigated a little and seems that in ip_gre.c, in
function ipgre_tunnel_lookup, at the end there is the code:

if (ipgre_fb_tunnel_dev->flags&IFF_UP)
	return ipgre_fb_tunnel_dev->priv;

Seems that ipgre_fb_tunnel_dev is NULL!

ipgre_fb_tunnel_dev is initialized in ipgre_init.

Some net guys call tell why ipgre_fb_tunnel_dev is still NULL after init.

I bet that if you configure the tunnels on both machines, it works.

Can you reproduce this without VMware?

---
Catalin(ux) BOIE
catab@deuroconsult.ro
