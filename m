Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVGWHNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVGWHNX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 03:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVGWHNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 03:13:23 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:57796 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S261337AbVGWHNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 03:13:22 -0400
Date: Sat, 23 Jul 2005 03:09:27 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200507230313_MC3-1-A554-6928@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Date: Fri, 22 Jul 2005 at 16:19:25 -0700 (PDT), Linus Torvalds wrote:

>       /*
>        * The "nop" is needed to make the instructions the same
>        * length.
>        */
>       #define restore_fpu(tsk)                        \
>               alternative_input(                      \
>                       "nop ; frstor %1",              \
>                       "fxrstor %1",                   \
>                       X86_FEATURE_FXSR,               \
>                       "m" ((tsk)->thread.i387.fsave))

   Probably a very minor point, but shouldn't it be

                        "m" ((tsk)->thread.i387.fxsave))

because that's the largest possible operand that could end up being read?


> Now, we should do the same for "fnsave ; fwait" vs "fxsave ; fnclex" too,
> but I was lazy. If somebody wants to try that, it would need an 
> "alternative_output()" define but should otherwise be trivial too.

  Is that function called __save_init_fpu because it saves and then
initializes the fpu?  Unlike fsave, fxsave does not init the fpu after
it saves the state; to make the behavior match it should be "fxsave ; fninit"


__
Chuck
