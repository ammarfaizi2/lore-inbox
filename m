Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVDUQNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVDUQNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVDUQMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:12:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:48030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbVDUQMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:12:14 -0400
Date: Thu, 21 Apr 2005 09:13:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
cc: Steven Rostedt <rostedt@goodmis.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, jdavis@accessline.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer
 behavior in 2.6 vs 2.4  (1 extra tick)]
In-Reply-To: <4267CC7C.10907@nortel.com>
Message-ID: <Pine.LNX.4.58.0504210904450.2344@ppc970.osdl.org>
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com> 
 <1114052315.5058.13.camel@localhost.localdomain>  <1114054816.5996.10.camel@localhost.localdomain>
  <20050421095109.A25431@flint.arm.linux.org.uk> <1114080708.5996.16.camel@localhost.localdomain>
 <Pine.LNX.4.58.0504210752560.2344@ppc970.osdl.org> <4267CC7C.10907@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Apr 2005, Chris Friesen wrote:
> 
> Does mainline have a high precision monotonic wallclock that is not 
> affected by time-of-day changes?  Something like "nano/mico seconds 
> since boot"?

High precision? No. We do have "jiffies since boot". We don't actually
expose it anywhere, although you _can_ get it's "standardized version",
aka "centi-seconds per boot" from things like /proc/uptime.

(Not high-performance, but such an interface _could_ be. It's one of the
few things we could trivially map into the "system call page", and have
accessible to user space with just a simple read - faster even than the
"fast gettimeofday" implementations).

The thing is, most people who want the time of day want a real time with
some precision. Getting "approximate uptime" really really _really_ fast
might be useful for some things, but I don't know how many.

			Linus
