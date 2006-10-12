Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422803AbWJLHwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422803AbWJLHwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWJLHwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:52:37 -0400
Received: from [195.171.73.133] ([195.171.73.133]:221 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S1422803AbWJLHwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:52:36 -0400
Date: Thu, 12 Oct 2006 07:52:35 +0000
From: andrew@walrond.org
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 intermittent parallel build failure
Message-ID: <20061012075235.GB2508@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20061011112558.GA23147@pelagius.h-e-r-e-s-y.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011112558.GA23147@pelagius.h-e-r-e-s-y.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 11:25:58AM +0000, andrew@walrond.org wrote:
> When compiling the kernel on a Sun T1000 ( Niagra - 6 cores/24
> threads) with
> 
> 	make -j12
> 
> I occasionally see failures like:
> 

This was due a serious bug in gnu make; see
	https://savannah.gnu.org/bugs/?14853

This effects most of the recent make releases, and is _not_
sun/sparc/solaris specific, so don't stop reading the bug report at
the first line ;)

I've posted a patch against make-3.81 which fixes it for me.

Symptoms: Random crashing of make worker sub-processes at high -j#.
More pronounced when threads are waiting on i/o (make enables SIGCHLD
interrupts for short periods which can interrupt read(2) in the worker
threads and EINTR isn't handled)

This will likely effect anyone using large -j# on larger
multi-core/multi-processor machines, so BEWARE!

Andrew Walrond
