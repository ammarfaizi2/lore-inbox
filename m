Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTFBEJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 00:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTFBEJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 00:09:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54007 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261825AbTFBEJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 00:09:51 -0400
Message-Id: <200306020423.h524NBd02594@owlet.beaverton.ibm.com>
To: Michael Buesch <fsdeveloper@yahoo.de>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [2.5.70] possible problem with /dev/diskstats 
In-reply-to: Your message of "Sun, 01 Jun 2003 21:31:31 +0200."
             <200306012131.32006.fsdeveloper@yahoo.de> 
Date: Sun, 01 Jun 2003 21:23:11 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I've done some disk-io (compiled some software) and the values
    now are even lower:
    
Interesting, yes, you now have 60 fewer "I/O's in flight."

    Where exactly is the code in the kernel, that produces the diskstats file,
    so I can try grepping through it?

The I/O's in flight are incremented in drive_stat_acct() (see ll_rw_blk.c)
and decremented in attempt_merge() and end_that_request_last().  My gut feel
is that end_that_request_last() is getting called more often than expected
via some interesting path, but I've nothing right now to back that up.

Rick
