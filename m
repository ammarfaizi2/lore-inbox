Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVHYAeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVHYAeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVHYAeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:34:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36285 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932422AbVHYAeD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:34:03 -0400
Subject: Re: Incorrect CLOCK_TICK_RATE in 2.6 kernel
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <430D0FDA.3060201@mvista.com>
References: <430D0FDA.3060201@mvista.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 17:33:58 -0700
Message-Id: <1124930039.20820.123.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 17:24 -0700, George Anzinger wrote:
> CLOCK_TICK_RATE	is used by the kernel to compute LATCH, TICK_NSEC and 
> tick_nsec.  This latter is used to update xtime each tick.  TICK_NSEC is 
> then used to compute (at compile time) the conversion constants needed 
> to convert to/from jiffies from/to timespec and timeval (and others).
> 
> The problem is that, if the timer being used is either Cyclone or HPET, 
> the wrong CLOCK_TICK_RATE is used.

Err, the Cyclone does not generate interrupts. So this issue does not
affect those systems.

As for the HPET, it sets its own interrupt frequency based off of
KERNEL_TICK_USEC (which you're right, isn't quite what is used in the
jiffies conversions).  Would it be easier to just adjust that value to
use ACTHZ or CLOCK_TICK_RATE?

thanks
-john





