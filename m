Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSJMNXH>; Sun, 13 Oct 2002 09:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbSJMNXH>; Sun, 13 Oct 2002 09:23:07 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:17909 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261518AbSJMNXG>;
	Sun, 13 Oct 2002 09:23:06 -0400
Date: Sun, 13 Oct 2002 15:28:44 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210131328.PAA14675@harpo.it.uu.se>
To: jcdutton@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kernel api for application profiling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002 21:08:30 +1000, James Courtier-Dutton wrote:
>I wish to be able to make a function call to start a timer, and then 
>later on in the program stop the timer and therefore gather information 
>about how long a particular routine took.
>The problem I have is that between start of timer and stop of timer, the 
>kernel might task switch to another thread or process. I would like this 
>kernel task switch to automatically stop the timer, and then restart it 
>when I get CPU time returned. I cannot find any such API availiable 
>currently in the linux kernel.

perfctr & PAPI support this. perfctr virtualises the TSC which
gives you high-res process times, and sampling is extremely
light-weight (no syscalls involved) so measuring small blocks
of code is feasible & accurate.
perfctr is a low-level Linux/x86-specific framework. PAPI is
a higher-level framework which supports a number of platforms.
PAPI uses perfctr on Linux/x86.

Both perfctr and PAPI also let you set up CPU performance
counters for counting other things than clock cycles.

See:
<http://www.csd.uu.se/~mikpe/linux/perfctr/>
<http://icl.cs.utk.edu/projects/papi/>

>Also, as an extension to this, it would be nice to know which other 
>tasks happened during the task switch. The reason I would like this, is 
>so that I can tell if the time was taken reading data off the hard disk 
>or instead time spent by X displaying/transfering to screen the next 
>video frame. If too much time is being spent doing a task like reading 
>from the hard disk, I would need to look into reducing the latency of 
>that task. This might also highlight buggy modules that take up too much 
>of a time slice. I have seen some task switches take 800ms away from my 
>audio out thread, and therefore causing underruns on the sound hardware, 
>that then causes glitches in the perceived audio coming from the speakers.

This could perhaps be measured by programming a TSC-like event into
a performance counter and programming it to count in kernel-mode only.
P6, K7, and P4 should all support this.

And before people ask me: perfctr is not yet in official kernels,
I'm working on a cleaned up version for 2.5 submission RSN,
perfctr isn't easy for newbies to use due to HW-specific details,
but PAPI gives you a nice cosy high-level API.

/Mikael
