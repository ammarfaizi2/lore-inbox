Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266445AbUFQNjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUFQNjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUFQNjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:39:12 -0400
Received: from [213.146.154.40] ([213.146.154.40]:49835 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266445AbUFQNjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:39:07 -0400
Date: Thu, 17 Jun 2004 14:39:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4]Diskdump Update
Message-ID: <20040617133906.GA32219@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <20040617124957.GA31392@infradead.org> <CCC4546DFE9D94indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CCC4546DFE9D94indou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 10:21:27PM +0900, Takao Indoh wrote:
> On Thu, 17 Jun 2004 13:49:57 +0100, Christoph Hellwig wrote:
> 
> >my old comments for this are still valid, please add the actual dumping
> >methods directly to scsi_host_template instead of a pointer to another
> >method vector, 
> 
> I have already done in the latest patch.

Okay.  Looks like I looked at an older patch, sorry.

> 
> diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.c
> --- linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-04 21:22:20.000000000 +0900
> +++ linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-16 19:34:16.000000000 +0900
> @@ -774,6 +774,10 @@
>  static int	   ahc_linux_bus_reset(Scsi_Cmnd *);
>  static int	   ahc_linux_dev_reset(Scsi_Cmnd *);
>  static int	   ahc_linux_abort(Scsi_Cmnd *);
> +#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
> +static int	   ahc_linux_sanity_check(struct scsi_device *);
> +static void	   ahc_linux_poll(struct scsi_device *);
> +#endif

I'd say implement these unconditionally, it's not _that_ much code..

> >please make it not a module of it's own but part of the
> >scsi code, 
> 
> Do you mean scsi_dump module should be merged with sd_mod.o or scsi_mod.o?

scsi_mod.o.

> I'll try sysfs attribute instead of this.

Okay, thanks.  Or some other way to find by host/channel/target/lun using
scsi_device_lookup.
