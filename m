Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWEDOSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWEDOSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWEDOSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:18:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50901 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751467AbWEDOSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:18:36 -0400
Date: Thu, 04 May 2006 10:18:35 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: sched_clock() uses are broken
In-reply-to: <44597A19.7050107@wildturkeyranch.net>
X-X-Sender: nico@localhost.localdomain
To: George Anzinger <george@wildturkeyranch.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0605040924490.28543@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
 <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0605021300140.28543@localhost.localdomain>
 <44597A19.7050107@wildturkeyranch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006, George Anzinger wrote:

> Nicolas Pitre wrote:
> > Yet that counter isn't necessarily nanosecond based.  So rescaling the
> > returned value to nanosecs requires expensive divisions which could be done
> > only once within sched_clock_diff() instead of twice as often in each
> > sched_clock() calls.
> 
> Oh phooey!!  Scaling can be done with a mpy and a shift.  See the new clock
> code where the TSC (or what ever) is scaled to ns.

I know.

And if you want to preserve more than 32 bits of precision you need 4 
mpy_and_add insns with a shift on ARM at least.

But the point remains that it is more efficient to do it once rather 
than twice or more.


Nicolas
