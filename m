Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTFPPpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTFPPpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:45:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41941 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263973AbTFPPpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:45:45 -0400
Subject: Re: 2.5.70-mm9
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030614232049.6610120d.akpm@digeo.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	<3EEAD41B.2090709@us.ibm.com> <20030614010139.2f0f1348.akpm@digeo.com>
	<1055637690.1396.15.camel@w-ming2.beaverton.ibm.com> 
	<20030614232049.6610120d.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Jun 2003 08:59:14 -0700
Message-Id: <1055779165.1397.870.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-14 at 23:20, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > On Sat, 2003-06-14 at 01:01, Andrew Morton wrote:
> > 
> > > Was elevator=deadline observed to fail in earlier kernels?  If not then it
> > > may be an anticipatory scheduler bug.  It certainly had all the appearances
> > > of that.
> > Yes, with elevator=deadline the many fsx tests failed on 2.5.70-mm5.
> >  
> > > So once you're really sure that elevator=deadline isn't going to fail,
> > > could you please test elevator=as?
> > > 
> > Ok, the deadline test was run for 10 hours then I stopped it (for the
> > elevator=as test).  
> > 
> > But the test on elevator=as (2.5.70-mm9 kernel) still failed, same
> > problem.  Some fsx tests are sleeping on io_schedule().  
> > 
> > Next I think I will re-run test on elevator=deadline for 24 hours, to
> > make sure the problem is really gone there.  After that maybe try a
> > different Qlogic Driver, currently I am using the driver from Qlogic
> > company(QLA2XXX V8).
> 
> Martin has just observed what appears to be the same failure on
> 2.5.71-mjb1, which is the deadline scheduler, using qlogicisp.
> 
> Again, some IO appears to have been submitted but it never came back.
> 
> It could be a bug in the requests queueing code somewhere, or in the device
> driver.
> 
> So a good thing to do now would be to find the workload+IO
> scheduler+filesystem which triggers it most easily, and run that with a
> different device driver.  The feral driver (drivers/scsi/isp/ in -mm)
> should be suitable for that test.
> 

I re-run the tests on the deadline scheduler on 2.5.70-mm9 kernel for 24
hours,  serveral fsx tests failed as before, same as as scheduler.  So
the problem is not gone on deadline scheduler, it shows up on both
deadline and as scheduler when running fsx tests on exts3 filesystem. 
It's easy to reproduce: fsx tests +ext3 + deadline/as scheduler + with
QLA2xxx v8 driver.

Now I am going to run the same test with feral driver. Will let you
know.

Mingming


