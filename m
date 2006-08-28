Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWH1HXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWH1HXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWH1HXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:23:32 -0400
Received: from mail.suse.de ([195.135.220.2]:20170 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932134AbWH1HXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:23:31 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Mon, 28 Aug 2006 09:23:24 +0200
User-Agent: KMail/1.9.3
Cc: "Dong Feng" <middle.fengdong@gmail.com>,
       "Christoph Lameter" <clameter@sgi.com>, linux-kernel@vger.kernel.org
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <17650.13915.413019.784343@cargo.ozlabs.ibm.com>
In-Reply-To: <17650.13915.413019.784343@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608280923.24677.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I believe the reason for not doing something like this on x86 was the
> fact that we still support i386 processors, which don't have the
> cmpxchg instruction.  

i386 emulates cmpxchg these days (other than that most likely 99.9+% of all
386s are already long beyond their MTBF, so they shouldn't be a major concern)

> That's fair enough, but I would be opposed to 
> making semaphores bigger 

If the code was out of lined bigger wouldn't make much difference
And if it worked for spinlocks I don't see why it shouldn't for semaphores.

> and slower on PowerPC because of that. 

The question is if it really makes much difference. When semaphores
are congested in my experience the major overhead is in the scheduler
anyways.

That would leave the fast path, but does it help that much there
to have a more complicated implementation?
-Andi

