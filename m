Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUCXXtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCXXsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:48:53 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:33700 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262316AbUCXXrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:47:41 -0500
Date: Thu, 25 Mar 2004 05:16:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, tiwai@suse.de,
       Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040324234643.GD12035@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random> <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random> <20040324172657.GA1303@us.ibm.com> <20040324175142.GW2065@dualathlon.random> <20040324213914.GD4539@in.ibm.com> <20040324225326.GH2065@dualathlon.random> <20040324231145.GB12035@in.ibm.com> <20040324233430.GJ2065@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324233430.GJ2065@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 12:34:30AM +0100, Andrea Arcangeli wrote:
> On Thu, Mar 25, 2004 at 04:41:45AM +0530, Dipankar Sarma wrote:
> > That was not 16 callbacks per tick, it was 16 callbacks in one
> > batch of a single softirq. And then I reschedule the RCU tasklet
> 
> sorry so you're already using tasklets in current code? I misunderstood
> the current code then.

+               if (count >= rcumaxbatch) {
+                       RCU_plugticks(cpu) = rcuplugticks;
+                       if (!RCU_plugticks(cpu))
+                               tasklet_hi_schedule(&RCU_tasklet(cpu));
+                       break;
+               }

That does it. Although, the tasklet handler needs to optimized
to for such frequent rescheduling when there isn't anything
else to process in that cpu. Later.

Thanks
Dipankar
