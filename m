Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279739AbRKAUY5>; Thu, 1 Nov 2001 15:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279746AbRKAUYr>; Thu, 1 Nov 2001 15:24:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51594 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279741AbRKAUYj>;
	Thu, 1 Nov 2001 15:24:39 -0500
Date: Thu, 01 Nov 2001 12:23:39 -0800 (PST)
Message-Id: <20011101.122339.48529660.davem@redhat.com>
To: haegar@sdinet.de
Cc: Fernando_Netto@cmsoftware.com.br, linux-kernel@vger.kernel.org
Subject: Re: Is there a MAX TCP/UDP CONNECTIONS limit in Kernel?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.40.0111011931471.7334-100000@space.comunit.de>
In-Reply-To: <70B75822B253D511AA910002440963EB1D8FD6@CMSERVICES>
	<Pine.LNX.4.40.0111011931471.7334-100000@space.comunit.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sven Koch <haegar@sdinet.de>
   Date: Thu, 1 Nov 2001 19:37:31 +0100 (CET)
   
   Outbound-connections are limited by the local portrange, changeable
   in /proc/sys/net/ipv4/ip_local_port_range
   (ran into this on one of my proxy servers, having thousands of connections
   in the state CLOSING, TIME_WAIT and LAST_ACK - after
   echo "1024 16383" >/proc/sys/net/ipv4/ip_local_port_range the box at
   least stays working)

In current 2.4.14-preX, this is not true anymore.  It is limited
by something approximating "local port range X number of unique
destination IP addresses" because if the remote address is unique
we allow multiple local port binds to occur on the same local port.

Franks a lot,
David S. Miller
davem@redhat.com
