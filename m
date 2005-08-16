Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVHPS0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVHPS0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVHPS0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:26:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56731 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030284AbVHPS0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:26:09 -0400
Date: Tue, 16 Aug 2005 11:25:32 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: john stultz <johnstul@us.ibm.com>
cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124151001.8630.87.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0508161116270.7101@schroedinger.engr.sgi.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005, john stultz wrote:

> Sorry. It was subtle, but after thinking more about your arguments, I've
> stepped back from my earlier goals of replacing the timekeeping code for
> all arches and instead I've decided to just focus on allowing
> architectures that would duplicate code using a continuous timesource
> use a common code base.  

Thats great!

> Think of it more as a replacement for the time_interpolator code (which
> thanks to Christoph Lameter, it is quite influenced by).

I have no objection to replacing the time_interpolator code if the 
timesources provide a superset of functionality. Rename time_interpolator 
to timesource (including all currently existing interpolator defintions 
which will become time sources) and modify/add fields to be able to 
satisfy your requirements. The interpolator compensations may become not 
necessary if the upper layers can deal with discrepancies between timer 
interrupts and actual intervals occurring between these interrupts and if 
the upper layer can adjust the time source in use.

You mentioned that the NTP code has some issues with time interpolation 
at the KS. This is due to the NTP layer not being aware of actual time 
differences between timer interrupts that the interpolator knows about. If 
the NTP layer would be aware of the actual intervals measured by the 
timesource (or interpolator) then presumably time could be adjusted in a 
more accurate way.

