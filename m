Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277576AbRJ1BeH>; Sat, 27 Oct 2001 21:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277580AbRJ1Bd6>; Sat, 27 Oct 2001 21:33:58 -0400
Received: from peacekeeper.artselect.com ([208.145.206.90]:23680 "EHLO
	davinci.artselect.com") by vger.kernel.org with ESMTP
	id <S277576AbRJ1Bdr>; Sat, 27 Oct 2001 21:33:47 -0400
Date: Sat, 27 Oct 2001 20:34:12 -0500
From: Pete Harlan <harlan@artselect.com>
To: "David S. Miller" <davem@redhat.com>
Cc: axboe@suse.de, ch@westend.com, linux-kernel@vger.kernel.org
Subject: Re: SCSI tape crashes (was Re: BUG() in asm/pci.h:142 with 2.4.13)
Message-ID: <20011027203411.A2210@artselect.com>
In-Reply-To: <20011025131107.C4795@suse.de> <20011025192351.A9823@westend.com> <20011025193248.J4795@suse.de> <20011025.172541.102577469.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011025.172541.102577469.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 05:25:41PM -0700, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Thu, 25 Oct 2001 19:32:48 +0200
> 
>    On Thu, Oct 25 2001, Christian Hammers wrote:
>    > This patch did not prevent the crash. Again immediately after
>    > rewinding the 
>    > tape when it began to write. I'll try now the 2.4.12-ac6... and
>    > it works.
>    
>    Ok, someone else is meddling with the scatterlist then. I'll take a 2nd
>    look.
> 
> Can people try out this patch?  I believe this will fix the bug.

Yessiree, that fixed the scsi tape lockups we had in 2.4.13.

Many thanks,

--Pete harlan@artselect.com


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
