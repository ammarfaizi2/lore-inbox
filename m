Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbVJHBRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbVJHBRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 21:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbVJHBRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 21:17:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:26585 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161035AbVJHBRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 21:17:19 -0400
Subject: Re: IDE issues with  "choose_drive"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <1128560569.22073.25.camel@gaston>
References: <1128559019.22073.19.camel@gaston>
	 <1128560569.22073.25.camel@gaston>
Content-Type: text/plain
Date: Sat, 08 Oct 2005 11:15:03 +1000
Message-Id: <1128734104.17365.73.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 11:02 +1000, Benjamin Herrenschmidt wrote:
> > The first one is the one I'm trying to fix, it's basically a hang on
> > wakeup from sleep. What happens is that both drives are blocked
> > (suspended, drive->blocked is set). Their IO queues contains some
> > requests that haven't been serviced yet. We receive the resume()
> > callback for one of them. We react by inserting a wakeup request at the
> > head of the queue and waiting for it to complete. However, when we reach
> > ide_do_request(), choose_drive() may return the other drive (the one
> > that is still sleeping). In this case, we hit the test for blocked queue
> > and just break out of the loop. We end up never servicing the other
> > drive queue which is the one we are trying to wakeup, thus we hang.
> 
> Oh, and here's the ugly workaround beeing tested by the users who are
> having the problem so far. Not really a proper fix though...

No reply ... it's a bit urgent as it may bite any system trying to
suspend with a slave IDE disk at least (not including the other possible
problems I've spotted  with this code).

I'm tempted to just send my workaround patch to Linus & Andrew (might
still make it into 2.6.14). That would at least fix the bug with resume
from sleep. What do you think ?

Ben.


