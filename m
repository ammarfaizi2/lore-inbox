Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTLYHEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 02:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTLYHEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 02:04:00 -0500
Received: from fmr99.intel.com ([192.55.52.32]:27856 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263609AbTLYHD6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 02:03:58 -0500
Date: Thu, 25 Dec 2003 14:58:14 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix make kernel rpm bug
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840254C76E@PDSMSX403.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0312251254240.16528-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Dec 2003, Jeff Garzik wrote:

> hmmm, I don't think $(ARCH) makes the rpm --target strings in all
> cases..

>From rpm man page --target PLATFORM will interpret PLATFORM as
arch-vendor-os and set %_target, %_target_cpu, %_target_os accordingly.
In this case only arch is set, so vendor and os will remain as default.

If you still think it is too implicit, how about change as below? In case
you want set RPM_VENDOR_OS to something like "-unknown-linux".


@@ -258,6 +258,7 @@
 AWK            = awk
 RPM            := $(shell if [ -x "/usr/bin/rpmbuild" ]; then echo
rpmbuild; \
                        else echo rpm; fi)
+RPM_VENDOR_OS  :=
 GENKSYMS       = scripts/genksyms/genksyms
 DEPMOD         = /sbin/depmod
 KALLSYMS       = scripts/kallsyms
@@ -872,7 +873,7 @@
        $(CONFIG_SHELL) $(srctree)/scripts/mkversion >
$(objtree)/.tmp_version;\
        mv -f $(objtree)/.tmp_version $(objtree)/.version;

-       $(RPM) -ta ../$(KERNELPATH).tar.gz
+       $(RPM) --target $(ARCH)$(RPM_VENDOR_OS) -ta ../$(KERNELPATH).tar.gz
        rm ../$(KERNELPATH).tar.gz

 # Brief documentation of the typical targets used


>         Jeff

-yi

