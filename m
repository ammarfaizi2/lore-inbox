Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbUCJSSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUCJSSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:18:34 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:60342 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262764AbUCJSSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:18:08 -0500
Date: Wed, 10 Mar 2004 10:16:27 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Roman Zippel <zippel@linux-m68k.org>
cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Cleaner way to conditionally disallow a CONFIG option as static
In-Reply-To: <Pine.LNX.4.58.0403100437040.27654@serv>
Message-ID: <Pine.LNX.4.58.0403101006390.3016@localhost.localdomain>
References: <Pine.LNX.4.58.0403081659170.1656@localhost.localdomain>
 <Pine.LNX.4.58.0403100437040.27654@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Roman Zippel wrote:

> Hi,
>
> On Mon, 8 Mar 2004, Sridhar Samudrala wrote:
>
> > In 2.6, net/sctp/Kconfig
> >
> > config IPV6_SCTP__
> > 	tristate
> > 	default y if IPV6=n
> > 	default IPV6 if IPV6
> >
> > config IP_SCTP
> > 	tristate "The SCTP Protocol (EXPERIMENTAL)"
> > 	depends on IPV6_SCTP__
>
> This can be written as:
>
> config IP_SCTP
> 	tristate "The SCTP Protocol (EXPERIMENTAL)"
> 	depends on IPV6 || IPV6=n
>

Thanks. Your 2.6 solution helped me come up with the following solution for
2.4 too and avoid the hack.

if [ "$CONFIG_IPV6" = "n" ]; then
  tristate '  The SCTP Protocol (EXPERIMENTAL)' CONFIG_IP_SCTP
else
  dep_tristate '  The SCTP Protocol (EXPERIMENTAL)' CONFIG_IP_SCTP $CONFIG_IPV6
fi

Thanks
-Sridhar
