Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbSL3M6O>; Mon, 30 Dec 2002 07:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266984AbSL3M6O>; Mon, 30 Dec 2002 07:58:14 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:11436 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266983AbSL3M6N>;
	Mon, 30 Dec 2002 07:58:13 -0500
Message-ID: <3E1044D4.6050409@colorfullife.com>
Date: Mon, 30 Dec 2002 14:06:28 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DaveJ wrote:

>On Sat, Dec 28, 2002 at 10:37:06PM +0200, Ville Herva wrote:
>
> > > SYSCALL is AMD.  SYSENTER is Intel, and is likely to be significantly
> > Now that Linus has killed the dragon and everybody seems happy with the
> > shiny new SYSENTER code, let just add one more stupid question to this
> > thread: has anyone made benchmarks on SYSCALL/SYSENTER/INT80 on Athlon? Is
> > SYSCALL worth doing separately for Athlon (and perhaps Hammer/32-bit mode)?
>
>Its something I wondered about too. Even if it isn't a win for K7,
>it's possible that the K6 family may benefit from SYSCALL support.
>Maybe even the K5 if it was around that early ? (too lazy to check pdf's)
>  
>

I looked at SYSCALL once, and noticed some problems:

- it doesn't even load ESP with a kernel value, a task gate for NMI is 
mandatory.
- SMP support is only possible with a per-cpu entry point with 
(boot-time) fixups to the address where the entry point can find the 
kernel stack.
- The AMD docs contain one odd sentence:
"The CS and SS registers must not be modified by the operating system 
between the execution of the SYSCALL and the corresponding SYSRET 
instruction".
Is SYSCALL+iretd permitted? That's needed for execve, iopl, task 
switches, signal delivery.
What about interrupts during SYSCALLs? NMI to taskgate?

Either that sentence is just wrong, or SYSCALL is unusable.

It's not supported by the K5 cpu:
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/20734.pdf

--
    Manfred

