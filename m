Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSKRA3E>; Sun, 17 Nov 2002 19:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSKRA3E>; Sun, 17 Nov 2002 19:29:04 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:37318 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S261295AbSKRA3C>; Sun, 17 Nov 2002 19:29:02 -0500
Message-ID: <3DD835BB.5050608@torque.net>
Date: Mon, 18 Nov 2002 11:35:07 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Failure to reread partition tables on non-busy devices
References: <20021118000505.GM3280@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug,
Your patch below fixes the problem I was seeing with fdisk
creating new partitions (on a scsi_debug ram disk) not being
visible outside fdisk.

Doug Gilbert

Doug Ledford wrote:
> This patch (almost certainly wrong BTW) makes it work.  Obviously, 
> somewhere there should be a call to invalidate_bdev(); that doesn't exist.  
> I'm not sure A) where that call should be and B) what checks there should 
> be to avoid calling invalidate_bdev() on a device that is busy.
> 
> fs/partitions/check.c:  1.85 1.86 dledford 02/11/17 17:22:37 (modified, 
> needs delta)
> 
> @@ -453,8 +453,8 @@ int rescan_partitions()
>  	struct parsed_partitions *state;
>  	int p, res;
>  
> -	if (!bdev->bd_invalidated)
> -		return 0;
> +	//if (!bdev->bd_invalidated)
> +	//	return 0;
>  	if (bdev->bd_part_count)
>  		return -EBUSY;
>  	res = invalidate_device(dev, 1);
> 



