Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYKjF>; Thu, 25 Jan 2001 05:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbRAYKiz>; Thu, 25 Jan 2001 05:38:55 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:22636 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129444AbRAYKik>; Thu, 25 Jan 2001 05:38:40 -0500
Date: Thu, 25 Jan 2001 12:38:31 +0200 (EET)
From: Heikki Lindholm <holindho@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: fat32 corruption with 2.4.0
Message-ID: <Pine.GSO.4.20.0101251133480.21886-100000@famine.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I haven't seen much vfat/fat32 complaints lately, so:
2.4.0 destroyed my windows partition. There seemed to be some trouble in
2.4.0-test9, too. I don't know if this was a known problem or not, but
2.4.0-test9 wrote filenames in a wrong way. It could be observed by
running windows (98 in my case) file system checker (not scandisk, but the
graphical one) after copying some files with non-8.3 names to a fat32
partition. There was no noticable data loss, however. 

Yesterday, with 2.4.0 release kernel, mounting a fat32 filesystem caused
data loss. The filesystem seemed to mount ok at a first glance, but
reported falsely 100% space usage. Then, after unmounting it, the oldest
(probably at start of the partition) directories "windows" and "my
documents" were mangled beyond recognition. I think, in this case, the
filenames got written REALLY wrong and showed as something like 
"?   * ~ ?. ?  ?". Running scandisk caused most directories and files 
in root directory to change to FILE0xxx.CHK and DIR0xxx.CHK. Most of the 
data was intact, however - and subdirectories below DIR0xxx.CHK's were
good, too. I had VIA (868B) UDMA enabled, but don't think that was the
cause since it worked fine with ext2 partitions.

In addition, trying to write to vfat /floppy with 2.4.0 also didn't
work. Kernel complained about (bad?) sectors. Whereas 2.2.0 did the job
fine (obviously, to the same floppy).

-- Heikki Lindholm

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
