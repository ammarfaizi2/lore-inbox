Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTLZHdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 02:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTLZHdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 02:33:09 -0500
Received: from fmr99.intel.com ([192.55.52.32]:1757 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261659AbTLZHc7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 02:32:59 -0500
Date: Fri, 26 Dec 2003 15:26:58 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: "Zhu, Yi" <yi.zhu@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix make kernel rpm bug
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840254C793@PDSMSX403.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0312261507560.20459-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Dec 2003, Russell King wrote:

> What Jeff means is that $(ARCH) may not be what rpm calls the
> architecture.  For instance, the kernel has "arm" but RPM has
> "armv3l" "armv4l" etc, but doesn't know what "arm" is.

Thanks for the explain. How about change it as below? People can change
UTS_MACHINE to its own march like "armv5te" if it is not the same as
$(ARCH).


@@ -872,7 +872,7 @@
        $(CONFIG_SHELL) $(srctree)/scripts/mkversion >
$(objtree)/.tmp_version;\
        mv -f $(objtree)/.tmp_version $(objtree)/.version;

-       $(RPM) -ta ../$(KERNELPATH).tar.gz
+       $(RPM) --target $(UTS_MACHINE) -ta ../$(KERNELPATH).tar.gz
        rm ../$(KERNELPATH).tar.gz

 # Brief documentation of the typical targets used

> 
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core

-yi

