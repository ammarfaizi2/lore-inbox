Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSFMQzn>; Thu, 13 Jun 2002 12:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSFMQzm>; Thu, 13 Jun 2002 12:55:42 -0400
Received: from hdfdns01.hd.intel.com ([192.52.58.10]:55501 "EHLO
	mail1.hd.intel.com") by vger.kernel.org with ESMTP
	id <S314514AbSFMQzm>; Thu, 13 Jun 2002 12:55:42 -0400
Message-ID: <BD9B60A108C4D511AAA10002A50708F22C1540@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "'Renato'" <webmaster@cienciapura.com.br>, linux-kernel@vger.kernel.org
Subject: RE: Problems with e1000 driver and ksoftirqd_CPU0
Date: Thu, 13 Jun 2002 09:54:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to time constraints and wanting to have a stable and tested driver on
the distribution, Red Hat's latest kernels have the last released version of
e1000 before we started doing some major cleanup in preparation for merging
e1000 into the standard kernel distribution.  One of the "features" that was
removed since then is the use of a tasklet for receive buffer allocation,
which under certain loads can be a horrible thing.

I would highly recommend trying e1000 4.2.17, either the version found in
the latest 2.5 kernels or from Intel.  The version on Intel's site has some
additional backwards compatibility code for 2.2 support and a few
non-standard features that can easily be disabled at the top of the makefile
if you don't want them.  On the plus side it's setup to easily build outside
of the kernel source tree if you want to test it without patching and
rebuilding the kernel.

J.A. Magallon posted a backport of the driver from 2.5 to 2.4 early last
week @ http://giga.cps.unizar.es/~magallon/linux/driver/e1000-4.2.17-k1.bz2

The latest version from Intel can always be found @
http://support.intel.com/support/go/linux/e1000.htm

--
Chris Leech <christopher.leech@intel.com>
Network Software Engineer
LAN Access Division, Intel Corporation

> -----Original Message-----
> From: Renato [mailto:webmaster@cienciapura.com.br] 
> Sent: Tuesday, June 11, 2002 3:50 AM
> To: linux-kernel@vger.kernel.org
> Subject: Problems with e1000 driver and ksoftirqd_CPU0
> 
> 
> Hi all,
> 
> I'm just using the latest kernel from RedHat - 2.4.18-4smp ( which I 
> suppose it mostly -ac series ) and I'm having real problems with an 
> Ethernet Gigabit network. It looks like "ksoftirqd_CPU0" eats 
> up all the 
> CPU processing with a traffic of just 55 Mbps !! ( it's not 
> my hardware... 
> I'm using a Dual Xeon 2Ghz and with kernel 2.4.9 it could 
> handle easily 85 
> Mbps ) 
