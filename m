Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTKZHbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 02:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTKZHbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 02:31:42 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:523 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262356AbTKZHbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 02:31:40 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1069831506@astro.swin.edu.au>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos>
X-Face: A>QmH)/u`[d}b.a5?Xq=L&d?Q}cF5x|wu#O_mAK83d(Tw,BjxX[}n4<13.e$"d!Gg(I%n8fL)I9fZ$0,8s3_5>iI]4c%FXg{CpVhuIuyI,W'!5Cl?5M,dL-*dHYs}K9=YQZCN-\2j1S>cU6XPXsQhz$x`M\ZEV}nPw'^jPc41FiwTQZ'g)xNK{2',](o5mrODBHe))
Message-ID: <slrn-0.9.7.4-9248-27858-200311261825-tc@hexane.ssi.swin.edu.au>
Date: Wed, 26 Nov 2003 18:31:37 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> said on Tue, 25 Nov 2003 15:17:28 -0500 (EST):
> On Tue, 25 Nov 2003, Ihar 'Philips' Filipau wrote:
> 
> As documented, malloc() will never fail as long as there
> is still address space (not memory) available. This is
> the required nature of the over-commit strategy. This is
> necessary because many programs never even touch all the
> memory they allocate.
> 
> You can turn OFF over-commit by doing:
> 
> echo "2" >proc/sys/vm/overcommit_memory
> 
> However, you will probably find that many programs fail
> or seg-fault when normally they wouldn't. So, if you don't
> mind restarting sendmail occasionally, then turn off over-commit.

I consider this a bug. If they don't use the memory, don't alloc
it. It's not the responsibility of the kernel to determine whether the
programmer was sane. If the programmer was sane, then he may well have
been trying to keep some memory availble for emergency use, and
wouldn't want his program dying from an untrapable kill signal. 

Or he was just lazy, and if he's lazy enough to allocate too much
memory, he'll also be lazy enough to "forget" to check for malloc()s
return value, and hence his program will crash when derefencing
NULL. Bug reports will be filed against his application, like it was
meant to, because it was his fault. Not the kernel's.

Hence 2 should be the default. 

0 should be left for those poor fools who run closed source software,
and can't get their vendor to fix their bugs, so need to use some
kernel kludges (ie, overcommit) to get around it.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
"Consider a spherical bear, in simple harmonic motion..."
                -- Professor in the UCB physics department
