Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUFKRHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUFKRHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbUFKRFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:05:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23533 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264196AbUFKRB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:01:27 -0400
Date: Fri, 11 Jun 2004 18:58:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and later)
Message-ID: <20040611165812.GD4309@suse.de>
References: <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com> <20040611075515.GR13836@suse.de> <20040611161701.GB11095@bounceswoosh.org> <40C9DE7F.8040002@pobox.com> <20040611165224.GA11945@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040611165224.GA11945@bounceswoosh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2004, Eric D. Mudama wrote:
> On Fri, Jun 11 at 12:31, Jeff Garzik wrote:
> >If queued-FUA is out of the question, this seems quite reasonable.  It 
> >appears to achieve the commit-block semantics described for barrier 
> >operation, AFAICS.
> 
> Queued FUA shouldn't be out of the question.
> 
> However, Queued FUA requires waiting for the queue to drain before
> sending more commands, since a pair of queued FUA commands doesn't
> guarantee the ordering of those two commands, which may or may not be
> acceptable semantics.

You can continue building and reordering requests behind the QUEUED_FUA
write(s).

> The barrier operation is basically a queueing-friendly flush+FUA,
> which may be better...  it lets the driver keep the queue in the drive

That's exactly correct.

> full, and also allows writes other than the commit block to not be
> done as FUA operations, which is potentially faster.  THe bigger the
> ratio of data to commit block, the better the performance would be
> with a barrier operation vs a purely queued FUA workload.

Just looking at how pre/write/post flush performs and I don't think it
will be that bad (it's already quite good). Depends on how sync
intensive the workload is of course.

But as long as it's the fastest possible implementation (and I think it
is), then arguing about performance is futile imo. Correctness comes
first.

-- 
Jens Axboe

