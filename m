Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286723AbSALN4B>; Sat, 12 Jan 2002 08:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286454AbSALNzw>; Sat, 12 Jan 2002 08:55:52 -0500
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:40871 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S286338AbSALNzk>; Sat, 12 Jan 2002 08:55:40 -0500
Date: Sat, 12 Jan 2002 08:55:39 -0500
From: Willem Riede <wriede@home.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        osst@linux1.onstream.nl
Subject: Re: Patch: linux-2.5.2-pre11/drivers/scsi/osst.c kdev_t compilation fixes
Message-ID: <20020112085539.P6050@linnie.riede.org>
In-Reply-To: <20020112085453.O6050@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020112085453.O6050@linnie.riede.org>; from wriede@home.com on Sat, Jan 12, 2002 at 08:54:53 -0500
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though this makes osst compile, this is not the way I want the
changes made. Also, osst in 2.5 needs updating to match the
version already in 2.4. So I'd prefer this not be applied.

Willem Riede.
-------------
On 2002.01.12 01:17 Adam J. Richter wrote:
> 	Per advice by Jens Axboe and Arnaldo Carvalho de Melo,
> I am holding off on requesting integration most of my other
> drivers/scsi compilation fixes that I posted earlier today, pending
> some related changes that will require updates to those patches.  
> 
> 	However, I think the changes to osst.c should go in now,
> since the changes to that file are only only kdev_t compilation fixes.
> Here is the patch.  If nobody complains, please apply.
> 
> -- 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> 
> --- linux-2.5.2-pre11/drivers/scsi/osst.c	Thu Jan 10 07:59:28 2002
> +++ linux/drivers/scsi/osst.c	Thu Jan 10 07:32:08 2002
> @@ -125,8 +125,8 @@
>  #define OSST_TIMEOUT (200 * HZ)
>  #define OSST_LONG_TIMEOUT (1800 * HZ)
>  
> -#define TAPE_NR(x) (MINOR(x) & ~(128 | ST_MODE_MASK))
> -#define TAPE_MODE(x) ((MINOR(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
> +#define TAPE_NR(x) (minor(x) & ~(128 | ST_MODE_MASK))
> +#define TAPE_MODE(x) ((minor(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
>  
>  /* Internal ioctl to set both density (uppermost 8 bits) and blocksize (lower
>     24 bits) */
> @@ -4103,7 +4103,7 @@
>  		return (-EBUSY);
>  	}
>  	STp->in_use       = 1;
> -	STp->rew_at_close = (MINOR(inode->i_rdev) & 0x80) == 0;
> +	STp->rew_at_close = (minor(inode->i_rdev) & 0x80) == 0;
>  
>  	if (STp->device->host->hostt->module)
>  		 __MOD_INC_USE_COUNT(STp->device->host->hostt->module);
> @@ -4124,7 +4124,7 @@
>  	flags = filp->f_flags;
>  	STp->write_prot = ((flags & O_ACCMODE) == O_RDONLY);
>  
> -	STp->raw = (MINOR(inode->i_rdev) & 0x40) != 0;
> +	STp->raw = (minor(inode->i_rdev) & 0x40) != 0;
>  
>  	/* Allocate a buffer for this user */
>  	need_dma_buffer = STp->restr_dma;
> @@ -5407,7 +5407,7 @@
>  #endif
>  
>  	tpnt->device = SDp;
> -	tpnt->devt = MKDEV(MAJOR_NR, i);
> +	tpnt->devt = mk_kdev(MAJOR_NR, i);
>  	tpnt->dirty = 0;
>  	tpnt->in_use = 0;
>  	tpnt->drv_buffer = 1;  /* Try buffering if no mode sense */
> 
