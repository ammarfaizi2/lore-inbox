Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUFJUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUFJUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUFJUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:30:56 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:15001 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262960AbUFJUay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:30:54 -0400
Date: Thu, 10 Jun 2004 14:33:50 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and later)
Message-ID: <20040610203350.GB2230@bounceswoosh.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org,
	"Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
	Jens Axboe <axboe@suse.de>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <40C8A241.50608@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10 at 14:02, Jeff Garzik wrote:
>Oh, also:
>
>We'll need to write up precisely _why_ this is used, and give some 
>examples of usage, for people reading the proposal (mostly T13-ish 
>people) who have not been following the lkml barrier discussion closely.

One comment...

There will need to be queued versions of this command, both legacy
and first-party, since a flush cache command will abort an outstanding
queue with error.

Second, I'm trying to figure out exactly how this might be used...

Would the driver just send down alternating write/flushregion commands
queued?  If that is the case, the drive will offer 2x the queue depth
(maybe 30% more performance) doing pure WRITE DMA QUEUED FUA (FP)
commands, wouldn't it?  Then again, for a metadata-only journaling
system, this would give you almost 100% of raw performance, with
metadata reliability which means you could always boot the drive.

I'm not sure what percentage of the writes to the filesystem one might
envision doing with this system...

--eric




-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

