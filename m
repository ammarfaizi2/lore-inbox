Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129417AbRBRTUr>; Sun, 18 Feb 2001 14:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129945AbRBRTUg>; Sun, 18 Feb 2001 14:20:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10502 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129417AbRBRTUa>;
	Sun, 18 Feb 2001 14:20:30 -0500
Date: Sun, 18 Feb 2001 20:19:54 +0100
From: Jens Axboe <axboe@suse.de>
To: John Fremlin <chief@bandits.org>
Cc: johnsom@orst.edu, linux-kernel@vger.kernel.org
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
Message-ID: <20010218201954.B6593@suse.de>
In-Reply-To: <m2k86pnfch.fsf@boreas.yi.org.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2k86pnfch.fsf@boreas.yi.org.>; from chief@bandits.org on Sat, Feb 17, 2001 at 09:56:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17 2001, John Fremlin wrote:
> Specifically, this part:
> 
> @@ -2324,11 +2309,17 @@
>                     sense.ascq == 0x04)
>                         return CDS_DISC_OK;
>  
> +
> +               /*
> +                * If not using Mt Fuji extended media tray reports,
> +                * just return TRAY_OPEN since ATAPI doesn't provide
> +                * any other way to detect this...
> +                */
>                 if (sense.sense_key == NOT_READY) {
> -                       /* ATAPI doesn't have anything that can help
> -                          us decide whether the drive is really
> -                          emtpy or the tray is just open. irk. */
> -                       return CDS_TRAY_OPEN;
> +                       if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
> +                               return CDS_NO_DISC;
> +                       else
> +                               return CDS_TRAY_OPEN;
>                 }
> 
> My tray is open as I type, and it is misreported as CDS_NO_DISC. In
> 2.4.0 it worked fine.

Your drive is broken, the only other valid combination is 0x3a/0x02 which means
no media and tray open. You could try and dump the asc and ascq to see what
your drive reports for the different states.

-- 
Jens Axboe

