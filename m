Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753381AbWKMJMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbWKMJMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbWKMJMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:12:47 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2066 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1753381AbWKMJMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:12:46 -0500
Date: Mon, 13 Nov 2006 09:12:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, kenneth.w.chen@intel.com,
       akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [patch] fix up generic csum_ipv6_magic function prototype
Message-ID: <20061113091222.GA26628@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	David Miller <davem@davemloft.net>, kenneth.w.chen@intel.com,
	akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com> <20061108.230059.57444310.davem@davemloft.net> <20061109072216.GL29920@ftp.linux.org.uk> <20061108.235548.12921799.davem@davemloft.net> <20061113085223.GR29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113085223.GR29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 08:52:23AM +0000, Al Viro wrote:
> After doing the above we have the following:
> 
> Platform-dependent:
> __wsum csum_tcpudp_nofold(__be32, __be32, T1, T2, __wsum);
> On arm/arm26: T1 = unsigned short, T2 = unsigned int.
> __sum16 csum_tcpudp_magic(__be32, __be32, unsigned short, T, __wsum);
> On arm/arm26 T is unsigned int, elsewhere it's unsigned short.

Could both become unsigned short or unsigned int.  Would prefer
unsigned int on ARM, since otherwise the compiler generate code to
truncate any variable "int"s to an unsigned short.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
