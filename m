Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265444AbSJaXay>; Thu, 31 Oct 2002 18:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265459AbSJaXay>; Thu, 31 Oct 2002 18:30:54 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.149]:23518 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S265444AbSJaXax>; Thu, 31 Oct 2002 18:30:53 -0500
X-Biglobe-Sender: <t-kouchi@mvf.biglobe.ne.jp>
Date: Thu, 31 Oct 2002 15:37:16 -0800
From: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
To: greg@kroah.com, andrew.grover@intel.com
Subject: Re: bare pci configuration access functions ?
Cc: jung-ik.lee@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021031221136.GC10689@kroah.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A493@orsmsx119.jf.intel.com> <20021031221136.GC10689@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.04
Message-Id: <20021101083717.IAAOC0A82650.6C9EC293@mvf.biglobe.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002 14:11:36 -0800
Greg KH <greg@kroah.com> wrote:

> But even then, you are building up a few pci structures yourself to talk
> to the pci device.  In looking at the few places you call this function,
> is there any reason that acpi_ex_pci_config_space_handler() can't just
> call pci_bus_* itself, instead of having to go through
> acpi_os_read_pci_configuration()?  If so, the one other usage of the
> acpi_os_read_pci_configuration() can cause that function to be
> simplified a lot.

That's because of Linux port of ACPI CA structure.
ACPI CA divides the acpi driver into OS independent part and os dependent
part.  acpi_ex_pci_config_space_handler exists in OS-independent
part and acpi_os_read_pci_configuration exists in OS-dependent
part.  The OS independent part is shared with other OSes, while
OS dependent part (acpi_os_xxx functions) are Linux specific.

That's the way ACPI driver designers took and Linux can benefit
from other OS's feedback in OS-independent part.

> Anyway, this is a nice diversion from the real problem here, for 2.4,
> should I just backport the pci_ops changes which will allow pci
> hotplugging to work again on ia64, or do we want to do something else?

It would be great if we had the same 2.5 functions in 2.4.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>

