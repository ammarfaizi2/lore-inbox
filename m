Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTFOGGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 02:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTFOGGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 02:06:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:64013 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261932AbTFOGGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 02:06:42 -0400
Date: Sat, 14 Jun 2003 23:20:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm9
Message-Id: <20030614232049.6610120d.akpm@digeo.com>
In-Reply-To: <1055637690.1396.15.camel@w-ming2.beaverton.ibm.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	<3EEAD41B.2090709@us.ibm.com>
	<20030614010139.2f0f1348.akpm@digeo.com>
	<1055637690.1396.15.camel@w-ming2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jun 2003 06:20:32.0383 (UTC) FILETIME=[397D28F0:01C33306]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> On Sat, 2003-06-14 at 01:01, Andrew Morton wrote:
> 
> > Was elevator=deadline observed to fail in earlier kernels?  If not then it
> > may be an anticipatory scheduler bug.  It certainly had all the appearances
> > of that.
> Yes, with elevator=deadline the many fsx tests failed on 2.5.70-mm5.
>  
> > So once you're really sure that elevator=deadline isn't going to fail,
> > could you please test elevator=as?
> > 
> Ok, the deadline test was run for 10 hours then I stopped it (for the
> elevator=as test).  
> 
> But the test on elevator=as (2.5.70-mm9 kernel) still failed, same
> problem.  Some fsx tests are sleeping on io_schedule().  
> 
> Next I think I will re-run test on elevator=deadline for 24 hours, to
> make sure the problem is really gone there.  After that maybe try a
> different Qlogic Driver, currently I am using the driver from Qlogic
> company(QLA2XXX V8).

Martin has just observed what appears to be the same failure on
2.5.71-mjb1, which is the deadline scheduler, using qlogicisp.

Again, some IO appears to have been submitted but it never came back.

It could be a bug in the requests queueing code somewhere, or in the device
driver.

So a good thing to do now would be to find the workload+IO
scheduler+filesystem which triggers it most easily, and run that with a
different device driver.  The feral driver (drivers/scsi/isp/ in -mm)
should be suitable for that test.

