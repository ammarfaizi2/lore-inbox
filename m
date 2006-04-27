Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWD0SaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWD0SaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWD0SaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:30:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:28548 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964942AbWD0SaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:30:18 -0400
Date: Thu, 27 Apr 2006 23:57:19 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 5/8] taskstats interface
Message-ID: <20060427182719.GC14496@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com> <44501A97.2060104@engr.sgi.com> <445041EB.7080205@watson.ibm.com> <20060427064237.GA14496@in.ibm.com> <445104DC.90401@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445104DC.90401@engr.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jay,

> Hi Shailabh and Balbir,
> 
> Are TASKSTATS_GENL_VERSION and TASKSTATS_VERSION the same thing?
> If they are meant to serve different purposes, we still need it.
> 

Yes, thats true. But for now from what I can see, one version should
be sufficient.

<snip> 

> I was thinking of a bitmask thing. But instead of keying specific
> fields, one bit may be used to key delay accounting, and another bit
> for CSA, el at. This way you do not need to have CSA-specifc fields
> in the payload and applications know how to correctly interpret the
> payload. Taskstats and application do not need to have knowledge of
> accounting packages, only need to set the bitmasks correctly.
>

Yes, but scanning the entire payload for various types is also feasible. It is
a bit slow, but feasible and generally the recommended approach for
dealing with genetlink types. What you are saying is still possible, the
application can ignore types it does not understand.

> When we start sending sys stats of each tasks to userland, that is
> s lot of data. Note that BSD accounting even uses encode_comp_t()
> routine to compress data into a 13-bit fraction with 3-bit exponent
> field to shrink its size. Even though you do not need to care
> about those zero's in taskstats, they still need to be delievered
> through netlink socket.

Yes, thats true. We can leave the decision of compressing, etc to the
specific subsystem. It can encode it and the user level application
can decode the data.

> 
> I must admit that this may create a point of failure due to the
> payload info not set correctly according to the CONFIG flags.
> 
> The idea was to eliminate the need of #2 methods, but maybe
> #2 method is better...
> 
> I am a little confused after reading Balbir's reply. It seems to
> me that Shailabh suggested to create a different struct to contain
> stats data. Is that also what Balbir talked about? If a different
> package builds a different taskstat-like interface as suggested
> in #2, would the data travel on the same socket as delay
> accounting?

Sorry for the confusion. Yes, even I would recommend creating a different
struct for the stats data. The data will pass over the same socket as delay
accounting (separate sockets can be used, but that would become inefficient).

> 
> I would suggest to do the check at the beginning of
> taskstats_exit_send() before mutex_lock(&taskstats_exit_mutex).

Good suggestion, we can move the check to that point.

> 
> Regards,
>  - jay

--
					Warm Regards, 
					<---	Balbir
