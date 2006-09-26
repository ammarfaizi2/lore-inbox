Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWIZPuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWIZPuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWIZPuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:50:09 -0400
Received: from mga03.intel.com ([143.182.124.21]:57965 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S932132AbWIZPuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:50:06 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,221,1157353200"; 
   d="scan'208"; a="123180831:sNHT577782618"
From: Jesse Barnes <jesse.barnes@intel.com>
To: eiichiro.oiwa.nm@hitachi.com
Subject: Re: [PATCH 2.6.18] IA64: Add pci_fixup_video into IA64 kernel for embedded VGA
Date: Tue, 26 Sep 2006 08:50:41 -0700
User-Agent: KMail/1.9.4
Cc: akpm@osdl.org, tony.luck@intel.com, greg@kroah.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <XNM1$9$0$4$$3$3$7$A$9002681U4518d9f9@hitachi.com>
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002681U4518d9f9@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609260850.41609.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 26, 2006 12:42 am, eiichiro.oiwa.nm@hitachi.com 
wrote:
> To be compatible with Xorg's handling of PCI, we need pci_fixup_video on
> IA64 platform like x86 platform. There are also machines, which have VGA
> embedded into main board, among IA64 platform. Embedded VGA generally
> don't have PCI ROM, and there are VGA ROM image in System BIOS.
> Therefore, these machines need pci_fixup_video for the sysfs rom.
> pci_fixup_video already exists in x86 Linux kernel. However since this
> function doesn't exist in IA64 kernel, we could not run X server on IA64
> box has embedded-VGA.
>
> I tested pci_fixup_video on IA64 box has embedded-VGA. I confirmed we
> can read VGA BIOS from the sysfs rom regardless of embedded-VGA.

Looks good, Eiichiro, thanks for posting this.

> +#include <linux/delay.h>
> +#include <linux/dmi.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>

For this version, I don't think you need delay.h or dmi.h.  And like Bjorn 
mentioned, this could probably be turned into generic code in drivers/pci 
so we don't have too much duplication with x86 (and like I mentioned, 
x86_64 could probably use this too).

Jesse
