Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbTENIEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTENIEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:04:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11930 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261175AbTENIEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:04:14 -0400
Date: Wed, 14 May 2003 10:16:56 +0200
From: Jens Axboe <axboe@suse.de>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: logs full of chatty IDE cdrom
Message-ID: <20030514081656.GC17033@suse.de>
References: <20030510201744.GD662@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510201744.GD662@gallifrey>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10 2003, Dr. David Alan Gilbert wrote:
> Hi,
>   I'm not sure but this seems to be a lot worse in 2.5.x for some
> reason; my logs are full of I/O errors, not ready's and other errors from
> my CDROM drive that is playing audio CDs; I suspect at least some of it
> is due to kscd trying to figure out if there is a CD in an empty drive.

This should fix it.

===== drivers/ide/ide-cd.c 1.44 vs edited =====
--- 1.44/drivers/ide/ide-cd.c	Wed May  7 19:34:30 2003
+++ edited/drivers/ide/ide-cd.c	Wed May 14 10:16:09 2003
@@ -2070,6 +2070,7 @@
 
 	req.sense = sense;
 	req.cmd[0] = GPCMD_TEST_UNIT_READY;
+	req.flags |= REQ_QUIET;
 
 #if ! STANDARD_ATAPI
         /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to 

-- 
Jens Axboe

