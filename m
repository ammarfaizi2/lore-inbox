Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUKFLt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUKFLt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 06:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbUKFLt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 06:49:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59914 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261369AbUKFLtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 06:49:21 -0500
Date: Sat, 6 Nov 2004 12:48:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Len Brown <len.brown@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
Message-ID: <20041106114844.GK1295@stusta.de>
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099707007.13834.1969.camel@d845pe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 09:10:08PM -0500, Len Brown wrote:
> On Fri, 2004-11-05 at 16:50, Adrian Bunk wrote:
> > The patch below completely removes 7 functions that were
> > EXPORT_SYMBOL'ed but had exactly zero users in the kernel and makes
> > another one that was previously EXPORT_SYMBOL'ed static.
> > 
> > It also removes another unused global function to completely remove
> > drivers/acpi/hardware/hwtimer.c which contained no function used
> > anywhere in the kernel.
> > 
> > Please comment on whether this patch is correct or whether in-kernel
> > users of these functions are pending.
> > 
> > 
> > diffstat output:
> >  drivers/acpi/acpi_ksyms.c        |    8 -
> >  drivers/acpi/events/evxfevnt.c   |  191 -----------------------------
> >  drivers/acpi/hardware/Makefile   |    2
> >  drivers/acpi/hardware/hwtimer.c  |  200
> > -------------------------------
> >  drivers/acpi/resources/rsxface.c |   52 --------
> >  drivers/acpi/scan.c              |    6
> >  drivers/acpi/utilities/utxface.c |   89 -------------
> >  include/acpi/achware.h           |   17 --
> >  include/acpi/acpi_bus.h          |    1
> >  include/acpi/acpixf.h            |   24 ---
> >  10 files changed, 6 insertions(+), 584 deletions(-)
> 
> No, I can't apply this one as-is.
> Some of these routines are not called now
> simply because Linux/ACPI is evolving and we don't
> yet take advantage of some of the things supported
> by ACPICA core we use.

I understand this, that's why I asked for comments on this patch.

But it seems a bit strange for me that e.g. the file hwtimer.c was added 
nearly three years ago and exports functions - but currently has exactly 
zero users. One effect is a needless code bloat for every single user 
with CONFIG_ACPI_INTERPRETER=y.

Removing unused global functions is a pretty cheap way to get the kernel 
smaller without any loss of functionality. Please check which of the 
functions touched in my patch will actually be used in the foreseeable 
future (if it would e.g. take another three years until hwtimer.c will 
be used, it might be better to re-add it when it will actually be used).

> thanks,
> -Len

cu
Adrian

BTW: ACPI has tons of other unused global functions.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

