Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVIQHk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVIQHk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 03:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVIQHk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 03:40:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48520 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750736AbVIQHk1 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 03:40:27 -0400
Date: Sat, 17 Sep 2005 13:04:39 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
Message-ID: <20050917073439.GG5569@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au> <Pine.LNX.4.61.0509141906040.3728@scrub.home> <20050914230049.F30746@flint.arm.linux.org.uk> <Pine.LNX.4.61.0509150010100.3728@scrub.home> <20050914232106.H30746@flint.arm.linux.org.uk> <4328D39C.2040500@yahoo.com.au> <Pine.LNX.4.61.0509170300030.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509170300030.3743@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 03:15:29AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Sep 2005, Nick Piggin wrote:
> 
> > Roman: any ideas about what you would prefer? You'll notice
> > atomic_inc_not_zero replaces rcuref_inc_lf, which is used several times
> > in the VFS.
> 
> In the larger picture I'm not completely happy with these scalibilty 
> patches, as they add extra overhead at the lower end. On a UP system in 
> general nothing beats:
> 
> 	spin_lock();
> 	if (*ptr)
> 		ptr += 1;
> 	spin_unlock();
> 
> The main problem is here that the atomic functions are used in two basic 
> situation:

Are you talking about the lock-free fdtable patches ? They don't replace
non-atomic locked critical sections by atomic operations. Reference counting
is already there to extend the life of objects beyond locked critical
setions.

Thanks
Dipankar
