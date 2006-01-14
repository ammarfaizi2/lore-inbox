Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423229AbWANAYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423229AbWANAYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423230AbWANAYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:24:47 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:65190 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1423227AbWANAYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:24:45 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Fri, 13 Jan 2006 17:24:41 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <20060106172140.GB19605@lists.us.dell.com> <20060106223932.GB9230@lists.us.dell.com>
In-Reply-To: <20060106223932.GB9230@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601131724.42054.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 15:39, Matt Domsch wrote:
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> ...
> +config DMI
> +       bool
> +       default y

Should we have a way to turn this off?

> diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
> ...
> +dmi_scan-y                     += ../../i386/kernel/dmi_scan.o

Ugh.  I really hate this sort of sharing.  Could dmi_scan.c go in
drivers/firmware/ or something instead?

> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> ...
> +static int __init run_dmi_scan(void)
> +{
> +       dmi_scan_machine();
> +       return 0;
> +}
> +core_initcall(run_dmi_scan);

Shouldn't this be wrapped in "#ifdef CONFIG_DMI"?

Sorry this feedback is so late.  I only looked at it because the
DMI stuff crashes HP sx2000 (and probably sx1000) boxes, probably
because of some memory attribute problem.  So I'll have more
feedback after I debug that ;-)
