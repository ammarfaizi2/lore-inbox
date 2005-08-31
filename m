Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVHaWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVHaWsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVHaWsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:48:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17850 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932542AbVHaWsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:48:40 -0400
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
	calculation in timer_pm.c
From: john stultz <johnstul@us.ibm.com>
To: Zachary Amsden <zach@vmware.com>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, kernel@kolivas.org, tytso@mit.edu,
       cfriesen@nortel.com, rlrevell@joe-job.com, trenn@suse.de,
       george@mvista.com, akpm@osdl.org, Tim Mann <mann@vmware.com>
In-Reply-To: <431630EE.2050809@vmware.com>
References: <20050831165843.GA4974@in.ibm.com>
	 <20050831171211.GB4974@in.ibm.com>  <431630EE.2050809@vmware.com>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 15:47:48 -0700
Message-Id: <1125528468.20820.255.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-31 at 15:36 -0700, Zachary Amsden wrote:
> >I feel lost ticks can be based on cycles difference directly
> >rather than being based on microseconds that has elapsed.
> >
> >Following patch is in that direction. 
> >
> >With this patch, time had kept up really well on one particular
> >machine (Intel 4way Pentium 3 box) overnight, while
> >on another newer machine (Intel 4way Xeon with HT) it didnt do so
> >well (time sped up after 3 or 4 hours). Hence I consider this
> >particular patch will need more review/work.
> >
> >  
> >
> 
> Does this patch help address the issues pointed out here?
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5127

Unfortunately no. The issue there is that once the lost tick
compensation code has fired, should those "lost" ticks appear later we
end up over-compensating.

This patch however does help to make sure that when the lost tick code
fires, the error from converting to usecs doesn't bite us. And could
probably go into mainline independent of the dynamic ticks patch (with
further testing, of course).

thanks
-john

