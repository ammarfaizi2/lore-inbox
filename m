Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267687AbUHENnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbUHENnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267684AbUHENnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:43:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:6291 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267687AbUHENlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:41:53 -0400
Date: Thu, 5 Aug 2004 15:39:14 +0200
From: Olaf Hering <olh@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Stuart_Hayes@Dell.com,
       whbeers@mbio.ncsu.edu, Gary_Lerhaupt@Dell.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
Message-ID: <20040805133914.GA8844@suse.de>
References: <7A8F92187EF7A249BF847F1BF4903C046304CF@ausx2kmpc103.aus.amer.dell.com> <20040713145628.27ae43e7@lembas.zaitcev.lan> <40F46A7F.5000703@pacbell.net> <20040715093704.GA30351@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040715093704.GA30351@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Jul 15, Olaf Hering wrote:

>  On Tue, Jul 13, David Brownell wrote:
> 
> > Instead, how about:  (a) longer timeout, 5 seconds to match OHCI's
> > absurdly long default there; (b) change that "handoff failed" message
> > to add "continuing anyway"; and (c) return 0 as you do, which I'm
> > expecting is the key part of that patch.

David, what is the status with this bios problem?
Can a patch like this patch go in?
What could we lose if the error is ignored?

> diff -purN linux-2.6.8-rc1-bk3.bios-handoff/drivers/usb/host/ehci-hcd.c linux-2.6.8-rc1-bk3/drivers/usb/host/ehci-hcd.c
> --- linux-2.6.8-rc1-bk3.bios-handoff/drivers/usb/host/ehci-hcd.c	2004-07-15 11:24:14.000000000 +0200
> +++ linux-2.6.8-rc1-bk3/drivers/usb/host/ehci-hcd.c	2004-07-15 11:32:28.463930957 +0200
> @@ -303,9 +303,11 @@ static int bios_handoff (struct ehci_hcd
>  			pci_read_config_dword(pdev, where, &cap);
>  		} while ((cap & (1 << 16)) && msec);
>  		if (cap & (1 << 16)) {
> -			ehci_err (ehci, "BIOS handoff failed (%d, %04x)\n",
> +			ehci_err (ehci, "BIOS handoff failed (%d, %04x)\n"
> +				" Devices connected to this controller will not work correctly.\n"
> +				" Complain to your BIOS vendor.\n", /* Really! */
>  				where, cap);
> -			return 1;
> +			return 0;
>  		} 
>  		ehci_dbg (ehci, "BIOS handoff succeeded\n");
>  	}

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
