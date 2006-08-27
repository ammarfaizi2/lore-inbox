Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWH0BmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWH0BmD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 21:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWH0BmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 21:42:02 -0400
Received: from hera.kernel.org ([140.211.167.34]:49877 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750880AbWH0BmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 21:42:00 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: "Om Narasimhan" <om.turyx@gmail.com>
Subject: Re: memory leak fix in acpi_memhotplug.c, kmalloc to kzalloc conversion.
Date: Sat, 26 Aug 2006 21:43:36 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
References: <6b4e42d10608261721h7807e45h6f20a2327f368719@mail.gmail.com>
In-Reply-To: <6b4e42d10608261721h7807e45h6f20a2327f368719@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608262143.37390.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 August 2006 20:21, Om Narasimhan wrote:
> Hi,
> This patch fixes one memory leak in drivers/acpi/acpi_memhotplug.c
> Replaces all kmalloc() calls succeeded by memset() to kzalloc() calls.
> Applies cleanly to 2.6.18-rc4. Compile tested.

Compile testing is more effective is you use a .config that
builds each of the source files changed.

> Patch starts here.
> 
> 
>  drivers/acpi/ac.c              |    4 +---
>  drivers/acpi/acpi_memhotplug.c |   14 +++++---------
>  drivers/acpi/asus_acpi.c       |    3 +--
>  drivers/acpi/battery.c         |   13 +++----------
>  drivers/acpi/bus.c             |    3 +--
>  drivers/acpi/button.c          |    4 +---
>  drivers/acpi/container.c       |    4 +---
>  drivers/acpi/ec.c              |   20 +++++---------------
>  drivers/acpi/fan.c             |    3 +--
>  drivers/acpi/i2c_ec.c          |    8 ++------
>  drivers/acpi/osl.c             |    2 +-
>  drivers/acpi/pci_bind.c        |   21 +++++----------------
>  drivers/acpi/pci_irq.c         |   16 +++-------------
>  drivers/acpi/pci_link.c        |    6 ++----
>  drivers/acpi/pci_root.c        |    3 +--
>  drivers/acpi/power.c           |    4 +---
>  drivers/acpi/processor_core.c  |    4 +---
>  drivers/acpi/sbs.c             |    4 +---
>  drivers/acpi/thermal.c         |   13 +++----------
>  drivers/acpi/utils.c           |    4 +---
>  20 files changed, 40 insertions(+), 113 deletions(-)

Please direct patches touching drivers/acpi to me, cc linux-acpi@vger.kernel.org

> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 96309b9..72738a5 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -221,11 +221,9 @@ static int acpi_ac_add(struct acpi_devic
>  	if (!device)
>  		return -EINVAL;
> 
> -	ac = kmalloc(sizeof(struct acpi_ac), GFP_KERNEL);
> +	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
>  	if (!ac)
>  		return -ENOMEM;
> -	memset(ac, 0, sizeof(struct acpi_ac));
> -
>  	ac->device = device;
>  	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
>  	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index b0d4b14..eb8a5da 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -297,6 +297,7 @@ static int acpi_memory_disable_device(st
>  	 * Ask the VM to offline this memory range.
>  	 * Note: Assume that this function returns zero on success
>  	 */
> +	struct acpi_memory_info *info, *n;

What tree is this patch against?
This line is already present (above the comment) in 2.6.18-rc4.

thanks,
-Len

