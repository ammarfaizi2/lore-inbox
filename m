Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261540AbSJCOzo>; Thu, 3 Oct 2002 10:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263266AbSJCOzn>; Thu, 3 Oct 2002 10:55:43 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:37644 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261540AbSJCOzh>; Thu, 3 Oct 2002 10:55:37 -0400
Date: Thu, 3 Oct 2002 16:00:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [PATCH] EVMS core 3/4: evms_ioctl.h
Message-ID: <20021003160047.A20462@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kevin Corry <corryk@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100307370503.05904@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02100307370503.05904@boiler>; from corryk@us.ibm.com on Thu, Oct 03, 2002 at 07:37:05AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 07:37:05AM -0500, Kevin Corry wrote:
> @@ -0,0 +1,498 @@

> + *   Copyright (c) International Business Machines  Corp., 2000

> +/*
> + * linux/include/linux/evms.h
> + *
> + * EVMS public kernel header file
> + *
> + */

Same comments as last time apply.

> +#include <linux/hdreg.h>

What is this for?

> +#ifdef __KERNEL__

Nuke this.  kernel he3aders aren't for userspace anyway.

> +#define EVMS_CHECK_MEDIA_CHANGE         _IO(EVMS_MAJOR, EVMS_CHECK_MEDIA_CHANGE_NUMBER)
> +
> +#define EVMS_REVALIDATE_DISK_STRING     "EVMS_REVALIDATE_DISK"
> +#define EVMS_REVALIDATE_DISK            _IO(EVMS_MAJOR, EVMS_REVALIDATE_DISK_NUMBER)

Can't you use normal revalidate/media change operations?

> +
> +#define EVMS_OPEN_VOLUME_STRING         "EVMS_OPEN_VOLUME"
> +#define EVMS_OPEN_VOLUME                _IO(EVMS_MAJOR, EVMS_OPEN_VOLUME_NUMBER)
> +
> +#define EVMS_CLOSE_VOLUME_STRING        "EVMS_CLOSE_VOLUME"
> +#define EVMS_CLOSE_VOLUME               _IO(EVMS_MAJOR, EVMS_CLOSE_VOLUME_NUMBER)

if you need open/close ioctl you got some abstraction wrong..

> +/**
> + * struct evms_sector_io_pkt - sector io ioctl packet definition
> + * @disk_handle:	disk handle of target device
> + * @io_flag:		0 = read, 1 = write
> + * @starting_sector:	disk relative starting sector
> + * @sector_count:	count of sectors
> + * @buffer_address:	user buffer address
> + * @status:		return operation status
> + *
> + * ioctl packet definition for EVMS_SECTOR_IO ioctl
> + **/
> +struct evms_sector_io_pkt {
> +	u64 disk_handle;
> +	s32 io_flag;
> +	u64 starting_sector;
> +	u64 sector_count;
> +	u8 *buffer_address;
> +	s32 status;
> +};

You don't abuse an ioctl to read into a user supplied buffer??
> +/**
> + * struct evms_compute_csum_pkt - compute checksum ioctl packet definition
> + * @buffer_address:
> + * @buffer_size:
> + * @insum:
> + * @outsum:
> + * @status:
> + *
> + * ioctl packet definition for EVMS_COMPUTE_CSUM ioctl
> + **/
> +struct evms_compute_csum_pkt {
> +	u8 *buffer_address;
> +	s32 buffer_size;
> +	u32 insum;
> +	u32 outsum;
> +	s32 status;
> +};

An ioctl to compute a checksum??

