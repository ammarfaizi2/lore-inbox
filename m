Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUFXXBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUFXXBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUFXXA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:00:59 -0400
Received: from marasystems.com ([213.150.153.194]:42178 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S264727AbUFXXAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:00:45 -0400
Date: Fri, 25 Jun 2004 01:00:41 +0200 (CEST)
From: Henrik Nordstrom <hno@marasystems.com>
X-X-Sender: henrik@filer.marasystems.com
To: Paul P Komkoff Jr <i@stingr.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [RFC] How to implement wccp over gre tunnel ?
In-Reply-To: <20040624194039.GA19574@stingr.net>
Message-ID: <Pine.LNX.4.44.0406250044080.25930-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004, Paul P Komkoff Jr wrote:

> Currently my goal is to make squid + wccp configuration working
> out-of-the box. Ideally - without any extra modules.

This is possible with WCCPv2 using direct routing avoiding the need of
GRE/WCCP tunneling. WCCPv2 patches do exists for Squid-2.5, but may be a
little hard to find.. (no official maintainer of the WCCPv2 support for
Squid at the moment)

> Currently, most wccp configurations are working with this module:
> http://www.squid-cache.org/WCCP-support/Linux/ip_wccp.c

Please note that this module is by no means clean, and lacks a lot in 
security.

There is also a WCCP patch available to the GRE driver. This approach 
provides a little more security but is also more complex to set up for the 
same reasons and is not used very much..

  http://www.swelltech.com/pengies/joe/patches/linux-2.4.8-ip_gre.patch

The GRE patch is very simplistic and would do good of being properly 
implemented and integrated with the "ip tunnel" command for 
configuration of the GRE protocol (normal GRE / WCCPv1 / WCCPv2 / 
whatever...).

> What do you think? Which way I should do?

I think approach 1 (decapsulation within GRE) is most suitable. It also 
provides an adequate level of control on security and permissions which 
may be hard to accomplish if separating the two.

Regards
Henrik Nordström
aka hno@squid-cache.org and current maintainer of the Squid ip_wccp.c 
module

