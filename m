Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269712AbTGJXtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269717AbTGJXtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:49:39 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:51076 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S269712AbTGJXtg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:49:36 -0400
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: CaT <cat@zip.com.au>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       pekkas@netcore.fi
In-Reply-To: <20030710233931.GG1722@zip.com.au>
References: <20030710154302.GE1722@zip.com.au>
	 <1057854432.3588.2.camel@hades>  <20030710233931.GG1722@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057881869.3588.10.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 03:04:29 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 02:39, CaT wrote:
> And having remembered /127 being mentioned as bad I changed the
> interface config to a netmask of /64. Dropped it and brought it
> up and it all works.
> 
> There's something fundamental about ipv6 netmasks that I just don't
> understand...

Well, the thing is that prefix:: is a special anycast address that
identifies a router on the link prefix::/n, where n is the prefix
length. You had configured a 127-bit link prefix, meaning that you had
only one valid unicast address (last bit == 1) in addition to the router
anycast address (last bit == 0).

Normally, IPv6 networks are supposed to use 64-bit on-link prefixes but
the implementation can be written in such a way that other prefix
lengths can be configured.

Setting your tunnel prefix to /64 is certainly the right thing to do. 

	MikaL

