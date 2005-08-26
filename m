Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVHZTeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVHZTeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVHZTeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:34:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:22744 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030225AbVHZTeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:34:00 -0400
Date: Fri, 26 Aug 2005 12:33:23 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: george@mvista.com, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Need better is_better_time_interpolator() algorithm
In-Reply-To: <1125084417.5182.58.camel@tdi>
Message-ID: <Pine.LNX.4.62.0508261231440.16138@schroedinger.engr.sgi.com>
References: <1124988269.5331.49.camel@tdi>  <1124991406.20820.188.camel@cog.beaverton.ibm.com>
  <1124995405.5331.90.camel@tdi>  <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com>
  <1125073089.5182.30.camel@tdi>  <430F6A7E.203@mvista.com> <1125084417.5182.58.camel@tdi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Alex Williamson wrote:

>    Would we ever want to favor a frequency shifting timer over anything
> else in the system?  If it was noticeable perhaps we'd just need a
> callback to re-evaluate the frequency and rescan for the best timer.  If
> it happens without notice, a flag that statically assigns it the lowest
> priority will due.  Or maybe if the driver factored the frequency
> shifting into the drift it would make the timer undesirable without
> resorting to flags.  Thanks,

Timers are usually constant. AFAIK Frequency shifts only occur through 
power management. In that case we usually have some notifiers running 
before the change. These notifiers need to switch to a different time 
source if the timer frequency will be shifting or the timer will become 
unavailable.

