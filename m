Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270311AbUJUGMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270311AbUJUGMb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270437AbUJUGMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:12:08 -0400
Received: from fmr12.intel.com ([134.134.136.15]:39106 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S270328AbUJUGKm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:10:42 -0400
Subject: Re: [PATCH 4/5]ACPI PNP driver
From: Li Shaohua <shaohua.li@intel.com>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Adam Belay <ambx1@neo.rr.com>, Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <417750B6.7000409@kolumbus.fi>
References: <1098327568.6132.226.camel@sli10-desk.sh.intel.com>
	 <417750B6.7000409@kolumbus.fi>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1098338594.6132.234.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 14:03:14 +0800
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 14:01, Mika Penttilä wrote:
> Li Shaohua wrote:
> 
> >Hi,
> >This patch provides an ACPI based PNP driver. It is based on Matthieu
> >Castet's original work. With this patch, legacy device drivers (floppy
> >ACPI driver, COM ACPI driver, and ACPI motherboard driver) which
> >directly use ACPI can be removed, since now we have unified PNP
> >interface for legacy devices.
> >
> >Thanks,
> >Shaohua
> >
> >Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> >
> >The patch depends on previous 3 patches.
> >
> >--- 2.6/drivers/pnp/isapnp/Kconfig.stg3	2004-10-18 17:34:17.591712040
> >+0800
> >+++ 2.6/drivers/pnp/isapnp/Kconfig	2004-10-18 17:36:19.173228840 +0800
> >  
> >
> Are you supposed to list here _every_ device to which not to bind? Is 
> this feasible? Maybe take another approach and bind to the "default" 
> acpi pnp driver if no specific driver found ?
> 
> +static char excluded_id_list[] =
> +	"PNP0C0A," /* Battery */
> +	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
> +	"PNP0C09," /* EC */
> +	"PNP0C0B," /* Fan */
> +	"PNP0A03," /* PCI root */
> +	"PNP0C0F," /* Link device */
> +	"PNP0000," /* PIC */
> +	"PNP0100," /* Timer */
> +	;
We can't distinguish if a device has driver. Driver can be loaded as a
module. The devices listed here are mainly be controlled by ACPI core or
can't be controlled by PNP like PIC. This should be a short list.

Thanks,
Shaohua

