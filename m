Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUIJKrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUIJKrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUIJKrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:47:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267350AbUIJKq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:46:58 -0400
Date: Fri, 10 Sep 2004 11:46:58 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix DHCP ipconfig.c
Message-ID: <20040910104658.GN23987@parcelfarce.linux.theplanet.co.uk>
References: <20040910104515.A22599@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910104515.A22599@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 10:45:15AM +0100, Russell King wrote:
> bk-curr seems to be a little sick here:
> 
>   CC      net/ipv4/ipconfig.o
> net/ipv4/ipconfig.c: In function `ic_bootp_recv':
> net/ipv4/ipconfig.c:969: error: `i' undeclared (first use in this function)
> net/ipv4/ipconfig.c:969: error: (Each undeclared identifier is reported only once
> net/ipv4/ipconfig.c:969: error: for each function it appears in.)
> 
> and here's the medicine:

And here's better one:

diff -urN RC9-rc1-bk16-base/net/ipv4/ipconfig.c RC9-rc1-bk16-current/net/ipv4/ipconfig.c
--- RC9-rc1-bk16-base/net/ipv4/ipconfig.c	2004-09-10 02:13:24.000000000 -0400
+++ RC9-rc1-bk16-current/net/ipv4/ipconfig.c	2004-09-10 03:40:10.000000000 -0400
@@ -966,9 +966,7 @@
 				break;
 
 			case DHCPACK:
-				for (i = 0; (dev->dev_addr[i] == b->hw_addr[i])
-						&& (i < dev->addr_len); i++);
-				if (i < dev->addr_len)
+				if (memcmp(b->hw_addr, dev->dev_addr, dev->addr_len) != 0)
 					goto drop_unlock;
 
 				/* Yeah! */
