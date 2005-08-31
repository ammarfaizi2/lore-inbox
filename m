Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVHaVfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVHaVfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVHaVfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:35:22 -0400
Received: from users.ccur.com ([208.248.32.211]:56297 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S964981AbVHaVfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:35:22 -0400
Date: Wed, 31 Aug 2005 17:34:30 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
Message-ID: <20050831213430.GA11858@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <F989B1573A3A644BAB3920FBECA4D25A042B0053@orsmsx407> <43161F03.5090604@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43161F03.5090604@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 03:20:03PM -0600, Christopher Friesen wrote:
> Perez-Gonzalez, Inaky wrote:
> >In this structure,
> >the user specifies:
> >    whether the time is absolute, or relative to 'now'.
> 
> 
> >Timeout_sleep has a return argument, endtime, which is also in
> >'struct timeout' format.  If the input time was relative, then
> >it is converted to absolute and returned through this argument.
> 
> Wouldn't it make more sense for the endtime to be returned in the same 
> format (relative/absolute) as the original timer was specified?  That 
> way an application can set a new timer for "timeout + SLEEPTIME" and on 
> average it will be reasonably accurate.
> 
> In the proposed method, for endtime to be useful the app needs to check 
> the current time, compare with the endtime, and figure out the delta. 
> If you're going to force the app to do all that work anyway, the app may 
> as well use absolute times.
> 
> Chris

The returned timeout struct has a bit used to mark the value as absolute.  Thus
the caller treats the returned timeout as a opaque cookie that can be
reapplied to the next (or more likely, the to-be restarted) timeout.

A general principle is, once a time has been converted to absolute, it
should never be converted back to relative time.  To do so means the
end-time starts to drift from the original end-time.

Regards,
Joe
--
"Money can buy bandwidth, but latency is forever" -- John Mashey
