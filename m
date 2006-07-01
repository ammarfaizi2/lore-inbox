Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751894AbWGASlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWGASlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWGASlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:41:25 -0400
Received: from xenotime.net ([66.160.160.81]:49105 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751277AbWGASlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:41:25 -0400
Date: Sat, 1 Jul 2006 11:44:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: akpm@osdl.org, erik_frederiksen@pmc-sierra.com,
       linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: IS_ERR Threshold Value
Message-Id: <20060701114409.ed320be0.rdunlap@xenotime.net>
In-Reply-To: <20060629181013.GA18777@linux-mips.org>
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>
	<20060628140825.692f31be.rdunlap@xenotime.net>
	<20060629181013.GA18777@linux-mips.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 19:10:13 +0100 Ralf Baechle wrote:

> On Wed, Jun 28, 2006 at 02:08:25PM -0700, Randy.Dunlap wrote:
> 
> > Hi,
> > Peter Anvin mentioned just a few days ago that this threshold value
> > should be 4095 for all arches.  I think we need to get that patch
> > done & submitted to Andrew for -mm.
> 
> So here the patch is:
> 
>  o Raise the maximum error number in IS_ERR_VALUE to 4095.
>  o Make that number available as a new constant MAX_ERRNO.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/include/linux/err.h b/include/linux/err.h
> index ff71d2a..cd3b367 100644
> --- a/include/linux/err.h
> +++ b/include/linux/err.h
> @@ -13,7 +13,9 @@ #include <asm/errno.h>
>   * This should be a per-architecture thing, to allow different
>   * error and pointer decisions.
>   */
> -#define IS_ERR_VALUE(x) unlikely((x) > (unsigned long)-1000L)
> +#define MAX_ERRNO	4095
> +
> +#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
>  
>  static inline void *ERR_PTR(long error)
>  {

Are changes also needed in asm-*/unistd.h::syscall_return() macros?
or is syscall_return() just not used?

e.g.,
arm26 uses -125 to detect error
arm uses -129 to detect error
frv uses -4095 to detect error
i386 uses -129
h8300, m32r, s390, sh64, v850 use -125
m68k[nommu] uses -125
sh uses -124
x86_64 uses -127


---
~Randy
