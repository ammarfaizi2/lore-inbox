Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVCZDmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVCZDmh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVCZDmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:42:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43953 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261931AbVCZDl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:41:58 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jason Uhlenkott <jasonuhl@sgi.com>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm3
Date: Fri, 25 Mar 2005 19:40:24 -0800
User-Agent: KMail/1.8
Cc: Len Brown <len.brown@intel.com>, Luck@cthulhu.engr.sgi.com,
       Tony <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <20050325002154.335c6b0b.akpm@osdl.org> <1111803861.19920.91.camel@d845pe> <20050326025704.GE207782@dragonfly.engr.sgi.com>
In-Reply-To: <20050326025704.GE207782@dragonfly.engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_omNRCZhZeucUSzt"
Message-Id: <200503251940.24644.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_omNRCZhZeucUSzt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, March 25, 2005 6:57 pm, Jason Uhlenkott wrote:
> On Fri, Mar 25, 2005 at 09:24:21PM -0500, Len Brown wrote:
> > What bad things happen if you define CONFIG_PM on SN2?
>
> None, other than slightly enlarging the kernel with some
> suspend/resume stuff we don't care about.  It's always been
> unavailable for SN2 builds:
>
> depends on IA64_GENERIC || IA64_DIG || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB
>
> but there doesn't appear to be any particular reason for that other
> than us not needing it (and in fact SN2 systems can run IA64_GENERIC
> kernels with CONFIG_PM enabled without incident).
>
> > Re: CONFIG_ACPI_BOOT
> > I've got a patch that makes it go away -- this looks like
> > a good reason for me to dust it off...  Looks like
> > arch/ia64/Kconfig defines ACPI and then pulls in drivers/acpi/Kconfig,
> > which it should not do - it should look like i386/Kconfig...

Yeah, I noticed that too.  If you've got a patch to clean it up, we should go 
ahead and get it sent off to Tony.

I sent this to linux-ia64 the other day to address these issues.

Jesse

--Boundary-00=_omNRCZhZeucUSzt
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ia64-kconfig-pm-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ia64-kconfig-pm-fix.patch"

===== arch/ia64/Kconfig 1.85 vs edited =====
--- 1.85/arch/ia64/Kconfig	2005-01-28 15:32:25 -08:00
+++ edited/arch/ia64/Kconfig	2005-03-21 09:38:29 -08:00
@@ -328,7 +328,7 @@
 
 config PM
 	bool "Power Management support"
-	depends on IA64_GENERIC || IA64_DIG || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB
+	depends on !IA64_HP_SIM
 	default y
 	help
 	  "Power Management" means that parts of your computer are shut

--Boundary-00=_omNRCZhZeucUSzt--
