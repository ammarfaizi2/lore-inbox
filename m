Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVJ2AKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVJ2AKm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVJ2AKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:10:42 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:21428 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750886AbVJ2AKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:10:41 -0400
Subject: Re: kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43
	BogoMIPS) problem with bogometer ?
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, art@usfltd.com
In-Reply-To: <1130542935.27168.431.camel@cog.beaverton.ibm.com>
References: <200510281828.AA38666812@usfltd.com>
	 <1130542935.27168.431.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 28 Oct 2005 20:10:32 -0400
Message-Id: <1130544632.6169.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 16:42 -0700, john stultz wrote:
> On Fri, 2005-10-28 at 18:28 -0500, art wrote:
> > kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43 BogoMIPS) problem with bogometer ?
> > 
> > kernel-2.6.14-rc5-rt7 -- Calibrating delay using timer specific routine.. 604.62 BogoMIPS (lpj=302311)
> > 
> > kernel-2.6.14-rc5 -- Calibrating delay using timer specific routine.. 6024.43 BogoMIPS (lpj=12048877)
> 
> Assuming this is an i386 kernel, in the timeofday patches, the __delay
> function has been converted to be a simple loop based delay instead of
> TSC based, since the TSC has too many potential problems. 
> 
> That should explain a differing lpj value, although 10x smaller is a
> little strange, so I'll dig into this on my system and see if I find
> anything.
> 
> Do let me know if you see any actual changes in behavior (drivers acting
> funny, etc).

John, 

Don't waste any time on this.  This was caused by a brain fart on
Thomas' part :-)  Some legacy code in ktimer_interrupt returned a enum
that was being used to update the ticks.  So before high-res was
activated, the jiffies would be incremented 7 times instead of just
once.  It's already been fixed. Just waiting for Ingo to release his new
patch.

-- Steve


