Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWEQX2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWEQX2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWEQX2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:28:54 -0400
Received: from ns.suse.de ([195.135.220.2]:50885 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750713AbWEQX2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:28:54 -0400
From: Neil Brown <neilb@suse.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Date: Thu, 18 May 2006 09:28:31 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17515.45471.353813.163431@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 000 of 3] md: Introduction - 3 bugfixs for -mm
In-Reply-To: message from Reuben Farrelly on Thursday May 18
References: <20060516111036.2649.patches@notabene>
	<446B1158.8030608@reub.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 18, reuben-lkml@reub.net wrote:
> 
> However things appear still not quite right on boot, as each mount works but 
> displays as though it didn't work, ie:
> 
> md: considering sdc2 ...
> md:  adding sdc2 ...
> md:  adding sda2 ...
> md: created md0
> md: bind<sda2>
> md: bind<sdc2>
> md: running: <sdc2><sda2>
> raid1: raid set md0 active with 0 out of 2 mirrors
> 
> 0 out of 2 ?

That is fixed by this patch, which I thought I had submitted...
Time get the latest -mm and see which of my patches are still pending
I guess.

Thanks,
NeilBrown

------------------------------
Fix recently broken calculation of degraded for raid1

A recent patch broke this code: rdev doesn't have meaningful
value at this point - disk->rdev is what should be used.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-05-02 14:15:28.000000000 +1000
+++ ./drivers/md/raid1.c	2006-05-02 14:15:44.000000000 +1000
@@ -1889,7 +1889,7 @@ static int run(mddev_t *mddev)
 		disk = conf->mirrors + i;
 
 		if (!disk->rdev ||
-		    !test_bit(In_sync, &rdev->flags)) {
+		    !test_bit(In_sync, &disk->rdev->flags)) {
 			disk->head_position = 0;
 			mddev->degraded++;
 		}
