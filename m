Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFTUu>; Wed, 6 Dec 2000 14:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbQLFTUm>; Wed, 6 Dec 2000 14:20:42 -0500
Received: from winds.org ([209.115.81.9]:14864 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129231AbQLFTUU>;
	Wed, 6 Dec 2000 14:20:20 -0500
Date: Wed, 6 Dec 2000 13:49:26 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: Trashing ext2 with hdparm
In-Reply-To: <3A2E767B.D74B24B5@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.4.21.0012061345460.20048-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Udo A. Steinberg wrote:

> Hi,
> 
> Following the discussion in another thread where someone
> reported fs corruption when enabling DMA with hdparm, I've
> played around with hdparm and found that even the rather
> harmless hdparm operations are capable of trashing an ext2
> filesystem quite nicely.
> 
> hdparm version is 3.9
> 
> hdparm -tT /dev/hdb1 does the trick here.
> 
> After that, several files are corrupted, such as /etc/mtab.
> Reboot+fsck fixes the problem, however e2fsck never finds
> any errors in the fs on disk.
> 
> I'm quite sure that earlier kernel versions didn't exhibit
> this kind of behaviour, although I'm not quite sure at
> which point things started to break. I have test12-pre6
> here atm, but I have test-11 still lying around and will
> test that in a bit.

I've seen this behavior on test-6 and up. I think it has something to do with
a problem in shared memory which is used by the 'hdparm -tT' code snippet. I
believe it munges over a lot of the memory segments that contain cached disk
files (the common ones accessed, such as /etc/mtab and /etc/utmp..etc). When
looking at the contents of those files, the memory is obtained from the cache
and they appear bogus, but on disk they are still correct.

If this problem occurs, it's best to hit the reset button so that no 'bad' data
is written back to disk during a sync call.

Can anyone else verify that the problem is in shared memory and not the disk
caching layer?

Regards,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
