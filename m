Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVEARyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVEARyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 13:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVEARyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 13:54:18 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:26546 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262576AbVEARx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 13:53:56 -0400
Date: Sun, 1 May 2005 20:56:06 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Greg KH <gregkh@suse.de>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH 2.6.11.8] SCSI tape security: require CAP_SYS_RAWIO for
 SG_IO etc.
In-Reply-To: <Pine.LNX.4.61.0504301055500.21122@kai.makisara.local>
Message-ID: <Pine.LNX.4.61.0505012051300.6783@kai.makisara.local>
References: <Pine.LNX.4.61.0504301055500.21122@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Kai Makisara wrote:

> The patch at the end is against 2.6.11.8.
> 
> The kernel currently allows any user permitted to access the tape device file
> to send the tape drive commands that may either make the tape drivers internal
...
> filtering. This patch solves the problem for tapes and no more elaborate
> patches are needed. If those are merged to the kernel, this patch can be reversed.
> 
> Signed-off-by: Kai Makisara <kai.makisara@kolumbus.fi>
> 
> --- linux-2.6.11.8/drivers/scsi/st.c	2005-03-03 21:10:36.000000000 +0200
> +++ linux-2.6.11.8-k1/drivers/scsi/st.c	2005-04-30 09:57:21.000000000 +0300
> @@ -3414,7 +3414,10 @@ static int st_ioctl(struct inode *inode,
>  		case SCSI_IOCTL_GET_BUS_NUMBER:
>  			break;
>  		default:
> -			i = scsi_cmd_ioctl(file, STp->disk, cmd_in, p);
> +			if (!capable(CAP_SYS_RAWIO))
> +				i = -EPERM;
> +			else
> +				i = scsi_cmd_ioctl(file, STp->disk, cmd_in, p);
>  			if (i != -ENOTTY)
>  				return i;
>  			break;

Please hold this patch. Testing the corresponding patch for 2.6.12-rc
showed that this is too restrictive. Best to wait until the next versions 
will be reviewed on the linux-scsi list and merged into -rc.

-- 
Kai
