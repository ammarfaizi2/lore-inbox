Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTIDBrC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTIDBrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:47:02 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:59843 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S264495AbTIDBqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:46:52 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Steven Cole <elenstev@mesatop.com>, Antonio Vargas <wind@cocodriloo.com>
Subject: Re: Scaling noise
Date: Thu, 4 Sep 2003 03:50:31 +0200
User-Agent: KMail/1.5.3
Cc: Larry McVoy <lm@bitmover.com>, CaT <cat@zip.com.au>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <20030903124716.GE2359@wind.cocodriloo.com> <1062603063.1723.91.camel@spc9.esa.lanl.gov>
In-Reply-To: <1062603063.1723.91.camel@spc9.esa.lanl.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309040350.31949.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 September 2003 17:31, Steven Cole wrote:
> On Wed, 2003-09-03 at 06:47, Antonio Vargas wrote:
> > As you may probably know, CC-clusters were heavily advocated by the
> > same Larry McVoy who has started this thread.
>
> Yes, thanks.  I'm well aware of that.  I would like to get a discussion
> going again on CC-clusters, since that seems to be a way out of the
> scaling spiral.  Here is an interesting link:
> http://www.opersys.com/adeos/practical-smp-clusters/

As you know, the argument is that locking overhead grows by some factor worse 
than linear as the size of an SMP cluster increases, so that the locking 
overhead explodes at some point, and thus it would be more efficient to 
eliminate the SMP overhead entirely and run a cluster of UP kernels, 
communicating through the high bandwidth channel provided by shared memory.

There are other arguments, such as how complex locking is, and how it will 
never work correctly, but those are noise: it's pretty much done now, the 
complexity is still manageable, and Linux has never been more stable.

There was a time when SMP locking overhead actually cost something in the high 
single digits on Linux, on certain loads.  Today, you'd have to work at it to 
find a real load where the 2.5/6 kernel spends more than 1% of its time in 
locking overhead, even on a large SMP machine (sample size of one: I asked 
Bill Irwin how his 32 node Numa cluster is running these days).  This blows 
the ccCluster idea out of the water, sorry.  The only way ccCluster gets to 
live is if SMP locking is pathetic and it's not.

As for Karim's work, it's a quintessentially flashy trick to make two UP 
kernels run on a dual processor.  It's worth doing, but not because it blazes 
the way forward for ccClusters.  It can be the basis for hot kernel swap: 
migrate all the processes to one of the two CPUs, load and start a new kernel 
on the other one, migrate all processes to it, and let the new kernel restart 
the first processor, which is now idle.

Regards,

Daniel

