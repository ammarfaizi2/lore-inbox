Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135754AbRA1Fwz>; Sun, 28 Jan 2001 00:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135775AbRA1Fwp>; Sun, 28 Jan 2001 00:52:45 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:54794 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S135754AbRA1Fwd>; Sun, 28 Jan 2001 00:52:33 -0500
Date: Sat, 27 Jan 2001 21:52:01 -0800
Message-Id: <200101280552.f0S5q1v05153@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat <-> vfat copying of ~700MB file, so slow!
In-Reply-To: <20010126184137.C260@bug.ucw.cz>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001 18:41:37 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
>> > Copying between vfat <-> vfat partitions is so slow. It seems
>> > that it's vfat/msdos kernel driver problem because I tried to copy
>> 
>> I reported this years ago, with a 700 kB file on a floppy and
>> a 4 MB file on a Zip disk. In both cases mcopy was several times
>> faster than the kernel code.
> 
> Perhaps linear scan of FAT?

Maybe. Quite likely, in fact. But there is no reason why fatfs can't
store the current FAT cluster number in struct file's private data,
making seeks, reads and writes O(1) (from O(n)).

You'll have to give up using generic_file_read(), however. So it's
not a trivial change.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
