Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTE1PFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbTE1PFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:05:53 -0400
Received: from 216-42-72-155.ppp.netsville.net ([216.42.72.155]:50830 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264629AbTE1PFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:05:52 -0400
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20030528130839.GW845@suse.de>
References: <3ED2DE86.2070406@storadinc.com>
	 <200305281305.44073.m.c.p@wolk-project.de>
	 <20030528042700.47372139.akpm@digeo.com>
	 <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de>
	 <3ED4B49A.4050001@gmx.net>  <20030528130839.GW845@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1054132096.32362.120.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 May 2003 10:28:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-28 at 09:08, Jens Axboe wrote:
>  
> > > May I ask how you are reproducing the bad results? I'm trying in vain
> > > here...
> > 
> > Quoting Con Kolivas:
> > 
> > dd if=/dev/zero of=dump bs=4096 count=512000
> 
> already tried that, no go. on ide/scsi? what filesystem? how much ram?
> anything else running? smp/up?

I think we've got a few different problems.  On SMP boxes, you need to
have the fix-pausing patch from andrea applied to catch all the corner
cases.

On UP boxes it's possible the requests are starving in the drive, SCSI
users should try with the max tags set down to something sensible,
between 8 and 32.

IDE people can try lowering the max_kb_per_request paramater in
/proc/ide/<drive>/settings, but this should only affect starvation with
the writeback cache on.

I made a patch a while ago that timed how long people spent waiting in
__get_request_wait, it might help us figure out where the starvation is
really happening.
 
-chris


