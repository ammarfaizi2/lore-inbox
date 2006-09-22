Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWIVXxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWIVXxB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWIVXxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:53:01 -0400
Received: from cantor2.suse.de ([195.135.220.15]:2003 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964950AbWIVXxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:53:00 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Sat, 23 Sep 2006 01:52:43 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1158925861.26261.3.camel@localhost.localdomain> <20060922123215.GA98728@muc.de> <45146725.4070109@goop.org>
In-Reply-To: <45146725.4070109@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609230152.43713.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 00:43, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > BTW I changed my copy sorry. I redid the early PDA support
> > to not be in assembler.
> 
> I went to the trouble of making the PDA completely set up before any C 
> code ran.  

Yes, but your patch never applied to anything even remotely 
looking like the code in my tree. I got so frustrated that
I ended up reimplementing it in a cleaner way.

Now head.S calls i386_start_kernel() and that calls pda_init()
without any additional assembly code or other special cases etc. 

This is very similar to how x86-64 works.

> which means that that they 
> have to work from the first function prologue.

I mainly did it to fix lockdep.

I used to do mcount hacks myself, but you typically need
a few special annotations for those anyways so I am not too 
concerned about them.

> It also simplifies things to get all that set up ASAP so there's no 
> bootstrap dependency problem.

Yes no argument on that.

-Andi
