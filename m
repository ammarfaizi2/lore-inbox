Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVA1JcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVA1JcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 04:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVA1JcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 04:32:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23824 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261238AbVA1JcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 04:32:18 -0500
Date: Fri, 28 Jan 2005 09:32:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Phil Oester <kernel@linuxace.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050128093206.C9486@flint.arm.linux.org.uk>
Mail-Followup-To: Phil Oester <kernel@linuxace.com>,
	Robert Olsson <Robert.Olsson@data.slu.se>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, alexn@dsv.su.se,
	kas@fi.muni.cz, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20050123200315.A25351@flint.arm.linux.org.uk> <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127183745.GA13365@linuxace.com> <20050127192504.D3036@flint.arm.linux.org.uk> <20050127204012.GA14518@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050127204012.GA14518@linuxace.com>; from kernel@linuxace.com on Thu, Jan 27, 2005 at 12:40:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 12:40:12PM -0800, Phil Oester wrote:
> Vanilla 2.6.10, though I've been seeing these problems since 2.6.8 or
> earlier.

Right.  For me:

- 2.6.9-rc3 (installed 8th Oct) died with dst cache overflow on 29th November
- 2.6.10-rc2 (booted 29th Nov) died with the same on 19th January
- 2.6.11-rc1 (booted 19th Jan) appears to have the same problem, but
  it hasn't died yet.

> Netfilter running on all boxes, some utilizing SNAT, others
> not -- none using MASQ.

IPv4 filter targets: ACCEPT, DROP, REJECT, LOG
	using: state, limit & protocol

IPv4 nat targets: DNAT, MASQ
	using: protocol

IPv4 mangle targets: ACCEPT, MARK
	using: protocol

IPv6 filter targets: ACCEPT, DROP
	using: protocol

IPv6 mangle targets: none

(protocol == at least one rule matching tcp, icmp or udp packets)

IPv6 configured native on internal interface, tun6to4 for external IPv6
communication.

IPv4 and IPv6 forwarding enabled.
IPv4 rpfilter, proxyarp, syncookies enabled.
IPv4 proxy delay on internal interface set to '1'.

> These boxes are all running the quagga OSPF daemon, but those that
> are lightly loaded are not exhibiting these problems.

Running zebra (for ipv6 route advertisment on the local network only.)

Network traffic-wise, 2.6.11-rc1 has this on its public facing
interface(s) in 8.5 days.

4: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    RX: bytes  packets  errors  dropped overrun mcast
    667468541  2603373  0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    1245774764 2777605  0       0       1       2252

5: tun6to4@NONE: <NOARP,UP> mtu 1480 qdisc noqueue
    RX: bytes  packets  errors  dropped overrun mcast
    19130536   84034    0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    10436749   91589    0       0       0       0


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
