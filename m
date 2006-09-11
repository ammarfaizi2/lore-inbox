Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWIKSg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWIKSg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWIKSg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:36:58 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:38617 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964837AbWIKSg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:36:58 -0400
Message-ID: <4505ACBC.9050505@oracle.com>
Date: Mon, 11 Sep 2006 11:36:44 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] check pr_debug() arguments
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>	<20060908225529.9340.75338.sendpatchset@kaori.pdx.zabbo.net> <20060908164908.abb98076.akpm@osdl.org>
In-Reply-To: <20060908164908.abb98076.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> This results in a seemingly insignificant code size increase.  A x86-64
>> allyesconfig:
>>
>>    text    data     bss     dec     hex filename
>> 25354768        7191098 4854720 37400586        23ab00a vmlinux.before
>> 25354945        7191138 4854720 37400803        23ab0e3 vmlinux
> 
> Which would indicate that we might have expressions-with-side-effects
> inside pr_debug() statements somewhere, which is risky.  I wonder where?

I browsed through some of the functions that bloat-o-meter reported an
increase for.  Some seemed reasonable as they used things like current
or AFFS_I() in arguments.  Others seemed pretty mysterious as they
didn't have obvious pr_debug() calls.

$ uname -m ; gcc --version
x86_64
gcc (GCC) 4.1.1 20060525 (Red Hat 4.1.1-1)

> btw, what's up with aio.c using a combination of pr_debug() and dprintk(),
> and a combination of `#ifdef DEBUG' and `#if DEBUG > 1'?  Confusing.

I'm not sure how it got that way but I don't think anyone will object to
simplifying it.  I'll spend those 5 minutes :).

> It would be nice to have a single way of doing developer-debug in-tree.  We
> have 182(!) different definitions of dprintk().  Please nobody cc me on that
> discussion though ;)

Agreed, on both counts :).

- z

