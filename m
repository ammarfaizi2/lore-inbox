Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTEBFoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 01:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTEBFoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 01:44:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60945 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261801AbTEBFoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 01:44:11 -0400
Date: Fri, 2 May 2003 07:56:17 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Aic7xxx and Aic79xx Driver Updates
Message-ID: <20030502055617.GB20977@alpha.home.local>
References: <1866260000.1051828092@aslan.btc.adaptec.com> <20030502001758.GA20977@alpha.home.local> <700140000.1051849531@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700140000.1051849531@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 10:25:31PM -0600, Justin T. Gibbs wrote:
 
> Can you try with this patch?  It seems I forgot to pull part of a change
> from the aic79xx driver into the aic7xxx driver.  This could easily cause
> a lock order reversal. <sigh>

Congratulations, Justin, you just spotted it !

I cannot hang it anymore. It supported an fsck and the make -j dep.
I'm happy, I'll be able to reintegrate your updates to my tree !
I just have changed one typo for it to compile :

> --- /tmp/tmp.29873.2	2003-05-01 22:21:54.000000000 -0600
> +++ /home/gibbs/bk/linux-2.4/drivers/scsi/aic7xxx/aic7xxx_osm.h	2003-05-01 22:21:10.000000000 -0600
> @@ -745,7 +746,8 @@
>  ahc_midlayer_entrypoint_unlock(struct ahc_softc *ahc, unsigned long *flags)
>  {
>  #if AHC_SCSI_HAS_HOST_LOCK == 0
> -	ahc_unlock(ahc, flags);
> +	spin_unlock(&ahd->platform_data->spin_lock);

                    ^^^^ this one is in fact &ahc->platform_data...

Thanks ;-)
Willy

