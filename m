Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWFVSc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWFVSc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWFVScR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:32:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27606 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030350AbWFVSbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:31:53 -0400
Date: Thu, 22 Jun 2006 14:31:40 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>, ak@suse.de
Subject: Re: intelfb: enable on x86_64
Message-ID: <20060622183140.GB5604@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>, ak@suse.de
References: <200606200312.k5K3C0uC009812@hera.kernel.org> <20060622181849.GG21582@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622181849.GG21582@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 02:18:49PM -0400, Dave Jones wrote:

 > If you select for eg, IOMMU=y and CONFIG_AGP=y, and CONFIG_FB_INTEL=m,
 > then CONFIG_AGP gets silently turned into a =m, and the build fails with this..
 > 
 > arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_amd64_init'
 > arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_bridge'
 > arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_copy_info'

This seems to work around it..

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/drivers/video/Kconfig~	2006-06-22 14:27:13.000000000 -0400
+++ linux-2.6.17.noarch/drivers/video/Kconfig	2006-06-22 14:27:27.000000000 -0400
@@ -807,8 +807,8 @@ config FB_I810_I2C
 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
 	depends on FB && EXPERIMENTAL && PCI && X86 && !VGA_NOPROBE
-	select AGP
-	select AGP_INTEL
+	depends on AGP
+	depends on AGP_INTEL
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA

-- 
http://www.codemonkey.org.uk
