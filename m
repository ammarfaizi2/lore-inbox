Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVDYVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVDYVBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDYVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:01:45 -0400
Received: from netcore.fi ([193.94.160.1]:8925 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S261194AbVDYVBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:01:10 -0400
Date: Tue, 26 Apr 2005 00:00:46 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: IPv6 has trouble assigning an interface
In-Reply-To: <20050425195736.GB3123@codeblau.de>
Message-ID: <Pine.LNX.4.61.0504252359580.4921@netcore.fi>
References: <20050311202122.GA13205@fefe.de> <20050311173308.7a076e8f.akpm@osdl.org>
 <20050324.205902.119922975.yoshfuji@linux-ipv6.org> <20050425195736.GB3123@codeblau.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, Felix von Leitner wrote:
> Here is an strace of some piece of code of mine:
>
> socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP) = 3
> setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [12884901889], 4) = 0
> bind(3, {sa_family=AF_INET6, sin6_port=htons(8002), inet_pton(AF_INET6, "::", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, 28) = 0
> setsockopt(3, SOL_IPV6, IPV6_MULTICAST_LOOP, "\1", 1) = 0
> [...]
> sendto(3, "ncp-lowfat-1.2.2", 16, 0, {sa_family=AF_INET6, sin6_port=htons(8002), inet_pton(AF_INET6, "ff02::6e63:7030", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, 28) = -1 EADDRNOTAVAIL (Cannot assign requested address)
>
> ff02 is a link-local multicast address.  I've bound to ::.  How can this
> fail?  link-local should always work, even if no routes are set and no
> router has been found.

Umm.. link-local unicast and multicast both require that you specify 
the interface, because otherwise it's ambiguous -- how could the 
kernel know which interface should be used to send the packet?

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings
