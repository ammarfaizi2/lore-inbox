Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265271AbUFOCaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUFOCaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 22:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUFOCaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 22:30:30 -0400
Received: from click.bur.st ([203.34.17.217]:15910 "EHLO click.bur.st")
	by vger.kernel.org with ESMTP id S265271AbUFOCa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 22:30:27 -0400
Date: Tue, 15 Jun 2004 10:30:23 +0800
From: Trent Lloyd <lathiat@bur.st>
To: Bernd Eckenfels <be-mail2004@lina.inka.de>, linux-kernel@vger.kernel.org
Cc: 253590@bugs.debian.org
Subject: Re: How to turn off IPV6 (link local)
Message-ID: <20040615023022.GB24269@thump.bur.st>
References: <20040614233215.GA10547@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614233215.GA10547@lina.inka.de>
User-Agent: Mutt/1.3.28i
X-Random-Number: 1.34714140758818e+161
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernd,

CCd: debian bug, read down to the explanation of why this is occuring
and why this is not a bug.

> While solving the debian bug #253590 against net-tools, I discovered, that
> it is not possible to turn off the link local ipv6 addresses.

Indeed.

> 
> net.ipv6.conf.default.autoconf does work for the received prefixes, but does
> not avoid the link local configuration. (this is btw a documentation error)

autoconf defines whether it will auto-configure an address if a router
advertises the IPv6 prefix for the network to it.

> 
> I would not mind the link local address much, if there wont be some
> applications (like mozilla) trying to actually use that address to reach
> internet site.
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=253590

The issue is not having the link local address, because there is no
default route and hence the connection should fail.

The problem, in the case of thi sbug, is that he has IPv6 configured,
but it is not working, 2001: is a real IPv6 address (so he has a tunnel
configured with a router to advertise) and the 2002:: is a '6ot4'
address, which something on the system has configured, and obviously
that is not working either, probably because he has a router preventing
the 6to4 packets from passsing, or the default route for the 2001:
address has a higher metric and thats still broken.

Link-local address start with fe80:: and never have a default route so
they will not be a problem.

> So my question is, how can one prevent linux kernel with build in ipv6 from
> adding the link local prefix, and are the prerequisites of an ipv6 enabled
> application to not prefer link local prefix to ipv4?

You can't, but it is not the issue here, you could however not load the
module.

Cheers,
Trent
Sixlabs

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
