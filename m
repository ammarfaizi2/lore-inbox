Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWARR3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWARR3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWARR3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:29:53 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:51087 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751393AbWARR3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:29:52 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Wed, 18 Jan 2006 10:29:46 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <200601131724.42054.bjorn.helgaas@hp.com> <200601171717.03192.bjorn.helgaas@hp.com>
In-Reply-To: <200601171717.03192.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181029.46352.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 17:17, Bjorn Helgaas wrote:
>> But it's a start, and maybe the consolidation could be done later.
> 
> Index: work-mm3/arch/i386/kernel/dmi_scan.c
> ===================================================================
> --- work-mm3.orig/arch/i386/kernel/dmi_scan.c	2006-01-17 15:18:42.000000000 -0700
> +++ work-mm3/arch/i386/kernel/dmi_scan.c	2006-01-17 16:58:11.000000000 -0700
> @@ -39,9 +39,18 @@
>  			    void (*decode)(struct dmi_header *))
>  {
>  	u8 *buf, *data;
> -	int i = 0;
> +	int iomem = 1, i = 0;
>  		
> -	buf = dmi_ioremap(base, len);
> +	if (efi_enabled) {
> +		if (efi_mem_attributes(base & EFI_MEMORY_WB)) {

Ouch, ignore this patch if you haven't already.  The above is
parenthesized wrong.

Matt, what's your opinion on proceeding?  I know you want to get
the DMI stuff in distros.  I'm looking at reworking ioremap to
hide all this stuff, but that'll be a bigger change and may be
harder to get into distro releases.

For upstream, the ioremap rework sounds like the way to go, but
I don't know which the distros would prefer for updates.
