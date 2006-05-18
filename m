Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWERUw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWERUw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWERUw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:52:58 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:15378 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751198AbWERUw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:52:58 -0400
Date: Thu, 18 May 2006 22:53:10 +0200
From: Jean Delvare <jdelvare@nerim.net>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu
Subject: Re: [PATCH 07/22] [PATCH] smbus unhiding kills thermal management
Message-Id: <20060518225310.eea9b93d.jdelvare@nerim.net>
In-Reply-To: <20060517221358.617565000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
	<20060517221358.617565000@sous-sol.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> Do not enable the SMBus device on Asus boards if suspend is used.  We do
> not reenable the device on resume, leading to all sorts of undesirable
> effects, the worst being a total fan failure after resume on Samsung P35
> laptop.
> 
> Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

As the i2c and hwmon maintainer, I wish to thank Carl-Daniel for his
good work on this, and this patch is
Signed-off-by: Jean Delvare <khali@linux-fr.org>

Note that this patch should fix bug #6449.

> ---
> 
>  drivers/pci/quirks.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.16.16.orig/drivers/pci/quirks.c
> +++ linux-2.6.16.16/drivers/pci/quirks.c
> @@ -861,6 +861,7 @@ static void __init quirk_eisa_bridge(str
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge );
>  
> +#ifndef CONFIG_ACPI_SLEEP
>  /*
>   * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
>   * is not activated. The myth is that Asus said that they do not want the
> @@ -872,8 +873,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
>   * bridge. Unfortunately, this device has no subvendor/subdevice ID. So it 
>   * becomes necessary to do this tweak in two steps -- I've chosen the Host
>   * bridge as trigger.
> + *
> + * Actually, leaving it unhidden and not redoing the quirk over suspend2ram
> + * will cause thermal management to break down, and causing machine to
> + * overheat.
>   */
> -static int __initdata asus_hides_smbus = 0;
> +static int __initdata asus_hides_smbus;
>  
>  static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
>  {
> @@ -1008,6 +1013,8 @@ static void __init asus_hides_smbus_lpc_
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
>  
> +#endif
> +
>  /*
>   * SiS 96x south bridge: BIOS typically hides SMBus device...
>   */

-- 
Jean Delvare
