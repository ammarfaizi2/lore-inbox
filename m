Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTEZR7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTEZR7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:59:50 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:58116 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261970AbTEZR7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:59:45 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: torvalds@transmeta.com, Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 May 2003 14:12:49 -0400
Message-Id: <1053972773.2298.177.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    On Mon, May 26 2003, Linus Torvalds wrote:
    > > What does the block layer need, that it doesn't have now?
    > 
    > Exactly. I'd _love_ for people to really think about this.
    
    In discussion with Jeff, it seems most of what he wants is already
    there. He just doesn't know it yet :-)
    
    Maybe that's my problem as well, maybe the code / comments / doc /
    whatever is not clear enough.
    
My wishlist for this would be:

1. Unified SG segment allocation.  The SCSI layer currently has a
mempool implementation to cope with this, is there a reason it can't
become block generic?

2. Device locality awareness.  Quite a bit of the esoteric SCSI queueing
code occurs because we have two type of queue events:
a. device can't accept another command---stop queue and restart when the
device sends a completion back
b. the host adapter is out of resources for *all* its devices.  Block
all device queues until we free some resources (again, usually a
returning command).

3. Perhaps some type of unified command handling.  At the moment, we all
seem to allocate DMA'able regions for our commands/taskfiles/whatever
and attach them to reqest->special.  Then we need to release them again
before completing the request.

4. Same thing goes for sense buffers.

5. There needs to be some amalgam of the SCSI code for dynamic tag
command queue depth handling.

OK, I'll stop now.

James


