Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWCZUFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWCZUFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWCZUFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:05:24 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:1460 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751507AbWCZUFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:05:23 -0500
Date: Sun, 26 Mar 2006 13:05:22 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
Message-ID: <20060326200522.GA3486@parisc-linux.org>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 09:28:28PM +0200, Bodo Eggert wrote:
>          case SCSI_IOCTL_GET_PCI:
>                  return scsi_ioctl_get_pci(sdev, arg);
> +	case SG_GET_SCSI_ID:

You're using the old ioctl name here ...

> +		if (!access_ok(VERIFY_WRITE, arg, sizeof (struct scsi_ioctl_id)))
> +			return -EFAULT;
> +		else {
> +			struct scsi_ioctl_id __user *idp = arg;
> +
> +			__put_user((int) sdev->host->host_no,
> +				   &idp->host_no);

The cast isn't necessary; __put_user casts the argument to the type of
the pointer.

> +			__put_user(0, &idp->unused[0]);
> +			__put_user(0, &idp->unused[1]);

Is it time to repurpose the unused bytes for the 64-bit LUN?

> +struct scsi_ioctl_id { /* used by SCSI_IOCTL_GET_ID ioctl() */
> +    int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2 etc */

tabs instead of spaces?

