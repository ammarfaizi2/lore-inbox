Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWDXBOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWDXBOc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 21:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWDXBOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 21:14:32 -0400
Received: from rtr.ca ([64.26.128.89]:42979 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751471AbWDXBOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 21:14:31 -0400
Message-ID: <444C2664.7060803@rtr.ca>
Date: Sun, 23 Apr 2006 21:14:12 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [FIX] ide-io: increase timeout value to allow for slave wakeup
References: <200604222359.21652.a1426z@gawab.com> <200604230721.54550.a1426z@gawab.com> <20060422214356.0f8afbcb.akpm@osdl.org> <200604231422.31176.a1426z@gawab.com>
In-Reply-To: <200604231422.31176.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
 ..
> Also apply this one to get rid of this message:
> 
> 	hdb: set_drive_speed_status: status=0x40 { DriveReady }
> 	ide: failed opcode was: unknown
> 
> Maybe someone on the ide list can comment on this first though.
> 
> --- 16/include/linux/ide.h.orig	2006-03-31 19:12:51.000000000 +0300
> +++ 16/include/linux/ide.h	2006-04-23 13:06:32.000000000 +0300
> @@ -120,7 +120,7 @@ typedef unsigned char	byte;	/* used ever
>  #define IDE_BCOUNTL_REG		IDE_LCYL_REG
>  #define IDE_BCOUNTH_REG		IDE_HCYL_REG
>  
> -#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
> +#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==((stat)&(good)))
>  #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
>  #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
>  #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)
> 

Assuming hdb is a CDROM/optical drive, then this change makes sense for that.
But I don't think it is a valid (good) change for regular ATA disks.

A more complex patch is required, one which correctly handles each drive type.

cheers
