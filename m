Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286297AbRL0PUu>; Thu, 27 Dec 2001 10:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286294AbRL0PUl>; Thu, 27 Dec 2001 10:20:41 -0500
Received: from fepE.post.tele.dk ([195.41.46.137]:64750 "EHLO
	fepE.post.tele.dk") by vger.kernel.org with ESMTP
	id <S283777AbRL0PUf>; Thu, 27 Dec 2001 10:20:35 -0500
Date: Thu, 27 Dec 2001 16:20:19 +0100
From: Jens Axboe <axboe@suse.de>
To: andersg@0x63.nu
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
Message-ID: <20011227162019.C1730@suse.de>
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <20011227135453.GA5803@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227135453.GA5803@h55p111.delphi.afb.lu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27 2001, andersg@0x63.nu wrote:
> -	int rw = bio_data_dir(bh);
> +	int rw = bio_data_dir(bi);
>  
>  
>  	down_read(&lv->lv_lock);
> @@ -1151,7 +1154,7 @@
>  
>  	P_MAP("%s - lvm_map minor: %d  *rdev: %s  *rsector: %lu  size:%lu\n",
>  	      lvm_name, minor,
> -	      kdevname(bh->bi_dev),
> +	      kdevname(bi->bi_dev),
>  	      rsector_org, size);
>  
>  	if (rsector_org + size > lv->lv_size) {
> @@ -1205,7 +1208,7 @@
>  	 * we need to queue this request, because this is in the fast path.
>  	 */
>  	if (rw == WRITE || rw == WRITEA) {
> -		if(_defer_extent(bh, rw, rdev_map,
> +		if(_defer_extent(bi, rw, rdev_map,
>  				 rsector_map, vg_this->pe_size)) {

You are tossing out read-ahead info here, you want to use bio_rw and not
bio_data_dir. The former will pass back xA bits too, while bio_data_dir
is strictly the data direction (strangely :-)

-- 
Jens Axboe

