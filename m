Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWEBQWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWEBQWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWEBQWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:22:20 -0400
Received: from xenotime.net ([66.160.160.81]:37825 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964915AbWEBQWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:22:19 -0400
Date: Tue, 2 May 2006 09:24:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: akpm@osdl.org, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as
 unused-for-removal-soon
Message-Id: <20060502092440.91fe8797.rdunlap@xenotime.net>
In-Reply-To: <1146581587.32045.41.camel@laptopd505.fenrus.org>
References: <1146581587.32045.41.camel@laptopd505.fenrus.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 May 2006 16:53:07 +0200 Arjan van de Ven wrote:

> Hi,
> As discussed on lkml before; the patch with the infrastructure to deprecate unused symbols
> 
> This is patch one in a series of 17; to not overload lkml the other 16 will be mailed direct;
> people who want to see them all can see them at http://www.fenrus.org/unused
> 
> 
> 
> This patch temporarily adds EXPORT_UNUSED_SYMBOL and EXPORT_UNUSED_SYMBOL_GPL.
> These will be used as transition measure for symbols that aren't used in the 
> kernel and are on the way out. When a module uses such a symbol, a warning
> is printk'd at modprobe time.
> 
> The main reason for removing unused exports is size: eacho export takes roughly
> between 100 and 150 bytes of kernel space in the binary. This patch gives
> users the option to immediately get this size gain via a config option.

Do the exports take any space at runtime in RAM?
or is this only on-disk or wherever the kernel image lives?


> It would be nice to at least get this infrastructure into 2.6.17 even if
> the rest of this series won't get there.

> --- linux-2.6.17-rc3-mm1-unused.orig/Documentation/feature-removal-schedule.txt
> +++ linux-2.6.17-rc3-mm1-unused/Documentation/feature-removal-schedule.txt
> @@ -22,6 +22,16 @@ Who:	Adrian Bunk <bunk@stusta.de>
>  
>  ---------------------------
>  
> +What:	Unused EXPORT_SYMBOL/EXPORT_SYMBOL_GPL exports
> +	(temporary transition config option provided until then)
> +	The transition config option will also be removed at the same time.
> +When:	before 2.6.19
> +Why:	Unused symbols are both increasing the size of the kernel binary
> +	and are often a sign of "wrong API"
> +Who:	Arjan van de Ven <arjan@linux.intel.com>


scsi patch comments (only one that I have seen) say:
+EXPORT_UNUSED_SYMBOL(scsi_print_status); /* removal in 2.6.19 */

and When: above says "before 2.6.19".  Those don't agree.
Please fix.  Thanks.

---
~Randy
