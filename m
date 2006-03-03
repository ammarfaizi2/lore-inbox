Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWCCKfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWCCKfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCCKfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:35:25 -0500
Received: from ozlabs.org ([203.10.76.45]:35776 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751250AbWCCKfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:35:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17416.7140.678168.734980@cargo.ozlabs.ibm.com>
Date: Fri, 3 Mar 2006 21:35:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: SMP Timekeeping regression in 2.6.16-rc5 (and 2.6.16-rc4)
In-Reply-To: <20060302210803.6ee4328a.mrmacman_g4@mac.com>
References: <20060301203611.4bf3f9c2.mrmacman_g4@mac.com>
	<20060302210803.6ee4328a.mrmacman_g4@mac.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett writes:

> Hi! Just built and installed a 2.6.16-rc5 kernel on my Powermac G4 Dual
> 1GHz (windtunnel model) and discovered a rather problematic timekeeping
> bug (not present in debian 2.6.15).  Essentially the two CPUs have
> completely different ideas about what day/time it is.  I booted into

Ouch!

It turns out that smp_core99_give/take_timebase are using a 32-bit
variable to transfer the timebase value from one cpu to the other.  So
the bottom 32 bits end up synchronized but the top 32 bits are quite
different, hence the different time of day on the two cpus.

The fix is to change `timebase' to be a u64.  I have that change
queued up in my powerpc-merge tree, which I'll ask Linus to pull
shortly.

Paul.
