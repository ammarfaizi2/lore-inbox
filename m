Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUD1Vea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUD1Vea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUD1Ve1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:34:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:7372 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261931AbUD1Vdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:33:35 -0400
Subject: Re: Low bogomips on IBM x445 (kernel 2.6.5)
From: john stultz <johnstul@us.ibm.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <40901E1A.9020904@nortelnetworks.com>
References: <408E3D74.2090301@inf.tu-dresden.de>
	 <1083184612.9664.15.camel@cog.beaverton.ibm.com>
	 <40901E1A.9020904@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1083187994.9664.24.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Apr 2004 14:33:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 14:11, Chris Friesen wrote:
> john stultz wrote:
> 
> > This is expected. Since the IBM x440/x445 are NUMA systems, we cannot
> > use the TSC (cpu cycle counter) as a time source. Instead we use an off
> > chip performance counter which runs at 100Mhz. This then translates to a
> > bogoMIPS value of ~200. 
> 
> That sounds very strange.  Bogomips is supposed to be how many busy-wait loops the cpu can do in a 
> second, or at least that's what I've seen in all the books.  It shouldn't matter what the time 
> source is.

Well, sort of. bogoMIPS is derived from loops_per_jiffy, which when
using the PIT as a time source is how many busy-wait loops occur in a
timer tick.  However when using the TSC as a timesource, the __delay()
function busy waits for a number of cycles. This increases the accuracy,
as interrupts taken do not affect the delay time. So in this case
bogoMIPS becomes the number of cpu cycles per tick. When using the
cyclone time source (the off chip performance counter) on the x440, it
becomes the number of cyclone cycles per tick.

thanks
-john




