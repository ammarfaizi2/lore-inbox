Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRLLKdK>; Wed, 12 Dec 2001 05:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRLLKdB>; Wed, 12 Dec 2001 05:33:01 -0500
Received: from ucs.co.za ([196.23.43.2]:58119 "EHLO ucs.co.za")
	by vger.kernel.org with ESMTP id <S276369AbRLLKcw>;
	Wed, 12 Dec 2001 05:32:52 -0500
Subject: Re: PROBLEM: Kernel Oops on cat /proc/ioports
From: Berend De Schouwer <bds@jhb.ucs.co.za>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C16ADB1.F9E847E9@zip.com.au>
In-Reply-To: <1008073796.5535.5.camel@bds.ucs.co.za> 
	<3C16ADB1.F9E847E9@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Dec 2001 12:30:19 +0200
Message-Id: <1008153019.8534.15.camel@bds.ucs.co.za>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-12 at 03:06, Andrew Morton wrote:
> Berend De Schouwer wrote:
> > 
> > [1.] One line summary of the problem:
> > 
> > Running "cat /proc/ioports" causes a segfault and kernel oops.
> > 
> > ...
> > [7.3.] Module information (from /proc/modules):
> > 
> > cyclades              147616  16 (autoclean)
> 
> cyclades does request_region(), but forgets to do release_region().
> This will leave the region allocated in kernel data structures,
> but its "name" field resides in module memory.
> 
> So if you load cyclades.o, then rmmod it, then cat /proc/ioports,
> you'll touch unmapped memory and go boom.

I have confirmed this.  rmmod cyclades && cat /proc/ioports causes the
oops (but not necessarily a system crash).  I have a applied your patch,
and repeatedly ran insmod cyclades && rmmod cyclades && cat
/proc/ioports without causing the kernel oops.
> 
> Some brave soul needs to teach cyclades about release_region().
> Shame the Nobel prizes are all gone this year.

Thanks very much for the patch.

PS.  I needed to change the offsets to apply your patch to 2.4.14, but
no logic was changed.

> -
-- 
Berend De Schouwer

