Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVGFHsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVGFHsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVGFHsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:48:12 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:9999 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262147AbVGFGZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:25:55 -0400
Date: Wed, 06 Jul 2005 15:26:27 +0900 (JST)
Message-Id: <20050706.152627.68274440.yoshfuji@linux-ipv6.org>
To: seto.hidetoshi@jp.fujitsu.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       tony.luck@intel.com, linas@austin.ibm.com, benh@kernel.crashing.org,
       tlnguyen@snoqualmie.dp.intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev@ozlabs.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6.13-rc1 01/10] IOCHK interface for I/O error
 handling/detecting
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <42CB63B2.6000505@jp.fujitsu.com>
References: <42CB63B2.6000505@jp.fujitsu.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <42CB63B2.6000505@jp.fujitsu.com> (at Wed, 06 Jul 2005 13:53:06 +0900), Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> says:

> Index: linux-2.6.13-rc1/lib/iomap.c
> ===================================================================
> --- linux-2.6.13-rc1.orig/lib/iomap.c
> +++ linux-2.6.13-rc1/lib/iomap.c
> @@ -230,3 +230,9 @@ void pci_iounmap(struct pci_dev *dev, vo
>   }
>   EXPORT_SYMBOL(pci_iomap);
>   EXPORT_SYMBOL(pci_iounmap);
> +
> +#ifndef HAVE_ARCH_IOMAP_CHECK
> +/* Since generic funcs are inlined and defined in header, just export */
> +EXPORT_SYMBOL(iochk_clear);
> +EXPORT_SYMBOL(iochk_read);
> +#endif
> Index: linux-2.6.13-rc1/include/asm-generic/iomap.h
> ===================================================================
> --- linux-2.6.13-rc1.orig/include/asm-generic/iomap.h
> +++ linux-2.6.13-rc1/include/asm-generic/iomap.h
:
> + */
> +#ifdef HAVE_ARCH_IOMAP_CHECK
> +extern void iochk_init(void);
> +extern void iochk_clear(iocookie *cookie, struct pci_dev *dev);
> +extern int iochk_read(iocookie *cookie);
> +#else
> +static inline void iochk_init(void) {}
> +static inline void iochk_clear(iocookie *cookie, struct pci_dev *dev) {}
> +static inline int iochk_read(iocookie *cookie) { return 0; }
> +#endif
> +
>   #endif

It looks strange to me.
You cannot export "static inline" functions.
You can export iochk_{init,clear,read} only
if HAVE_ARCH_IOMAP_CHECK is defined.

--yoshfuji
