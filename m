Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbTGUMVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269987AbTGUMVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:21:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27873 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269981AbTGUMTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:19:44 -0400
Date: Mon, 21 Jul 2003 14:33:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: TCQ problems in 2.6.0-test1: the summary
Message-ID: <20030721123334.GF10781@suse.de>
References: <3F19C838.8040301@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F19C838.8040301@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19 2003, Ivan Gyurdiev wrote:
> 2.6.0-test1-current.
> The TCQ bugs/problems that I have found in the kernel have not been
> addressed yet. Some of the things posted below are new, but most have
> been posted before, and there have been no replies. If those bug reports
> are invalid, please say so, and I will stop sending them.
> 
> ================================================================================
> 
> I own an IC35L080AVVA07-0 80 GB drive
> (IBM Desktar 120 GXP, which is supposed to support TCQ).
> TCQ will not be activated on boot unless TCQ is enabled by default.
> 
> The problems:
> 
> ======================================================================================
> 1) This patch by Jens Axboe makes my machine bootable with tcq enabled.
> It hasn't been included in the kernel yet.
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1006.html

I'll send that in.

> 2) The default for queue depth is commented as 32, but is in fact 8.

I'll fix that up, too.

> 3) This is described as a way to set tcq depth in the docs:
>  echo "using_tcq:32" > /proc/ide/hdX/settings
> 
> but it results in:  proc_ide_write_settings(): parse error
> (hdparm -Q works instead)

Huhm weird, someone has broking the proc parsing. I'll look into that.
-Q does the same thing, as you know.

> 4) Using a tcq-enabled kernel with queue depth of 8 results in
> massive filesystem corruption for me, verified under reiserfs, and xfs.
> Elevator choice does not appear to matter, while queue depth is
> important - I do not appear to get filesystem corruption with queue
> depth of 32. Reiser refuses to mount with such a kernel, and runs
> --fix-fixable at boot time. This is reproducible every time.

This is really strange. The only difference between using 8 or 32 tags
is when ide-disk stops attempting to queue. Are you getting any errors
in dmesg when this happens? Reading the start io path for this, it looks
correct to me. I'll have to try and reproduce when I get back.

> 5) Using a tcq-enabled kernel causes i/o lockups (disk read/write
> freezes, while I am still able to move the mouse, type dmesg, etc..). To
> trigger the partial i/o lockups I set the disk standby to 5 seconds.
> After waking up the disk, I get numerous errors, and I have also gotten
> an oops. Attempts to reproduce this with tcq off have failed so far. The
> errors and oops are posted here:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1682.html

Noted, that is something I haven't tested.

> I am still keeping an old damaged reiser root filesystem, for the
> purposes of testing. If there is interest in testing filesystem
> corruption bugs, I am willing to do that. Please reply, though, because
> I will eventually destroy that partition if there is no interest.

If it's an ide tcq bug, it isn't very interesting. You can safely fry
that partition.

-- 
Jens Axboe

