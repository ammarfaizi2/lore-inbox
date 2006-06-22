Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWFVSTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWFVSTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWFVSTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:19:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751837AbWFVSTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:19:19 -0400
Date: Thu, 22 Jun 2006 14:18:49 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dave Airlie <airlied@linux.ie>, ak@suse.de
Subject: Re: intelfb: enable on x86_64
Message-ID: <20060622181849.GG21582@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>, ak@suse.de
References: <200606200312.k5K3C0uC009812@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606200312.k5K3C0uC009812@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 03:12:00AM +0000, Linux Kernel wrote:
 > commit 0c187addabbaf93512902442b4a90140a21b0ddc
 > tree 40cd618a76474ec9ba2cfde129315c7ebbaf4f9f
 > parent 16109b3f4c1f2635afd32eb6d49348590de2cb25
 > author Dave Airlie <airlied@linux.ie> Thu, 23 Mar 2006 11:20:08 +1100
 > committer Dave Airlie <airlied@linux.ie> Mon, 03 Apr 2006 11:43:28 +1000
 > 
 > intelfb: enable on x86_64
 > 
 > i945G chipsets supports 64-bit.
 > 
 > Signed-off-by: Dave Airlie <airlied@linux.ie>
 > 
 >  drivers/video/Kconfig |    2 +-
 >  1 files changed, 1 insertion(+), 1 deletion(-)
 > 
 > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
 > index f87c017..190adce 100644
 > --- a/drivers/video/Kconfig
 > +++ b/drivers/video/Kconfig
 > @@ -741,7 +741,7 @@ config FB_I810_I2C
 >  
 >  config FB_INTEL
 >  	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
 > -	depends on FB && EXPERIMENTAL && PCI && X86_32
 > +	depends on FB && EXPERIMENTAL && PCI && X86
 >  	select AGP
 >  	select AGP_INTEL
 >  	select FB_MODE_HELPERS

This turned into an unpleasant surprise.
If you select for eg, IOMMU=y and CONFIG_AGP=y, and CONFIG_FB_INTEL=m,
then CONFIG_AGP gets silently turned into a =m, and the build fails with this..

arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_amd64_init'
arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_bridge'
arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_copy_info'

		Dave

-- 
http://www.codemonkey.org.uk
