Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUG3Dik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUG3Dik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 23:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267567AbUG3Dik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 23:38:40 -0400
Received: from fmr02.intel.com ([192.55.52.25]:55528 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S267582AbUG3Dia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 23:38:30 -0400
Subject: Re: [PATCH][2.4/2.6] Quiesce after changing ACPI idle thread
From: Len Brown <len.brown@intel.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>, Yi Zhu <yi.zhu@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <Pine.LNX.4.58.0407221123480.19190@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407221055391.19190@montezuma.fsmlabs.com>
	 <Pine.LNX.4.58.0407221123480.19190@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: 
Message-Id: <1091158687.9636.21.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Jul 2004 23:38:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied to 2.6.

thanks Zwane.
-Len

On Thu, 2004-07-22 at 11:30, Zwane Mwaikambo wrote:
> (Please apply this patch instead of the previously posted one).
> 
> This patch addresses the following bugzilla bug;
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=1716
> 
> When unloading the processor module we modify the currently used idle
> thread (pm_idle), this causes an oops due to the idle thread text
> being
> unloaded. This should apply to both 2.6 and 2.4.
> 
> Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>
> 
> Index: linux-2.6.8-rc1-mm1/drivers/acpi/processor.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.8-rc1-mm1/drivers/acpi/processor.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 processor.c
> --- linux-2.6.8-rc1-mm1/drivers/acpi/processor.c        14 Jul 2004
> 04:56:25 -0000      1.1.1.1
> +++ linux-2.6.8-rc1-mm1/drivers/acpi/processor.c        20 Jul 2004
> 15:31:46 -0000
> @@ -2372,8 +2372,10 @@ acpi_processor_remove (
>         pr = (struct acpi_processor *) acpi_driver_data(device);
> 
>         /* Unregister the idle handler when processor #0 is removed.
> */
> -       if (pr->id == 0)
> +       if (pr->id == 0) {
>                 pm_idle = pm_idle_save;
> +               synchronize_kernel();
> +       }
> 
>         status = acpi_remove_notify_handler(pr->handle,
> ACPI_DEVICE_NOTIFY,
>                 acpi_processor_notify);
> 

