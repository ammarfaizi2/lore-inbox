Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131216AbRCGV5j>; Wed, 7 Mar 2001 16:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131217AbRCGV5U>; Wed, 7 Mar 2001 16:57:20 -0500
Received: from fungus.teststation.com ([212.32.186.211]:59858 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S131215AbRCGV4c>; Wed, 7 Mar 2001 16:56:32 -0500
Date: Wed, 7 Mar 2001 22:55:48 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Q. about oops backtrace
In-Reply-To: <20010307152847.C19671@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0103072240200.3057-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Pete Zaitcev wrote:

> Trace; c0127414 <handle_mm_fault+114/1a0>
> Trace; c0136a2d <kunmap_high+7d/90>
> Trace; c012722e <do_anonymous_page+de/110>
> Trace; c0127290 <do_no_page+30/a0>
> Trace; c0127414 <handle_mm_fault+114/1a0>
> Trace; c014cdec <dput+1c/170>
> Trace; c0143f80 <cached_lookup+10/50>
> Trace; c0144aae <path_walk+85e/940>
> Trace; c014cdec <dput+1c/170>
> Trace; c01392c9 <chrdev_open+59/a0>
> Trace; c0138130 <dentry_open+c0/150>
> Trace; c013805d <filp_open+4d/60>
> Trace; c0148b97 <sys_ioctl+247/2a0>
> Trace; c01091c7 <system_call+33/38>
> 
> What is with those recursive handle_mm_fault calls?

Unless I'm mistaken the call trace in an i386 oops is printed by
arch/i386/kernel/traps.c:show_trace()

And it simply prints any value within certain limits.
                if (((addr >= (unsigned long) &_stext) &&
                     (addr <= (unsigned long) &_etext)) ||
                    ((addr >= module_start) && (addr <= module_end))) {
			/* ... print it ... */

If a function is passed as a parameter it will of course be on the stack,
even when it isn't a return value.

The dput entries are strange too, does dput call path_walk?
(is the translation from numbers to symbols correct?)

/Urban

