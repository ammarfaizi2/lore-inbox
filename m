Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWH3WKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWH3WKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWH3WKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:10:53 -0400
Received: from host-84-9-203-25.bulldogdsl.com ([84.9.203.25]:17690 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932174AbWH3WKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:10:52 -0400
Date: Wed, 30 Aug 2006 23:10:19 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: rockeychu <rockeychu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]nand_base: misused maf_id   ( for Linux 2.6.18-RC4 & RC5 )
Message-ID: <20060830221019.GF8907@home.fluff.org>
References: <loom.20060830T073313-489@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20060830T073313-489@post.gmane.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 05:43:08AM +0000, rockeychu wrote:
> When finding manufacturer, changed maf_id not maf_idx, so result is not correct.
> 
> 
> --- linux-2.6.17_org/drivers/mtd/nand/nand_base.c     2006-08-28 
> 12:29:32.000000000 +0800
> +++ linux-2.6.17/drivers/mtd/nand/nand_base.c 2006-08-30 13:09:55.320000000 
> +0800
> @@ -1093,9 +1093,10 @@
> 
>         ret = nand_do_read_ops(mtd, from, &chip->ops);
> 
> +       *retlen = chip->ops.retlen;
> +
>         nand_release_device(mtd);
> 
> -       *retlen = chip->ops.retlen;
>         return ret;
>  }
> 
> @@ -1691,9 +1692,10 @@
> 
>         ret = nand_do_write_ops(mtd, to, &chip->ops);
> 
> +       *retlen = chip->ops.retlen;
> +
>         nand_release_device(mtd);
> 
> -       *retlen = chip->ops.retlen;
>         return ret;
>  }

best to send these to the mtd list.

> @@ -2222,7 +2224,7 @@
>         }
> 
>         /* Try to identify manufacturer */
> -       for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_id++) {
> +       for (maf_idx = 0; nand_manuf_ids[maf_idx].id != 0x0; maf_idx++) {
>                 if (nand_manuf_ids[maf_idx].id == *maf_id)
>                         break;
>         }

This should have already been fixed in the mtd-2.6 git.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
