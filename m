Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWH0WCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWH0WCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 18:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWH0WCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 18:02:30 -0400
Received: from xenotime.net ([66.160.160.81]:6888 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751190AbWH0WC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 18:02:29 -0400
Date: Sun, 27 Aug 2006 15:05:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>, forrest.zhao@intel.com
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Updated libata acpi patches for GIT HEAD
Message-Id: <20060827150542.7d50213a.rdunlap@xenotime.net>
In-Reply-To: <20060827215032.GG8271@cip.informatik.uni-erlangen.de>
References: <20060827215032.GG8271@cip.informatik.uni-erlangen.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 23:50:32 +0200 Thomas Glanzmann wrote:

> Hello Randy,

Hi,
Please use rdunlap@xenotime.net or randy.dunlap@oracle.com now.

> I have a T60 and use your libata acpi patch which saves/restores the
> taskfile of the disk on hibernation and resume. I wonder if you have an
> updated patch for GIT HEAD because a colleague with a similar notebook
> has to use GIT HEAD to get his soundcard supported. I tried to port it
> myself and there was only one reject which I maybe fixed, but I don't
> intend to try the patch so I don't know:

I don't have a suitable machine for testing.
Forrest Zhao at Intel was picking up continuing work on this patch.

Someone else did a patch update and put that function call in
ata_bus_probe().  See
http://vizzzion.org/stuff/thinkpad-t60/libata-acpi.diff


> @@ -4290,6 +4294,7 @@ int ata_device_resume(struct ata_port *a
>         }
>         if (!ata_dev_present(dev))
>                 return 0;
> +       ata_acpi_exec_tfs(ap);
>         if (dev->class == ATA_DEV_ATA)
>                 ata_start_drive(ap, dev);
> 
> in libata-core.c. This function ata_device_resume does no longer exist in GIT
> HEAD, so I modified the following function ata_scsi_device_resume instead:
> 
> diff -ruN linux-2.6.orig/drivers/scsi/libata-scsi.c linux-2.6/drivers/scsi/libata-scsi.c
> --- linux-2.6.orig/drivers/scsi/libata-scsi.c   2006-08-27 20:01:34.000000000 +0200
> +++ linux-2.6/drivers/scsi/libata-scsi.c        2006-08-27 23:13:00.000000000 +0200
> @@ -499,6 +499,8 @@
>             sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
>                 goto out_unlock;
> 
> +       ata_acpi_exec_tfs(ap);
> +
>         /* request resume */
>         action = ATA_EH_RESUME;
>         if (sdev->sdev_gendev.power.power_state.event == PM_EVENT_SUSPEND)


---
~Randy
