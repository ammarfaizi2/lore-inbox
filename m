Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130381AbRCPHhf>; Fri, 16 Mar 2001 02:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRCPHhZ>; Fri, 16 Mar 2001 02:37:25 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:31416 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S130384AbRCPHhQ>;
	Fri, 16 Mar 2001 02:37:16 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103160736.XAA04682@csl.Stanford.EDU>
Subject: Re: [CHECKER] 9 potential copy_*_user bugs in 2.4.1
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 15 Mar 2001 23:36:23 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <Pine.GSO.4.21.0103152146550.10709-100000@weyl.math.psu.edu> from "Alexander Viro" at Mar 15, 2001 10:11:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like you've missed at least one place. Have you marked pointer
> arguments of syscalls as tainted? Path in question looks so:

In the exokernel param checker we do, but not for the one in linux ---
most of the pointers seemed to be devices, so I never added it.  Afer
your for bug example, I'll go hack the checker ;-)

> 	* if method's argument is ever tainted - all instances of that
> method have that argument tainted.
> 
> Is it possible to implement? The last rule may be tricky - we need to
> remember that field foo of structure bar has tainted nth argument and
> keep track of all functions assigned to foo, either by initialization
> or by direct assignment. Could that be done?

It should be.  We're using a trick similar to this one to build up
equivalence classes of interrupt handlers tracking which functions are
assigned to struct fields, or passed as the same parameter to a
function (request_irq being the prime example).  You'd expect that if 
any function passed/assigned to a given function/field is an 
interrupt handler then the rest are too.

The big win will be when checkers can get at global data structure
initializers.  From an outsiders view, it seems like most device
methods are registered that way.

Dawson
Dawson
