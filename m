Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRJZBYY>; Thu, 25 Oct 2001 21:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277006AbRJZBYO>; Thu, 25 Oct 2001 21:24:14 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:9995 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S277005AbRJZBX7>; Thu, 25 Oct 2001 21:23:59 -0400
Date: Thu, 25 Oct 2001 19:26:48 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "David S. Miller" <davem@redhat.com>
Cc: axboe@suse.de, ch@westend.com, harlan@artselect.com,
        linux-kernel@vger.kernel.org
Subject: Re: SCSI tape crashes (was Re: BUG() in asm/pci.h:142 with 2.4.13)
Message-ID: <20011025192648.A13819@vger.timpanogas.org>
In-Reply-To: <20011025131107.C4795@suse.de> <20011025192351.A9823@westend.com> <20011025193248.J4795@suse.de> <20011025.172541.102577469.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011025.172541.102577469.davem@redhat.com>; from davem@redhat.com on Thu, Oct 25, 2001 at 05:25:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,

Is this waht's causing the earlier bug I reported in 2.4.10?  If so 
where is this patch so I can see if it fixes the problem.

Thanks,

Jeff


On Thu, Oct 25, 2001 at 05:25:41PM -0700, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Thu, 25 Oct 2001 19:32:48 +0200
> 
>    On Thu, Oct 25 2001, Christian Hammers wrote:
>    > This patch did not prevent the crash. Again immediately after rewinding the
>    > tape when it began to write. I'll try now the 2.4.12-ac6... and it works.
>    
>    Ok, someone else is meddling with the scatterlist then. I'll take a 2nd
>    look.
> 
> Can people try out this patch?  I believe this will fix the bug.
> 
> --- drivers/scsi/st.c.~1~	Sun Oct 21 02:47:53 2001
> +++ drivers/scsi/st.c	Thu Oct 25 17:23:45 2001
> @@ -3233,6 +3233,7 @@
>  				break;
>  			}
>  		}
> +		tb->sg[0].page = NULL;
>  		if (tb->sg[segs].address == NULL) {
>  			kfree(tb);
>  			tb = NULL;
> @@ -3264,6 +3265,7 @@
>  					tb = NULL;
>  					break;
>  				}
> +				tb->sg[segs].page = NULL;
>  				tb->sg[segs].length = b_size;
>  				got += b_size;
>  				segs++;
> @@ -3337,6 +3339,7 @@
>  			normalize_buffer(STbuffer);
>  			return FALSE;
>  		}
> +		STbuffer->sg[segs].page = NULL;
>  		STbuffer->sg[segs].length = b_size;
>  		STbuffer->sg_segs += 1;
>  		got += b_size;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
