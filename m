Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273883AbRIXMQm>; Mon, 24 Sep 2001 08:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRIXMQc>; Mon, 24 Sep 2001 08:16:32 -0400
Received: from [213.96.224.204] ([213.96.224.204]:12555 "EHLO manty.net")
	by vger.kernel.org with ESMTP id <S273867AbRIXMQP>;
	Mon, 24 Sep 2001 08:16:15 -0400
Date: Mon, 24 Sep 2001 14:16:38 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.10
Message-ID: <20010924141638.A2275@man.beta.es>
In-Reply-To: <3BAECC4F.EF25393@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAECC4F.EF25393@zip.com.au>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After testing this new patch on 2.4.10 I have detected a problem when trying
to convert mounted partitions to ext3.

The problem is that on umounting the partition, with 2.4.10 kernel, the
has_journal feature mark is removed, so the device is not detected as having
journal on next mount.

Creating journals (converting to ext3) on partitions that are not mounted
works ok.

Following is a practical demonstration of this in case I didn't explain
myself well...

pul:/# grep var /etc/fstab
/dev/hda7 /var auto rw 0 2
pul:/# mount|grep var
/dev/hda7 on /var type ext2 (rw)
pul:~# tune2fs -l /dev/hda7|grep -i journal
pul:~# ls -l /var/.journal
ls: /var/.journal: No such file or directory
pul:~# tune2fs -j /dev/hda7
tune2fs 1.24a (02-Sep-2001)
Creating journal inode: done
This filesystem will be automatically checked every 20 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
pul:~# tune2fs -l /dev/hda7|grep -i journal
Filesystem features:      has_journal filetype sparse_super
Journal UUID:             <none>
Journal inode:            12
Journal device:           0x0000
pul:~# ls -l /var/.journal
-rw-------    1 root     root      8388608 sep 24 13:39 /var/.journal
pul:/# umount /var
pul:/# tune2fs -l /dev/hda7|grep -i journal
pul:/# mount /var
pul:/# mount|grep var
/dev/hda7 on /var type ext2 (rw)
pul:/# ls -l /var/.journal
-rw-------    1 root     root      8388608 Sep 24 13:39 /var/.journal

Regards...
-- 
Manty/BestiaTester -> http://manty.net
