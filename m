Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTI2JDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTI2JDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:03:08 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:25597 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262932AbTI2JDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:03:02 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030929003229.GM1039@conectiva.com.br>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030928233909.GG1039@conectiva.com.br> <20030929001439.GY15338@fs.tum.de>
	 <20030929003229.GM1039@conectiva.com.br>
Content-Type: text/plain
Message-Id: <1064826174.29569.13.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5 (dwmw2) 
Date: Mon, 29 Sep 2003 10:02:55 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-28 at 21:32 -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 29, 2003 at 02:14:39AM +0200, Adrian Bunk escreveu:
> > On Sun, Sep 28, 2003 at 08:39:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > What about the following solution (the names and help texts for the
> > config options might not be optimal, I hope you understand the
> > intention):
> > 
> > config IPV6_SUPPORT
> > 	bool "IPv6 support"
> > 
> > config IPV6_ENABLE
> > 	tristate "enable IPv6"
> > 	depends on IPV6_SUPPORT
> > 
> > IPV6_SUPPORT changes structs etc. and IPV6_ENABLE is responsible for 
> > ipv6.o .
> 
> Humm, and the idea is? This seems confusing, could you elaborate on why such
> scheme is a good thing?

The idea is that you then have ifdefs on CONFIG_IPV6_SUPPORT not on
CONFIG_IPV6_MODULE.

The underlying point being that your static kernel should not change if
you change an option from 'n' to 'm'. It should only affect the kernel
image if you change options to/from 'y'.

We should remove the definitions of 'CONFIG_xxxx_MODULE' entirely from
visibility during the build of non-module files, to prevent further
breakage of this sort.

-- 
dwmw2

