Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbTBUHtB>; Fri, 21 Feb 2003 02:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTBUHtB>; Fri, 21 Feb 2003 02:49:01 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:4849 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267224AbTBUHtA>; Fri, 21 Feb 2003 02:49:00 -0500
Date: Fri, 21 Feb 2003 00:58:52 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jaroslav Kysela <perex@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] snd_pcm_oss_change_params is a stack offender
Message-ID: <20030221005852.K1723@schatzie.adilger.int>
Mail-Followup-To: Muli Ben-Yehuda <mulix@mulix.org>,
	Jaroslav Kysela <perex@suse.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <39710000.1045757490@[10.10.2.4]> <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com> <20030221073948.GJ1202@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030221073948.GJ1202@actcom.co.il>; from mulix@mulix.org on Fri, Feb 21, 2003 at 09:39:49AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 21, 2003  09:39 +0200, Muli Ben-Yehuda wrote:
> +static int alloc_param_structs(snd_pcm_hw_params_t** params, 
> +			       snd_pcm_hw_params_t** sparams,
> +			       snd_pcm_sw_params_t** sw_params)

So, it looks like you've changed a large stack user into a leaker of
memory.  Nowhere is the allocated memory freed, AFAICS, not upon
successful completion, nor at any of the error exits.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

