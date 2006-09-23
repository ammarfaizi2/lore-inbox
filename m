Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWIWIR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWIWIR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 04:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWIWIR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 04:17:57 -0400
Received: from colin.muc.de ([193.149.48.1]:39183 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751120AbWIWIR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:17:56 -0400
Date: 23 Sep 2006 10:17:55 +0200
Date: Sat, 23 Sep 2006 10:17:55 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Message-ID: <20060923081755.GB10534@muc.de>
References: <1158925861.26261.3.camel@localhost.localdomain> <1158925997.26261.6.camel@localhost.localdomain> <1158926106.26261.8.camel@localhost.localdomain> <1158926215.26261.11.camel@localhost.localdomain> <1158926308.26261.14.camel@localhost.localdomain> <1158926386.26261.17.camel@localhost.localdomain> <20060922123215.GA98728@muc.de> <1158987075.26261.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158987075.26261.79.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mainly that it makes more sense to use the existing per-cpu concept than
> introduce another kind of per-cpu var within a special structure, but
> it's also more efficient (see other post).  Hopefully it will spark

What post exactly?  AFAIK it is the same code for common code.

The advantage of the PDA split is that the important variables which are 
in the PDA can be accessed with a single reference, while generic portable
per CPU data is the same as it was before. With your scheme even
the PDA accesses are at least two instructions, right? (I don't
think gcc/ld can resolve the per cpu section offset into a constant,
so it has to load them into a register first) 

> interest in making dynamic-percpu pointers use the same offset scheme,
> now x86 will experience the benefits.
> 
> And we might even get a third user of local_t!

I'm not holding my breath. I guess it was a nice idea before preemption
became popular ...

-Andi
