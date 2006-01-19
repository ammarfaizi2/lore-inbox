Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422678AbWASWYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbWASWYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWASWYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:24:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422678AbWASWYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:24:18 -0500
Date: Thu, 19 Jan 2006 17:23:50 -0500
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: EDAC config cleanup
Message-ID: <20060119222350.GU21663@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
References: <20060119221006.GA31404@redhat.com> <Pine.LNX.4.58.0601191411560.11660@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601191411560.11660@shark.he.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 02:12:11PM -0800, Randy.Dunlap wrote:

 > > +	depends on EDAC_MM_EDAC && PCI X86_32
 >                                       ^ && ???

Gah. Of course.  (That'll teach me to not test 'obvious' patches :)
Here it is again, unborked. (tested with make ARCH=x86_64 menuconfig)


The AMD76x chipsets aren't used in 64-bit, so don't
offer the driver to the user.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/drivers/edac/Kconfig~	2006-01-19 17:00:16.000000000 -0500
+++ linux-2.6.15.noarch/drivers/edac/Kconfig	2006-01-19 17:03:33.000000000 -0500
@@ -46,7 +46,7 @@ config EDAC_MM_EDAC
 
 config EDAC_AMD76X
 	tristate "AMD 76x (760, 762, 768)"
-	depends on EDAC_MM_EDAC  && PCI
+	depends on EDAC_MM_EDAC && PCI && X86_32
 	help
 	  Support for error detection and correction on the AMD 76x
 	  series of chipsets used with the Athlon processor.
