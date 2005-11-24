Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVKXADz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVKXADz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbVKXADz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:03:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9777
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932592AbVKXADy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:03:54 -0500
Date: Thu, 24 Nov 2005 01:03:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: Dual opteron various segfaults with 2.6.14.2 and earlier kernels
Message-ID: <20051124000351.GT18321@opteron.random>
References: <200511231537.49320.cova@ferrara.linux.it> <200511232255.57716.andrew@walrond.org> <200511240026.42212.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511240026.42212.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabio,

On Thu, Nov 24, 2005 at 12:26:41AM +0100, Fabio Coatti wrote:
> yes, uname says  2.6.14.2; on a second identical machine, I've just seen this:
> 
> 
> factorial[2352]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
> 00007fffffbfaf60 error 4
> factorial[2354]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
> 00007fffffe3fc70 error 4
> factorial[2361]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
> 00007fffffb07c50 error 4
> factorial[2358]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
> 00007fffffb07c50 error 4
> factorial[2363]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
> 00007fffffe6d270 error 4
> 
> the kernel and HW are the same.

Error 4 means a read in userland on a not mapped area.

The above isn't necessairly a kernel or hardware problem, it looks like
an userland bug if it segfaults at such a low address (20f31). Nothig is
mapped below "0x400000" exactly to catch these kind of bugs. 

You should debug the program and check what's the code at address
0x4035ae? You can check it with gdb or objdump -d. Probably there's a
64bit bug in the program that doesn't trigger on x86 32bit (or you may
not be noticing the segfault on 32bits because it wouldn't be logged in
the syslog).

Hope this helps ;)
