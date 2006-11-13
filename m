Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754224AbWKMJZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbWKMJZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbWKMJZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:25:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27615 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1754224AbWKMJZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:25:21 -0500
Date: Mon, 13 Nov 2006 09:25:15 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Miller <davem@davemloft.net>, kenneth.w.chen@intel.com,
       akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [patch] fix up generic csum_ipv6_magic function prototype
Message-ID: <20061113092515.GS29920@ftp.linux.org.uk>
References: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com> <20061108.230059.57444310.davem@davemloft.net> <20061109072216.GL29920@ftp.linux.org.uk> <20061108.235548.12921799.davem@davemloft.net> <20061113085223.GR29920@ftp.linux.org.uk> <20061113091222.GA26628@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113091222.GA26628@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 09:12:22AM +0000, Russell King wrote:
> On Mon, Nov 13, 2006 at 08:52:23AM +0000, Al Viro wrote:
> > After doing the above we have the following:
> > 
> > Platform-dependent:
> > __wsum csum_tcpudp_nofold(__be32, __be32, T1, T2, __wsum);
> > On arm/arm26: T1 = unsigned short, T2 = unsigned int.
> > __sum16 csum_tcpudp_magic(__be32, __be32, unsigned short, T, __wsum);
> > On arm/arm26 T is unsigned int, elsewhere it's unsigned short.
> 
> Could both become unsigned short or unsigned int.  Would prefer
> unsigned int on ARM, since otherwise the compiler generate code to
> truncate any variable "int"s to an unsigned short.

Frankly, as for the generated code...  I'd expect s/htons(len)/len * 256/
and the same for proto in there to have much more effect.  And it does give
the same checksum...
