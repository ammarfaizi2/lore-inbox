Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWFSIVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWFSIVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWFSIVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:21:07 -0400
Received: from ns.suse.de ([195.135.220.2]:21396 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932310AbWFSIVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:21:06 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Mon, 19 Jun 2006 10:21:03 +0200
User-Agent: KMail/1.8
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz
References: <200606140942.31150.ak@suse.de> <20060618171511.e0e6de26.pj@sgi.com>
In-Reply-To: <20060618171511.e0e6de26.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191021.03631.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 02:15, Paul Jackson wrote:

>
> Roughly, he was looking to support something resembling the kernel's
> per-cpu data in userland library code for high performance scientific
> number crunching, for things like statistics gathering and perhaps (not
> sure of this) reduce locking costs.

While vgetcpu() can be used for this most likely glibc TLS is already 
good enough for this. So it will help, but I don't think it's the primary
motivation.

> I see "x86-64" in the Subject.  I don't see why this facility is
> arch-specific.  Could it work on any arch, ia64 being the one of
> interest to me?

The implementation is x86-64 specific and optimized for x86-64. You could 
probably implement something with the same prototype for IA64 too,
although the internal implementation will likely be very different
(there is nothing x86-64 specific in the prototype) 

AFAIK ia64 supports fast system calls so it might be possible to 
do a simple implementation without vsyscalls.

> I have some ignorance on your references to "CPUID(1)".  I don't recall
> what it is.  The only command so named I find on my systems are a

CPUID 1 is a x86 instruction that is one way to implement a user level
vgetcpu on x86.

-Andi
