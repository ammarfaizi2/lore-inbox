Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263653AbREYIhj>; Fri, 25 May 2001 04:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263655AbREYIh3>; Fri, 25 May 2001 04:37:29 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:2309 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263653AbREYIhL>;
	Fri, 25 May 2001 04:37:11 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8 
In-Reply-To: Your message of "Fri, 25 May 2001 10:27:53 +0200."
             <20010525102753.A26379@gruyere.muc.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 18:37:04 +1000
Message-ID: <26797.990779824@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001 10:27:53 +0200, 
Andi Kleen <ak@suse.de> wrote:
>On Fri, May 25, 2001 at 06:25:57PM +1000, Keith Owens wrote:
>> Nothing in arch/i386/kernel/traps.c uses a task gate, they are all
>> interrupt, trap, system or call gates.  I guarantee that kdb on ix86
>> and ia64 uses the same kernel stack as the failing task, the starting
>> point for the kdb backtrace is itself and it does not follow segment
>> switches.
>
>I would consider this a bug in kdb then.

No more of a bug than panic(), show_stack(), printk() and all the other
routines that get called during a kernel problem.  They all use the
current kernel stack and they work almost all the time.  Kernel stack
overflows are symptoms of bad code, so fix the code, not the recovery
routines.

