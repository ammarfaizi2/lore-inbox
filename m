Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWHXP3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWHXP3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWHXP3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:29:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34066 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965068AbWHXP3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:29:38 -0400
Date: Thu, 24 Aug 2006 17:29:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060824152937.GK19810@stusta.de>
References: <32640.1156424442@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32640.1156424442@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 02:00:42PM +0100, David Howells wrote:
>...
> +config BLOCK
> +       bool "Enable the block layer"

	bool "Enable the block layer" depends on EMBEDDED

> +       default y
> +       help
>...
> --- a/drivers/ieee1394/Kconfig
> +++ b/drivers/ieee1394/Kconfig
> @@ -122,7 +122,7 @@ config IEEE1394_VIDEO1394
>  
>  config IEEE1394_SBP2
>  	tristate "SBP-2 support (Harddisks etc.)"
> -	depends on IEEE1394 && SCSI && (PCI || BROKEN)
> +	depends on IEEE1394 && BLOCK && SCSI && (PCI || BROKEN)
>  	help
>  	  This option enables you to use SBP-2 devices connected to your IEEE
>  	  1394 bus.  SBP-2 devices include harddrives and DVD devices.
> diff --git a/drivers/infiniband/ulp/iser/Kconfig b/drivers/infiniband/ulp/iser/Kconfig
> index fead87d..f945953 100644
> --- a/drivers/infiniband/ulp/iser/Kconfig
> +++ b/drivers/infiniband/ulp/iser/Kconfig
> @@ -1,6 +1,6 @@
>  config INFINIBAND_ISER
>  	tristate "ISCSI RDMA Protocol"
> -	depends on INFINIBAND && SCSI
> +	depends on INFINIBAND && BLOCK && SCSI
>  	select SCSI_ISCSI_ATTRS
>  	---help---
>  	  Support for the ISCSI RDMA Protocol over InfiniBand.  This
> diff --git a/drivers/infiniband/ulp/srp/Kconfig b/drivers/infiniband/ulp/srp/Kconfig
> index 8fe3be4..63d7d5a 100644
> --- a/drivers/infiniband/ulp/srp/Kconfig
> +++ b/drivers/infiniband/ulp/srp/Kconfig
> @@ -1,6 +1,6 @@
>  config INFINIBAND_SRP
>  	tristate "InfiniBand SCSI RDMA Protocol"
> -	depends on INFINIBAND && SCSI
> +	depends on INFINIBAND && BLOCK && SCSI
>  	---help---
>  	  Support for the SCSI RDMA Protocol over InfiniBand.  This
>  	  allows you to access storage devices that speak SRP over
>...
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
>...
> @@ -43,7 +45,7 @@ comment "SCSI support type (disk, tape, 
>  
>  config BLK_DEV_SD
>  	tristate "SCSI disk support"
> -	depends on SCSI
> +	depends on SCSI && BLOCK
>  	---help---
>  	  If you want to use SCSI hard disks, Fibre Channel disks,
>  	  USB storage or the SCSI or parallel port version of
> @@ -98,7 +100,7 @@ config CHR_DEV_OSST
>  
>  config BLK_DEV_SR
>  	tristate "SCSI CDROM support"
> -	depends on SCSI
> +	depends on SCSI && BLOCK
>  	---help---
>  	  If you want to use a SCSI or FireWire CD-ROM under Linux,
>  	  say Y and read the SCSI-HOWTO and the CDROM-HOWTO at
> @@ -473,7 +475,7 @@ source "drivers/scsi/megaraid/Kconfig.me
>  
>  config SCSI_SATA
>  	tristate "Serial ATA (SATA) support"
> -	depends on SCSI
> +	depends on SCSI && BLOCK
>  	help
>  	  This driver family supports Serial ATA host controllers
>  	  and devices.
>...

Unless the dependency of SCSI on BLOCK you introduce should go away
these are not required.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

