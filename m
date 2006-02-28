Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWB1Bks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWB1Bks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWB1Bks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:40:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:49077 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932117AbWB1Bkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:40:47 -0500
Subject: Re: [Lse-tech] Re: [Patch 2/7] Add sysctl for schedstats
From: chandra seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <44039860.8090708@yahoo.com.au>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141027367.5785.42.camel@elinux04.optonline.net>
	 <1141027923.5785.50.camel@elinux04.optonline.net>
	 <4402C3BB.7010705@yahoo.com.au> <1141067382.4770.699.camel@linuxchandra>
	 <44039860.8090708@yahoo.com.au>
Content-Type: text/plain
Organization: ibm
Date: Mon, 27 Feb 2006 17:42:37 -0800
Message-Id: <1141090957.3916.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 11:25 +1100, Nick Piggin wrote:
> Chandra Seetharaman wrote:
> 
> >On Mon, 2006-02-27 at 20:17 +1100, Nick Piggin wrote:
> >
> >>> #ifdef CONFIG_SCHEDSTATS
> >>>+
> >>>+int schedstats_sysctl = 0;		/* schedstats turned off by default */
> >>>
> >>Should be read mostly.
> >>
> >>
> >>>+static DEFINE_PER_CPU(int, schedstats) = 0;
> >>>+
> >>>
> >>When the above is in the read mostly section, you won't need this at all.
> >>
> >>You don't intend to switch the sysctl with great frequency, do you?
> >>
> >
> >No, it is not expected to switch often.
> >
> >We originally coded it as __read_mostly, but thought the variable
> >bouncing between CPUs would be costly. Is it cheaper with
> >__read_mostly ? or it doesn't matter ?
> >
> >
> 
> Well it will only "bounce" when the cacheline it is in is written to by
> a different CPU. Considering this happens with your per-cpu implementation
> _anyway_, they don't buy you anything much.
> 
> Putting it in __read_mostly means that you won't happen to share a cacheline
> with a variable that is being written to frequently.
> 
Thanks for the clarification Nick.

> Nick
> 
> --
> 
> Send instant messages to your online friends http://au.messenger.yahoo.com 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

