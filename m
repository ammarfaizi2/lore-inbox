Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbULIAmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbULIAmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 19:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbULIAmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 19:42:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35026 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261421AbULIAlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 19:41:45 -0500
Date: Wed, 8 Dec 2004 16:40:34 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] New timeofday proposal (v.A1)
In-Reply-To: <1102551441.1281.286.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0412081640020.5165@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com> 
 <1102533066.1281.81.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com> 
 <1102535891.1281.148.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com> 
 <1102549009.1281.267.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081548010.4783@schroedinger.engr.sgi.com>
 <1102551441.1281.286.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, john stultz wrote:

> Well, its not *that* bad. Similar to the ntp_scale() function, it would
> look something like:
>
> if (interval <= offset_len)
> 	return (interval * singleshot_mult)>>shift;
> else {
> 	cycle_t v1,v2;
> 	v1 = (offset_len * singleshot_mult)>>shift;
> 	v2 = (interval-offset_len)*adjusted_mult)>>shift;
> 	return v1+v2;
> }
>
> Where:
> 	singleshot_mult = original_mult + ntp_adj + ss_mult
> and
> 	adjusted_mult = original_mult + ntp_adj
>
>

Yuck. Do we support this kind of thing today? Support for periods of a
tick or so is not an issue right?

