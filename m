Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284786AbRLEWts>; Wed, 5 Dec 2001 17:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284787AbRLEWtk>; Wed, 5 Dec 2001 17:49:40 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:3834 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284786AbRLEWt1>;
	Wed, 5 Dec 2001 17:49:27 -0500
Date: Wed, 5 Dec 2001 14:48:41 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
Message-ID: <20011205144841.E1193@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011126114610.B1141@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.33.0111280145300.3429-100000@localhost.localdomain> <20011205135851.D1193@w-mikek2.des.beaverton.ibm.com> <1007590396.28567.6.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1007590396.28567.6.camel@phantasy>; from rml@tech9.net on Wed, Dec 05, 2001 at 05:13:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 05:13:14PM -0500, Robert Love wrote:
> Ehh, odd.  How does the dropped performance compare to MQ performance
> before 2.4.16?  In other words, are we solving problems in the newer
> kernels and now MQ is becoming overhead?

No I don't think that is the case.  The throughput numbers for this
benchmark at one specific data point on an 8-way look like.

2.4.14 Default Scheduler    39463
2.4.14 MQ Scheduler        385687
2.4.16 Default Scheduler    51364
2.4.16 MQ Scheduler        240667

The MQ numbers are still quite a bit better even on 2.4.16.  I can
easily get MQ 2.4.16 back up to MQ 2.4.14 levels by reintroducing the
code to give a slight preference to the currently running task.
However, our MQ scheduler is trying to closely match the behavior of
the default scheudler wherever possible (for better or worse).  It
should also be noted that performance of the default scheduler
increased as a result of Ingo's changes.

It is entirely possible that there is some other bug/feature in our
MQ code that is causing this situation.  As mentioned by others, the
scheduler code that was removed from 2.4.15 should have little if
any impact on performance.  I need to do some more analysis here.

-- 
Mike
