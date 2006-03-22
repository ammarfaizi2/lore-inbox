Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbWCVVCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWCVVCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbWCVVCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:02:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25747
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932729AbWCVVCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:02:13 -0500
Date: Wed, 22 Mar 2006 13:01:57 -0800
From: Greg KH <greg@kroah.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] PCIERR : interfaces for synchronous I/O error detection on driver
Message-ID: <20060322210157.GH12335@kroah.com>
References: <44210D1B.7010806@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44210D1B.7010806@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 05:38:51PM +0900, Hidetoshi Seto wrote:
> This patch proposes new interfaces, that known by few as iochk_*,
> for synchronous I/O error detection on PCI drivers.

Please include the linux-pci mailing list in further discussion of PCI
specific things.

> Index: linux-2.6.16_WORK/include/linux/pci.h
> ===================================================================
> --- linux-2.6.16_WORK.orig/include/linux/pci.h	2006-03-22 
> 14:27:04.000000000 +0900

Your patch is linewrapped :(

> +++ linux-2.6.16_WORK/include/linux/pci.h	2006-03-22 
> 14:41:01.000000000 +0900
> @@ -696,6 +696,21 @@
>  #endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
> 
> 
> +/* PCIERR_CHECK provides additional interfaces for drivers to detect
> + * some IO errors, to support drivers can handle errors properly.
> + * Some archs requiring high-reliability would implement these.
> + */
> +#ifdef HAVE_ARCH_PCIERR_CHECK
> +/* type of iocookie is arch dependent */
> +extern void pcierr_clear(iocookie *cookie, struct pci_dev *dev);
> +extern int pcierr_read(iocookie *cookie);
> +#else
> +typedef int iocookie;
> +static inline void pcierr_clear(iocookie *cookie, struct pci_dev *dev) {}
> +static inline int pcierr_read(iocookie *cookie) { return 0; }
> +#endif

We need to see the code that implements this before we can accept a
header file change.

thanks,

greg k-h
