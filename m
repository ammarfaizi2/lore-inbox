Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263657AbREYIo7>; Fri, 25 May 2001 04:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263658AbREYIou>; Fri, 25 May 2001 04:44:50 -0400
Received: from t2.redhat.com ([199.183.24.243]:58103 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263657AbREYIoe>; Fri, 25 May 2001 04:44:34 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010525005253.A16005@bug.ucw.cz> 
In-Reply-To: <20010525005253.A16005@bug.ucw.cz> 
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, jffs-dev@axis.com
Subject: Re: jffs on non-MTD device? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 09:44:10 +0100
Message-ID: <24676.990780250@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pavel@suse.cz said:
> I'm trying to run jffs on my ATA-flash disk (running ext2 could kill
> some flash cells too soon, right?) but it refuses:

CompactFlash does wear levelling internally. 

>         if (MAJOR(dev) != MTD_BLOCK_MAJOR) {
>                 printk(KERN_WARNING "JFFS: Trying to mount a "
>                        "non-mtd device.\n");
>                 return 0;
>         }

> What are reasons for this check? 

JFFS doesn't actually use the block device interface. Specifying it in the 
mount command is simply a hack to make life easier, which nobody's yet 
managed to obsolete. We actually use the underlying MTD device:

        mtd = get_mtd_device(NULL, MINOR(dev));

If you want JFFS (or JFFS2) on a CF device - in the apparent absence of any 
other relatively low overhead, compressing, journalling file system to use 
on it - then you need to provide a translation driver similar to the mtdram 
one which fakes an MTD device, using a block device as backing store.

--
dwmw2


