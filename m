Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSD3U4M>; Tue, 30 Apr 2002 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313414AbSD3U4L>; Tue, 30 Apr 2002 16:56:11 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:36103 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313384AbSD3U4L>; Tue, 30 Apr 2002 16:56:11 -0400
Subject: Re: [OOPS] 2.5.11 software raid,reiserfs & scsi
From: Tommy Faasen <tommy@vuurwerk.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux kernel Mailinglist <linux-kernel@vger.kernel.org>, mingo@redhat.com
In-Reply-To: <Pine.LNX.4.21.0204302056120.23113-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 30 Apr 2002 22:56:07 +0200
Message-Id: <1020200168.599.0.camel@it0>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-30 at 20:58, Roman Zippel wrote:
> Hi,
> 
> On 29 Apr 2002, Tommy Faasen wrote:
> 
> > I got an oops on 2.5.11 with an software raid 0 setup on 3 scsi disks,
> > it worked ok on 2.5.8. I get this when booting up and then my /dev/md0
> > isn't found.. If you need more details/help let me know!
> 
> The patch below fixes it for me.
> rdev doesn't point to a valid raid partition.
> 
Thanks, that did it for me!
> bye, Roman
> 
> Index: drivers/md/md.c
> ===================================================================
> RCS file: /usr/src/cvsroot/linux-2.5/drivers/md/md.c,v
> retrieving revision 1.1.1.8
> diff -u -p -r1.1.1.8 md.c
> --- drivers/md/md.c	29 Apr 2002 17:35:50 -0000	1.1.1.8
> +++ drivers/md/md.c	30 Apr 2002 17:52:04 -0000
> @@ -1577,6 +1577,7 @@ static int device_size_calculation(mddev
>  	if (!md_size[mdidx(mddev)])
>  		md_size[mdidx(mddev)] = sb->size * data_disks;
>  
> +	rdev = list_entry(mddev->disks.next, mdk_rdev_t, same_set);
>  	readahead = (blk_get_readahead(rdev->bdev) * 512) / PAGE_SIZE;
>  	if (!sb->level || (sb->level == 4) || (sb->level == 5)) {
>  		readahead = (mddev->sb->chunk_size>>PAGE_SHIFT) * 4 * data_disks;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


