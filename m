Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbUJ1Gj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUJ1Gj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbUJ1GgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:36:20 -0400
Received: from [192.55.52.67] ([192.55.52.67]:57295 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262870AbUJ1GbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:31:24 -0400
Subject: Re: [PATCH 3/5]add .match method for ACPI
From: Len Brown <len.brown@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <1098327565.6132.224.camel@sli10-desk.sh.intel.com>
References: <1098327565.6132.224.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1098945067.5403.4.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Oct 2004 02:31:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied,

thanks,
-Len

On Wed, 2004-10-20 at 22:59, Li Shaohua wrote:
> Hi,
> The idea of the patch is from Bruno Ducrot <ducrot@poupinou.org>'s
> ACPI
> video extension patch. Since the video extension patch hasn't been
> merged and the ACPI PNP driver requires it, I attached it here.
> 
> Thanks,
> Shaohua
> 
> --- 2.6/drivers/acpi/scan.c.stg4        2004-10-18 16:49:57.926042680
> +0800
> +++ 2.6/drivers/acpi/scan.c     2004-10-18 16:57:30.572230000 +0800
> @@ -161,7 +161,7 @@ acpi_bus_get_power_flags (
>         return 0;
>  }
> 
> -static int
> +int
>  acpi_match_ids (
>         struct acpi_device      *device,
>         char                    *ids)
> @@ -314,6 +314,8 @@ acpi_bus_match (
>         struct acpi_device      *device,
>         struct acpi_driver      *driver)
>  {
> +       if (driver && driver->ops.match)
> +               return driver->ops.match(device, driver);
>         return acpi_match_ids(device, driver->ids);
>  }
> 
> @@ -495,9 +497,6 @@ acpi_bus_find_driver (
> 
>         ACPI_FUNCTION_TRACE("acpi_bus_find_driver");
> 
> -       if (!device->flags.hardware_id &&
> !device->flags.compatible_ids)
> -               goto Done;
> -
>         spin_lock(&acpi_device_lock);
>         list_for_each_safe(node,next,&acpi_bus_drivers) {
>                 struct acpi_driver * driver = container_of(node,struct
> acpi_driver,node);
> --- 2.6/include/acpi/acpi_bus.h.stg4    2004-10-18 16:50:31.522935176
> +0800
> +++ 2.6/include/acpi/acpi_bus.h 2004-10-18 16:55:11.474376088 +0800
> @@ -104,6 +104,8 @@ typedef int (*acpi_op_suspend)      (struct a
>  typedef int (*acpi_op_resume)  (struct acpi_device *device, int
> state);
>  typedef int (*acpi_op_scan)    (struct acpi_device *device);
>  typedef int (*acpi_op_bind)    (struct acpi_device *device);
> +typedef int (*acpi_op_match)   (struct acpi_device *device,
> +       struct acpi_driver *driver);
> 
>  struct acpi_device_ops {
>         acpi_op_add             add;
> @@ -115,6 +117,7 @@ struct acpi_device_ops {
>         acpi_op_resume          resume;
>         acpi_op_scan            scan;
>         acpi_op_bind            bind;
> +       acpi_op_match           match;
>  };
> 
>  struct acpi_driver {
> @@ -322,6 +325,7 @@ int acpi_bus_receive_event (struct acpi_
>  int acpi_bus_register_driver (struct acpi_driver *driver);
>  int acpi_bus_unregister_driver (struct acpi_driver *driver);
> 
> +int acpi_match_ids (struct acpi_device *device, char   *ids);
>  int acpi_create_dir(struct acpi_device *);
>  void acpi_remove_dir(struct acpi_device *);
> 
> 
> 
> 

