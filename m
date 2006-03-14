Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWCNVnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWCNVnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWCNVnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:43:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932496AbWCNVnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:43:25 -0500
Date: Tue, 14 Mar 2006 13:45:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, gregkh@suse.de,
       maule@sgi.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of
 msi_register
Message-Id: <20060314134535.72eb7243.akpm@osdl.org>
In-Reply-To: <44172F0E.6070708@ce.jp.nec.com>
References: <44172F0E.6070708@ce.jp.nec.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jun'ichi Nomura" <j-nomura@ce.jp.nec.com> wrote:
>
> Declare msi_register() in msi.h.
> 
> The patch is especially necessary for ia64 on which most of files
> emit compiler warnings like below:
>   include2/asm/msi.h: In function `ia64_msi_init':
>   include2/asm/msi.h:23: warning: implicit declaration of function `msi_register'
>   In file included from include2/asm/machvec.h:408,
>                  from include2/asm/io.h:70,
>                  from include2/asm/smp.h:20,
>                  from /build/rc6/source/include/linux/smp.h:22,

I wonder why I didn't get that.  Need a better ia64 config I guess.

> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> 
> --- linux-2.6.16-rc6-mm1.orig/include/asm-ia64/msi.h	2006-03-14 13:54:11.000000000 -0500
> +++ linux-2.6.16-rc6-mm1/include/asm-ia64/msi.h	2006-03-14 14:05:26.000000000 -0500
> @@ -15,6 +15,7 @@ static inline void set_intr_gate (int nr
>  #define MSI_TARGET_CPU_SHIFT	4
>  
>  extern struct msi_ops msi_apic_ops;
> +extern int msi_register(struct msi_ops *);
>  
>  /* default ia64 msi init routine */
>  static inline int ia64_msi_init(void)

The offending patch is gregkh-pci-msi-vector-targeting-abstractions.patch.

That patch already adds a declaration for msi_register(), in
drivers/pci/pci.h.  We don't want to add a duplicated declaration like
this.

One option might be to create inclued/linux/msi.h, put this declaration in
there then include <asm/msi.h>.  Possibly some other declarations should be
moved into linux/msi.h as well.
