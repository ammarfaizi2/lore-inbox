Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265310AbUEZEYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUEZEYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUEZEYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:24:35 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:39439 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265310AbUEZEYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:24:15 -0400
Date: Wed, 26 May 2004 06:21:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrey Nekrasov <andy@spylog.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sata promise and software raid5...
Message-ID: <20040526042144.GE578@alpha.home.local>
References: <1236867749.20040526034657@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1236867749.20040526034657@spylog.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I had the same problem on a PIIX SATA with RAID1. Basically, I noticed
that each disk could be accessed one at a time, and that it was totally
impossible to access the second one while the first one was reading. A simple
"cat /dev/sda >/dev/null" prevented anyone from logging into the box or doing
anything which required disk I/O.

So if you have the same problem, I can fairly understand your low numbers.
Could you try something like :

# cat /dev/sda >/dev/null &
# hdparm -t /dev/sdb

If hdparm doesn't start before the 'cat' ends, you do have the same problem.
Well, I don't know where it comes from, and unfortunately I don't have the
machine anymore to try fixes.

Regards,
Willy

On Wed, May 26, 2004 at 03:46:57AM +0400, Andrey Nekrasov wrote:
> Hello,
> 
> controller - Promise SATA 150 TX4, linux 2.6.7-rc1-bk1, HDD Maxtor
> 250Gb (x4)
> 
> Why so slowly reads (and writes) with software raid5?
> 
> gnome:~ # hdparm -t /dev/sda2
> 
> /dev/sda2:
>  Timing buffered disk reads:  148 MB in  3.01 seconds =  49.16 MB/sec
> gnome:~ # hdparm -t /dev/sdb2
> 
> /dev/sdb2:
>  Timing buffered disk reads:  148 MB in  3.02 seconds =  49.01 MB/sec
> gnome:~ # hdparm -t /dev/sdc2
> 
> /dev/sdc2:
>  Timing buffered disk reads:  148 MB in  3.03 seconds =  48.90 MB/sec
> gnome:~ # hdparm -t /dev/sdd2
> 
> /dev/sdd2:
>  Timing buffered disk reads:  144 MB in  3.00 seconds =  47.96 MB/sec
> gnome:~ #
> gnome:~ #
> gnome:~ # hdparm -t /dev/md0
> 
> /dev/md0:
>  Timing buffered disk reads:   64 MB in  3.12 seconds =  20.52 MB/sec
> gnome:~ #
> 
> 
> gnome:~ # cat /etc/raidtab
> raiddev /dev/md0
>         raid-level              5
>         nr-raid-disks           4
>         nr-spare-disks          0
>         persistent-superblock   1
>         parity-algorithm        left-symmetric
>         chunk-size              1024
> 
>         device                  /dev/sda2
>         raid-disk               0
> 
>         device                  /dev/sdb2
>         raid-disk               1
> 
>         device                  /dev/sdc2
>         raid-disk               2
> 
>         device                  /dev/sdd2
>         raid-disk               3
> 
>         
> bye
> --
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
