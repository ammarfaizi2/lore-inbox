Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263636AbREYI0t>; Fri, 25 May 2001 04:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263640AbREYI0a>; Fri, 25 May 2001 04:26:30 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:39172 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263636AbREYI0D>;
	Fri, 25 May 2001 04:26:03 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8 
In-Reply-To: Your message of "Fri, 25 May 2001 10:14:57 +0200."
             <20010525101457.A26038@gruyere.muc.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 18:25:57 +1000
Message-ID: <26405.990779157@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001 10:14:57 +0200, 
Andi Kleen <ak@suse.de> wrote:
>On Fri, May 25, 2001 at 03:20:20PM +1000, Keith Owens wrote:
>> You cannot recover from a kernel stack overflow even with kdb.  The
>> exception handler and kdb use the stack that just overflowed.
>
>Hmm, I thought it used an own stack using an appropiate gate.
>At least on x86-64 I implemented it this way using a static 4K array.

Nothing in arch/i386/kernel/traps.c uses a task gate, they are all
interrupt, trap, system or call gates.  I guarantee that kdb on ix86
and ia64 uses the same kernel stack as the failing task, the starting
point for the kdb backtrace is itself and it does not follow segment
switches.

