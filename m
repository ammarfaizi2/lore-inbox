Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422862AbWHYTns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbWHYTns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWHYTnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:43:47 -0400
Received: from andromeda.dapyr.net ([69.45.6.104]:52361 "EHLO
	andromeda.dapyr.net") by vger.kernel.org with ESMTP
	id S1422878AbWHYTno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:43:44 -0400
Date: Fri, 25 Aug 2006 15:43:38 -0400
From: Konrad Rzeszutek <konradr@us.ibm.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH 1/2] Add SATA support to libsas
Message-ID: <20060825194338.GA6020@andromeda.dapyr.net>
References: <44DBE943.4080303@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DBE943.4080303@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 07:19:47PM -0700, Darrick J. Wong wrote:
> Hook the scsi_host_template functions in libsas to delegate
> functionality to libata when appropriate.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> 
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index b0705ee..76bbb9f 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c

(...)

>  /* ---------- Domain device ---------- */
> @@ -626,4 +634,8 @@ void sas_unregister_devices(struct sas_h
>  
>  void sas_init_dev(struct domain_device *);
>  
> +extern void sas_target_destroy(struct scsi_target *);
> +extern int sas_slave_alloc(struct scsi_device *);
> +extern int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg);
> +

Those should not be 'extern' otherwise the EXPORT_SYMBOL functions 
won't be found when the aic94xx is built as a module.

