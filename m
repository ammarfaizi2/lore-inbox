Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWHRHMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWHRHMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWHRHMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:12:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62354 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750798AbWHRHL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:11:59 -0400
Date: Fri, 18 Aug 2006 00:11:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: David Chinner <dgc@sgi.com>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow 
 writeback.
Message-Id: <20060818001154.4765c221.akpm@osdl.org>
In-Reply-To: <20060818070314.GE798@suse.de>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
	<20060817232942.c35b1371.akpm@osdl.org>
	<20060818070314.GE798@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 09:03:15 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Thu, Aug 17 2006, Andrew Morton wrote:
> > It seems that the many-writers-to-different-disks workloads don't happen
> > very often.  We know this because
> > 
> > a) The 2.4 performance is utterly awful, and I never saw anybody
> >    complain and
> 
> Talk to some of the people that used DVD-RAM devices (or other
> excruciatingly slow writers) on their system, and they would disagree
> violently :-)

umm, OK, I guess that has the same cause: buffer_heads from different
devices all on the same single queue.  In this case the problem is that one
device is slow.  In the same-speed-devices case the problem is that all
writeback threads get stuck on the same device, allowing others to go idle.

