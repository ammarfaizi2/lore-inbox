Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVDYT5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVDYT5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVDYT5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:57:41 -0400
Received: from ipx10069.ipxserver.de ([80.190.240.67]:43472 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262746AbVDYT5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:57:38 -0400
Date: Mon, 25 Apr 2005 21:57:36 +0200
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: IPv6 has trouble assigning an interface
Message-ID: <20050425195736.GB3123@codeblau.de>
References: <20050311202122.GA13205@fefe.de> <20050311173308.7a076e8f.akpm@osdl.org> <20050324.205902.119922975.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324.205902.119922975.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using stock 2.6.11.7 now.

Here is an strace of some piece of code of mine:

socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP) = 3
setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [12884901889], 4) = 0
bind(3, {sa_family=AF_INET6, sin6_port=htons(8002), inet_pton(AF_INET6, "::", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, 28) = 0
setsockopt(3, SOL_IPV6, IPV6_MULTICAST_LOOP, "\1", 1) = 0
[...]
sendto(3, "ncp-lowfat-1.2.2", 16, 0, {sa_family=AF_INET6, sin6_port=htons(8002), inet_pton(AF_INET6, "ff02::6e63:7030", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, 28) = -1 EADDRNOTAVAIL (Cannot assign requested address)

ff02 is a link-local multicast address.  I've bound to ::.  How can this
fail?  link-local should always work, even if no routes are set and no
router has been found.

Felix
