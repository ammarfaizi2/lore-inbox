Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUGPCpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUGPCpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 22:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266253AbUGPCpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 22:45:24 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:14530 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266240AbUGPCpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 22:45:22 -0400
Date: Thu, 15 Jul 2004 19:44:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       ia64 <linux-ia64@vger.kernel.org>
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
 posix-timer functions to return higher accuracy)
In-Reply-To: <40F70C6D.5050506@mvista.com>
Message-ID: <Pine.LNX.4.58.0407151941010.24953@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
 <1089835776.1388.216.camel@cog.beaverton.ibm.com> <40F70C6D.5050506@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2004, George Anzinger wrote:

> As to accuracy, the more "accurate" way is to change get_offset to return
> nanoseconds.  This way there is only one round off (by the divide) instead of
> two (the get_offset and the divide).  I ran into this problem in the latest HRT
> patch.  One of my tests is to do a gettimeofday and a clock_gettime and make
> sure there is no "backward" stuff happening.  Test failed by 1 micro second
> "some" of the time because of this double round off.

Well yes this is what the interpolator etc does on IA64.
time_interpolator_get_offset returns nanoseconds. I have done
tests to insure that no backward stuff happens. Tests were done
with the mentioned patch and clock_gettime was returning nanosecond
accuracy.


