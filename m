Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWJLRTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWJLRTg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWJLRTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:19:36 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:34064 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750950AbWJLRTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:19:35 -0400
Date: Thu, 12 Oct 2006 18:19:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
Message-ID: <20061012171929.GB24658@flint.arm.linux.org.uk>
Mail-Followup-To: John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <452E62F8.5010402@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452E62F8.5010402@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 11:44:56AM -0400, John Richard Moser wrote:
> Can context switches be made faster?  This is a simple question, mainly
> because I don't really understand what happens during a context switch
> that the kernel has control over (besides storing registers).

They can be, but there's a big penalty that you pay for it.  You must
limit the virtual memory space to 32MB for _every_ process in the
system, and if you have many processes running (I forget how many)
you end up running into the same latency problems.

The latency problem comes from the requirement to keep the cache
coherent with the VM mappings, and to this extent on Linux we need to
flush the cache each time we change the VM mapping.

There have been projects in the past which have come and gone to
support the "Fast Context Switch" approach found on these CPUs, but
patches have _never_ been submitted, so I can only conclude that the
projects never got off the ground.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
