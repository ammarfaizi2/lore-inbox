Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262992AbVGNJ4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbVGNJ4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVGNJ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:56:53 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:52493 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262992AbVGNJ4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:56:52 -0400
Date: Thu, 14 Jul 2005 10:56:52 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121306904.4435.132.camel@mindpipe>
Message-ID: <Pine.LNX.4.61L.0507141050060.31857@blysk.ds.pg.gda.pl>
References: <42D540C2.9060201@tmr.com>  <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
  <20050713184227.GB2072@ucw.cz>  <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
  <1121282025.4435.70.camel@mindpipe>  <d120d50005071312322b5d4bff@mail.gmail.com>
  <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
  <20050713211650.GA12127@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121306904.4435.132.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Lee Revell wrote:

> Did anyone else find this strange:
> 
> "The RTC is used in periodic mode to provide the system profiling
> interrupt on uni-processor systems and the clock interrupt on
> multi-processor systems."
> 
> We just take NR_CPUS * HZ timer interrupts per second, what's the
> advantage of using the RTC?

 It tends to work in the APIC mode all the time (with all systems), unlike 
the PIT which has "interesting" routing problems with its IRQ0, which 
you've probably already noticed.  Have a look at all the hassle in 
check_timer() if you want to double-check it.

 Of course using APIC internal timers is generally the best idea on SMP, 
but they may have had reasons to avoid them (it's not an ISA interrupt, so 
it could have been simply out of question in the initial design).

  Maciej
