Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbULIAve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbULIAve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 19:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbULIAve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 19:51:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47787 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261378AbULIAv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 19:51:29 -0500
Subject: Re: [RFC] New timeofday proposal (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
In-Reply-To: <Pine.LNX.4.58.0412081640020.5165@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>
	 <1102533066.1281.81.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
	 <1102535891.1281.148.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
	 <1102549009.1281.267.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081548010.4783@schroedinger.engr.sgi.com>
	 <1102551441.1281.286.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081640020.5165@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1102553491.1281.297.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Dec 2004 16:51:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 16:40, Christoph Lameter wrote:
> On Wed, 8 Dec 2004, john stultz wrote:
> 
> > Well, its not *that* bad. Similar to the ntp_scale() function, it would
> > look something like:
> >
> > if (interval <= offset_len)
> > 	return (interval * singleshot_mult)>>shift;
> > else {
> > 	cycle_t v1,v2;
> > 	v1 = (offset_len * singleshot_mult)>>shift;
> > 	v2 = (interval-offset_len)*adjusted_mult)>>shift;
> > 	return v1+v2;
> > }
> >
> > Where:
> > 	singleshot_mult = original_mult + ntp_adj + ss_mult
> > and
> > 	adjusted_mult = original_mult + ntp_adj
> >
> >
> 
> Yuck. Do we support this kind of thing today? Support for periods of a
> tick or so is not an issue right?

Well, ok, you're right. I got my wires twisted and misspoke. Today we
really don't, since NTP adjustments only occur on tick boundaries. So
yes, singleshot adjustments are in multiples of ticks right now. But we
do assume ticks arrive at regular periods. If they don't, well, then we
apply it for only one ticks worth, but we've lost a tick so we're wrong
anyway. 

The code above, however, can handle non-regular interrupt intervals,
which is something I think we should assume will occur.

thanks
-john


