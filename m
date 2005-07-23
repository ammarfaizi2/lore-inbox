Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVGWRdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVGWRdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVGWRdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:33:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262130AbVGWRdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:33:20 -0400
Date: Sat, 23 Jul 2005 10:33:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
In-Reply-To: <200507230313_MC3-1-A554-6928@compuserve.com>
Message-ID: <Pine.LNX.4.58.0507231030150.6074@g5.osdl.org>
References: <200507230313_MC3-1-A554-6928@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Jul 2005, Chuck Ebbert wrote:
> 
>    Probably a very minor point, but shouldn't it be
> 
>                         "m" ((tsk)->thread.i387.fxsave))
> 
> because that's the largest possible operand that could end up being read?

Yes, I ended up fixing that already (along with handling the fxsave case 
too).

>   Is that function called __save_init_fpu because it saves and then
> initializes the fpu?  Unlike fsave, fxsave does not init the fpu after
> it saves the state; to make the behavior match it should be "fxsave ; fninit"

The "init" part is really just "reset_exceptions" - we don't care about
the rest of the state, and the naming is historical (ie it's really called
"init" because "fnsave" does the reset by re-initializing everything, ie 
there's an implied "fninit").

So for the fxsave path, we just use fnclex, since that's faster than a
full fninit.

			Linus
