Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310142AbSCFTs5>; Wed, 6 Mar 2002 14:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310144AbSCFTss>; Wed, 6 Mar 2002 14:48:48 -0500
Received: from dialin-145-254-214-078.arcor-ip.net ([145.254.214.78]:59791
	"EHLO duron.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S310142AbSCFTsf>; Wed, 6 Mar 2002 14:48:35 -0500
Date: Wed, 6 Mar 2002 20:48:26 +0100
From: Dominik Kubla <kubla@sciobyte.de>
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
Message-ID: <20020306194826.GB26866@duron.intern.kubla.de>
In-Reply-To: <3C864F07.8050806@linkvest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C864F07.8050806@linkvest.com>
User-Agent: Mutt/1.3.27i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 06:16:55PM +0100, Jean-Eric Cuendet wrote:
[...]
> 			len += sprintf(page + len,
> - 
> 				"(%u,%u):(%u,%u,%u,%u,%u) ",
> - 
> 				major, disk,
> - 
> 				kstat.dk_drive[major][disk],
> - 
> 				kstat.dk_drive_rio[major][disk],
> - 
> 				kstat.dk_drive_rblk[major][disk],
> - 
> 				kstat.dk_drive_wio[major][disk],
> - 
> 				kstat.dk_drive_wblk[major][disk]
> - 
> 		);
> - 
> 	}
> - 
> }
> +    for (i = 0; i < kstat_devices_current_index; i++)
> +    {
> +        kstat_block_io* stat = &kstat_devices_array[i];
> +        len += sprintf( page + len, "(%u,%u):(%u,%u,%u,%u,%u) ",
> +                        stat->major, stat->minor,
> +                        stat->io,
> +                        stat->rio,
> +                        stat->wio,
> +                        stat->rblk,
> +                        stat->wblk );
> +    }
> 
>  	len += sprintf(page + len,
> 
>  		"\nctxt %u\n"

You are changing the order of the fields in /proc/stat. That breaks
compatibility.

Dominik Kubla
-- 
ScioByte GmbH    Zum Schiersteiner Grund 2     55127 Mainz (Germany)
Phone: +49 700 724 629 83                    Fax: +49 700 724 629 84
1024D/717F16BB    A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
