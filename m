Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTKTDHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 22:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTKTDHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 22:07:21 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:43922 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264277AbTKTDHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 22:07:18 -0500
Subject: Re: high res timestamps and SMP
From: john stultz <johnstul@us.ibm.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FBBF148.20203@nortelnetworks.com>
References: <3FBBF148.20203@nortelnetworks.com>
Content-Type: text/plain
Organization: 
Message-Id: <1069297341.23568.130.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Nov 2003 19:02:22 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 14:40, Chris Friesen wrote:
> We have a requirement to have high-res timestamps available on SMP systems.
> 
> Assuming that we are running identical cpus, is a sync-up at boot time 
> enough to give usable time values, or do I need to do force periodic 
> re-syncs?

If the cpus (or their time stamp counter) are all driven by the same
signal and you do not suffer from NUMA effects, then syncing them should
be enough. 

However, if you suffer from NUMA effects, or if the counters are not
driven off the same signal, its likely you could run into problems. 

> We're currently looking at MIPS, x86 (Xeons), and PPC.

o No clue on MIPS.

o The x86 TSC is a horrible time source, but may work well enough on
simple SMP systems. 

o PPC has a nice in-cpu time-base register (ppc folks, feel free to
smack or correct me on this) which is driven off the bus-clock and is
synced in hardware. 


good luck!
-john

