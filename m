Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265474AbRFVRdj>; Fri, 22 Jun 2001 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbRFVRd3>; Fri, 22 Jun 2001 13:33:29 -0400
Received: from zeus.kernel.org ([209.10.41.242]:63916 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265474AbRFVRdV>;
	Fri, 22 Jun 2001 13:33:21 -0400
Date: Thu, 21 Jun 2001 12:01:59 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
Cc: Trevor Hemsley <Trevor-Hemsley@dial.pipex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: aic7xxx oops with 2.4.5-ac13
Message-ID: <20010621120159.A29684@vger.timpanogas.org>
In-Reply-To: <20010621072142Z264883-17720+6265@vger.kernel.org> <66dq45mv.wl@nisaaru.open.nm.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <66dq45mv.wl@nisaaru.open.nm.fujitsu.co.jp>; from tachino@open.nm.fujitsu.co.jp on Thu, Jun 21, 2001 at 05:08:24PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 05:08:24PM +0900, Tachino Nobuhiro wrote:

Thanks,  

I'll try this patch.

Jeff


> 
> Hello,
> 
> At Thu, 21 Jun 2001 08:15:10,
> Trevor Hemsley wrote:
> > 
> > On Thu, 21 Jun 2001 03:05:02, "Jeff V. Merkey" 
> > <jmerkey@vger.timpanogas.org> wrote:
> > 
> > > Ditto.  I am also seeing this oops calling the sg driver for a 
> > > robotic tape library, and it also seems to happen on 2.4.4.
> > 
> > In my case it appears that it was the symptom of severe bus problems. 
> > About 5 minutes after I posted the initial report I discovered that 
> > the cable from the back of the Nikon to the MO drive had fallen off so
> > the bus was running unterminated. Replugging it fixed teh bus error 
> > and the oops. 
> > 
> > Looks like error handling is all fscked up...
> > 
> 
>   I saw this oops too. The following patch is working for me, but I don't
> know this is a correct fix.
> 
> 
> diff -r -N -u linux.org/drivers/scsi/aic7xxx/aic7xxx_linux.c linux/drivers/scsi/aic7xxx/aic7xxx_linux.c
> --- linux.org/drivers/scsi/aic7xxx/aic7xxx_linux.c	Fri Mar 16 13:47:01 2001
> +++ linux/drivers/scsi/aic7xxx/aic7xxx_linux.c	Fri Mar 16 13:54:34 2001
> @@ -1872,7 +1872,9 @@
>  		break;
>          case AC_BUS_RESET:
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
> -		scsi_report_bus_reset(ahc->platform_data->host, channel - 'A');
> +		if (ahc->platform_data->host) {
> +			scsi_report_bus_reset(ahc->platform_data->host, channel - 'A');
> +		}
>  #endif
>                  break;
>          default:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
