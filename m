Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbTFASvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264705AbTFASvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:51:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:46578 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264704AbTFASvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:51:54 -0400
Message-Id: <200306011905.h51J57Q03929@owlet.beaverton.ibm.com>
To: Michael Buesch <fsdeveloper@yahoo.de>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [2.5.70] possible problem with /dev/diskstats 
In-reply-to: Your message of "Sun, 01 Jun 2003 00:35:58 +0200."
             <200306010035.58957.fsdeveloper@yahoo.de> 
Date: Sun, 01 Jun 2003 12:05:07 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Documentation/iostats.txt says about diskstats:
    [SNIP]
    Field  9 -- # of I/Os currently in progress
        The only field that should go to zero. Incremented as requests are
        given to appropriate request_queue_t and decremented as they finish.
    [SNIP]
    
    But here is a cat /proc/diskstats:
       3    0 hda 948 317 16216 4294408142 90 333 848 7309 4294967294 7309215 4280372198
                                                           ~~~~~~~~~~

Yes, I've had a couple of other reports of this.  I suspect there is
a path by which an "I/O" appears to have been completed while none was
begun.  I've only noticed this on my hda drive as well.  What I didn't
notice was exactly when this behavior began, which may have been useful
in tracking down the problem.  You'll notice a couple of other values
there in the 4.2 billion range that probably suffer from a similar
(or maybe the same) issue.  I haven't seen this on SCSI drives yet,
just hda drives, which suggests there may be something about that I/O
path that bears some closer scrutiny.

Rick
