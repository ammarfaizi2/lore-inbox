Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVGVLXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVGVLXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 07:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVGVLXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 07:23:55 -0400
Received: from [216.208.38.107] ([216.208.38.107]:8321 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S261162AbVGVLXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 07:23:54 -0400
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507212211400.6074@g5.osdl.org>
References: <200507212309_MC3-1-A534-95EF@compuserve.com>
	 <20050722132756.578acca7.akpm@osdl.org>
	 <Pine.LNX.4.58.0507212211400.6074@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 07:23:32 -0400
Message-Id: <1122031412.3577.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We do have the `used_math' optimisation in there which attempts to avoid
> > doing the FP save/restore if the app isn't actually using math.
> 
> No, it's more than that. There's a per-processor "used_math" flag to
> determine if we need to _initialize_ the FPU, but on context switches we 
> always assume the program we're switching to will _not_ use FP, and we 
> just set the "fault on FP" flag and do not normally restore FP state.

This shows room for optimization; if an app is consistently faulting to
use FP after a context switch, in principle the kernel could start to
assume that it will in the next timeslice as well.


> On the other hand, I also wouldn't be surprised if glibc (or similar

I doubt glibc is normally, at least most distros don't ship an SSE
enabled glibc, only an "i686" one.


