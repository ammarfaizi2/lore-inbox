Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbUCDTCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 14:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUCDTCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 14:02:42 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:64449 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262082AbUCDTCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 14:02:37 -0500
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
From: john stultz <johnstul@us.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4046E455.4010605@redhat.com>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
	 <1078359137.10076.193.camel@cog.beaverton.ibm.com>
	 <1078359191.10076.195.camel@cog.beaverton.ibm.com>
	 <1078359248.10076.197.camel@cog.beaverton.ibm.com>
	 <20040304005542.GZ4922@dualathlon.random>  <40469194.5080506@redhat.com>
	 <1078368197.10076.252.camel@cog.beaverton.ibm.com>
	 <4046E455.4010605@redhat.com>
Content-Type: text/plain
Message-Id: <1078426940.10076.269.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 04 Mar 2004 11:02:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-04 at 00:09, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> john stultz wrote:
> 
> > Before we start up this larger debate again, might there be some short
> > term solution for my patch that would satisfy both of you?
> 
> I suggest the following:
> 
> ~ define a symbol __kernel_gettimeofday_offset in the vdso's symbol
> table.  This should be an absolute symbol containing the offset of the
> gettimeofday implementation from the beginning of the vdso (the address
> passed up in the auxiliary vector)
> 
> ~ glibc can then use the equivalent of
> dlsym("__kernel_gettimeofday_offset").  If the symbol is not defined,
> it's not used (doh).  If it is defined, the final function address is
> computed by adding the offset to the vdso address.
> 
> 
> This ensures a direct jump and it still keeps the vdso relocatable
> without modifying the symbol table.

Excellent, this sounds similar to what Andrea was suggesting. 
I'll start working to implement this.

thanks for the momentary truce ;)
-john

