Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSINXCS>; Sat, 14 Sep 2002 19:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSINXCS>; Sat, 14 Sep 2002 19:02:18 -0400
Received: from gate.in-addr.de ([212.8.193.158]:54795 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S317603AbSINXCQ>;
	Sat, 14 Sep 2002 19:02:16 -0400
Date: Sun, 15 Sep 2002 01:07:53 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Oktay Akbal <oktay.akbal@s-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: Possible Bug with MD multipath and raid1 on top
Message-ID: <20020914230753.GA3781@marowsky-bree.de>
References: <Pine.LNX.4.44.0209142014080.21833-100000@omega.s-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0209142014080.21833-100000@omega.s-tec.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-14T20:33:07,
   Oktay Akbal <oktay.akbal@s-tec.de> said:

> I found a very strange effect when using a raid1 on top of multipathing
> with Kernel 2.4.18 (Suse-version of it) with a 2-Port qlogic HBA
> connecting two arrays.

Is this with or without the patch I recently posted to linux-kernel?

If so, please use the patch at http://lars.marowsky-bree.de/dl/md-mp instead,
which is slightly newer and fixes one important (affecting raid0 use) and two
minor issues. Please be aware that you are beta-testing code for the time
being ;-) (Which is highly appreciated!)

> When I now pull out one of the cables two disks are missing and the
> multipath driver correctly uses the second path to the disks and
> continues to work. After plugging out the second cable all drives
> are marked as failed (mdstat), but the raid1 (md2) is still reported
> as functional with one device (md0) missing.

So far this sounds OK. (Even though the updated md-mp patch will _never_ fail
the last path but instead return the error to the layer upwards; this protects
against certain scenarios in 2.4 where a device error can't be distinguished
from a failed path and we don't want that to lead to an inaccessible device)

> All Processes using the raid1-device get stuck and this situation
> does not recover. Even some simple process testing the disk-access
> got stuck  (I think ps showed state   L<D).

That's not OK, obviously ;-)

I will try to reproduce this on Monday. As I don't have the hardware, but
instead use a loop device (which I can make fail on demand), if I can't
reproduce it, it might in fact be the FC driver which gets stuck somehow.

> Even if I'm quite sure that this is a bug, how should I test disk access
> without ending in "uninterruptible sleep" ?

Uhm, essentially, you should never get stuck in uninterruptible sleep. All
errors should "eventually" time out.

Please compile the kernel with magic-sysrq enabled and check where the
processes are stuck using magic-sysrq t. It might help if you piped the
results through ksymoops.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

