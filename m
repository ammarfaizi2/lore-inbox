Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWEJVFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWEJVFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWEJVFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:05:34 -0400
Received: from ozlabs.org ([203.10.76.45]:19845 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964857AbWEJVFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:05:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 07:05:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510.124003.04457042.davem@davemloft.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> From: Richard Henderson <rth@twiddle.net>
> Date: Wed, 10 May 2006 08:47:13 -0700
> 
> > How do you plan to address the compiler optimizing
>  ...
> > Across the schedule, we may have changed cpus, making the cached
> > address invalid.
> 
> Per-cpu variables need to be accessed only with preemption
> disabled.  And the preemption enable/disable operations
> provide a compiler memory barrier.

No, Richard has a point, it's not the value that is the concern, it's
the address, which gcc could assume is still valid after a barrier.
Drat.

Paul.
