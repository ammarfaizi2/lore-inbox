Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269136AbUJTW34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269136AbUJTW34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269040AbUJTWZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:25:31 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:6867 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S270549AbUJTWWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:22:02 -0400
Date: Thu, 21 Oct 2004 00:10:34 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.9 network regression killing amanda (was: 2.6.9 network regression killing amanda - 3c59x?)
Message-ID: <20041020221034.GA10414@merlin.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20041020191203.GA14356@merlin.emma.line.org> <20041020142420.0d513191.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020142420.0d513191.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Andrew Morton wrote:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> >
> > Has the 3c59x driver changed between 2.6.8.1 and 2.6.9?
> 
> Not much, really.  Just vlan support.
> 
> > Which patches or changesets are worth backing out?
> 
> Try the 2.6.8.1 driver in a 2.6.9 kernel?

I tried the 2.6.8 3c59x driver (just changed 3c59x.c), problem persists.

I used the Rhine interface (VIA VT6102 Rhine II rev. 78), problem persists.

I removed the bridge and used the Rhine-II interface directly, problem persists.

Apparently the problem is not in 3c59x or bridge code but somewhere
else.  Here's a tcpdump of eth3, my Rhine-II interface, again,
192.168.0.1 is the machine running Linux 2.6.9 with the failing amanda
server, 192.168.0.2 is the FreeBSD 4.10-RELEASE-p3 client.

00:03:00.604639 IP (tos 0x0, ttl  64, id 1, offset 0, flags [DF], length: 145) 192.168.0.1.680 > 192.168.0.2.10080: [udp sum ok] UDP, length: 117
00:03:00.634775 IP (tos 0x0, ttl  64, id 35321, offset 0, flags [none], length: 78) 192.168.0.2.10080 > 192.168.0.1.680: [udp sum ok] UDP, length: 50
00:03:00.637893 IP (tos 0x0, ttl  64, id 35322, offset 0, flags [none], length: 111) 192.168.0.2.10080 > 192.168.0.1.680: [udp sum ok] UDP, length: 83
00:03:00.637977 IP (tos 0x0, ttl  64, id 2, offset 0, flags [DF], length: 78) 192.168.0.1.680 > 192.168.0.2.10080: [udp sum ok] UDP, length: 50
00:03:00.638546 IP (tos 0x0, ttl  64, id 3, offset 0, flags [DF], length: 474) 192.168.0.1.680 > 192.168.0.2.10080: [udp sum ok] UDP, length: 446
00:03:00.667236 IP (tos 0x0, ttl  64, id 35323, offset 0, flags [none], length: 78) 192.168.0.2.10080 > 192.168.0.1.680: [udp sum ok] UDP, length: 50
00:03:23.874517 IP (tos 0x0, ttl  64, id 35324, offset 0, flags [none], length: 172) 192.168.0.2.10080 > 192.168.0.1.680: [udp sum ok] UDP, length: 144
00:03:23.874666 IP (tos 0x0, ttl  64, id 7, offset 0, flags [DF], length: 78) 192.168.0.1.680 > 192.168.0.2.10080: [udp sum ok] UDP, length: 50
00:03:28.476532 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 242) 192.168.0.1.683 > 192.168.0.2.10080: [udp sum ok] UDP, length: 214
00:03:28.505893 IP (tos 0x0, ttl  64, id 35325, offset 0, flags [none], length: 78) 192.168.0.2.10080 > 192.168.0.1.683: [udp sum ok] UDP, length: 50
00:03:28.534138 IP (tos 0x0, ttl  64, id 35326, offset 0, flags [none], length: 150) 192.168.0.2.10080 > 192.168.0.1.683: [bad udp cksum a!] UDP, length: 122
00:03:38.542777 IP (tos 0x0, ttl  64, id 35327, offset 0, flags [none], length: 150) 192.168.0.2.10080 > 192.168.0.1.683: [bad udp cksum a!] UDP, length: 122

I can provide hex dumps if desired.

-- 
Matthias Andree
