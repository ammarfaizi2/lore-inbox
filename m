Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319500AbSIGS3H>; Sat, 7 Sep 2002 14:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319503AbSIGS3H>; Sat, 7 Sep 2002 14:29:07 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36105
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319500AbSIGS3G>; Sat, 7 Sep 2002 14:29:06 -0400
Date: Sat, 7 Sep 2002 11:32:42 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jurriaan <thunder7@xs4all.nl>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: Lite-On cdwriter detected as 12x instead of 40x
In-Reply-To: <20020907175735.GA884@middle.of.nowhere>
Message-ID: <Pine.LNX.4.10.10209071127430.16589-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, does it make it go any faster by changing the caps value?
If so how are you detecting such performance changes?

Given the value discovered is what is reported.
You may need to issue a mode/capablities page change.
You need to as Jens Axboe about this, he is more updated than me.

On Sat, 7 Sep 2002, Jurriaan wrote:

> I have a LITE-ON LTR-40125W cdwriter, which can write at 40x.
> The kernel sees it as 12x. This happens in 2.4.19ac4 up to
> 2.4.20pre4ac2, I didn't test later kernels due to the instable IDE
> situation. It has the latest firmware (WS05) - I'm not sure if bothering
> the manufacturer about this is worth it.
> 
> If I don't pass the drive on to ide-scsi, and patch 
> drivers/ide/ide-cd.c with this small patch,
> 
> +	/* brain-dead LiteOn model reports itself as 12x */
> +	if ((cap != NULL) && (strcmp (drive->id->model, "LITE-ON LTR-40125W") == 0))
> +	  cap->maxspeed = htons(40 * 176);
> 
> all is well, and the kernel reports 40x.
> 
> But I can't find out where to put this for the ide-scsi part.
> All the probing routines in drivers/scsi/ide-cd.c seem to access some
> sort of atapi-buffer that already exists. I can tweak it to display 40x
> in the bootup-messages by changing the idescsi_transform_pc? functions
> in drivers/scsi/ide-cd.c:
> 
> +	                if (strcmp (drive->id->model, "LITE-ON LTR-40125W") == 0)
> +			{
> +				int n = scsi_buf[3] + 4;
> +                   	        scsi_buf[n+8] = scsi_buf[n+14] = (u8) ((40 * 176) >> 8);
> +                   	        scsi_buf[n+9] = scsi_buf[n+15] = (u8) ((40 * 176) & 0xff);
> +				printk("ide-scsi.c: LITE-ON tweak activated\n");
> +			}
> 
> but that doesn't fool cdrdao nor cdrecord - they still think the drive
> is 12x.
> 
> Can anyone help me by pointing out where I should tweak the kernel to
> get correct results when using ide-scsi with my drive?
> 
> Thanks,
> Jurriaan
> -- 
> Remember, Unix on some machines is nUxi.
> GNU/Linux 2.4.19-ac4 SMP/ReiserFS 2x1402 bogomips load av: 0.39 0.28 0.11
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

