Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUFKQwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUFKQwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUFKQt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:49:59 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:20639 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S264226AbUFKQt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:49:26 -0400
Date: Fri, 11 Jun 2004 10:52:24 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and later)
Message-ID: <20040611165224.GA11945@bounceswoosh.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	"Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
References: <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com> <20040611075515.GR13836@suse.de> <20040611161701.GB11095@bounceswoosh.org> <40C9DE7F.8040002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <40C9DE7F.8040002@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 at 12:31, Jeff Garzik wrote:
>If queued-FUA is out of the question, this seems quite reasonable.  It 
>appears to achieve the commit-block semantics described for barrier 
>operation, AFAICS.

Queued FUA shouldn't be out of the question.

However, Queued FUA requires waiting for the queue to drain before
sending more commands, since a pair of queued FUA commands doesn't
guarantee the ordering of those two commands, which may or may not be
acceptable semantics.

The barrier operation is basically a queueing-friendly flush+FUA,
which may be better...  it lets the driver keep the queue in the drive
full, and also allows writes other than the commit block to not be
done as FUA operations, which is potentially faster.  THe bigger the
ratio of data to commit block, the better the performance would be
with a barrier operation vs a purely queued FUA workload.

--eric

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

