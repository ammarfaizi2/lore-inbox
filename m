Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSHCMat>; Sat, 3 Aug 2002 08:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSHCMat>; Sat, 3 Aug 2002 08:30:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4310 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317550AbSHCMas>; Sat, 3 Aug 2002 08:30:48 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208031233.g73CXUB02612@devserv.devel.redhat.com>
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
To: mingo@elte.hu
Date: Sat, 3 Aug 2002 08:33:30 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rz@linux-m68k.org (Richard Zidlicky),
       jdike@karaya.com (Jeff Dike), alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain> from "Ingo Molnar" at Aug 03, 2002 01:38:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> actually the opposite is true, on a 2.2 GHz P4:
> 
>   $ ./lat_sig catch
>   Signal handler overhead: 3.091 microseconds
> 
>   $ ./lat_ctx -s 0 2
>   2 0.90
> 
> ie. *process to process* context switches are 3.4 times faster than signal
> delivery. Ie. we can switch to a helper thread and back, and still be
> faster than a *single* signal.

Thats interesting indeed. I'd not tried it with the O(1) scheduler.

> signals are in essence 'lightweight' threads created and destroyed for the
> purpose of a single asynchronous event, it's IMO a very inefficient and
> baroque concept for almost anything (but debugging and a number of very
> special uses). I'd guess that with a sane threading library a helper
> thread is faster for almost everything.

Which would argue UML ought to have a positively microkernel view of
syscalls - sending a message ?
