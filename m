Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131776AbQJ2PiC>; Sun, 29 Oct 2000 10:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131789AbQJ2Phw>; Sun, 29 Oct 2000 10:37:52 -0500
Received: from www.collectingnation.com ([206.183.160.80]:22788 "EHLO
	www.beanienation.com") by vger.kernel.org with ESMTP
	id <S131776AbQJ2Pho>; Sun, 29 Oct 2000 10:37:44 -0500
Date: Sun, 29 Oct 2000 10:41:01 -0500 (EST)
From: John Babina III <babina@pex.net>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: SMP System 2.2.15 #2 locking & Memory oddness?
Message-ID: <Pine.LNX.4.20.0010291020560.7464-100000@pioneer.local.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been investigating this for quite a while and am at a
loss... (Please let me know if you need more information or this post is
unclear in anway, I tried to make it as complete as possible)

I am running a heavily hit web server (around half a million hits a
day) and am getting random lockups (system cannot even be pinged) with no
warnings or errors and also the memory usage stats seem to fluctuate
randomly. 

The machine is randomly locking up 1-2 times a day, with basically no
syslog errors except this one recently just before a crash:

Oct 28 01:38:07 www kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014 
Oct 28 01:38:07 www kernel: current->tss.cr3 = 3bf0d000, %cr3 = 3bf0d000 
Oct 28 01:38:07 www kernel: *pde = 00000000 

I also have been running top with 1 second intervals and everything looks
fine when the lockup occurs... (IE no heavy swapping, or loads off the
chart)

Also, the other strange thing is that if I reload the machine multiple
times, the memory usage will change even when the machine comes up
identical each time.  There are two apache processes (see below) that are
basically the only things running on the machine.  Sometimes I will load
up the machine and it will say around 500 megs used, and sometimes it will
jump right to 800-900 megs used.  Also the memory buffers will sometimes
be around 100 megs and sometimes 300-400 megs.  The load on the server is
basically the same at these times and I have even run heavy load testing
(wrote a program to hammer the machine for a few mins and max out the
processes) with no real difference.

The other oddness is the memory does not seem to free.  In the most recent
loading, memory usage was the following:

             total       used       free     shared    buffers     cached
Mem:        971872     947944      23928     233900     361108     495764
-/+ buffers/cache:      91072     880800
Swap:       136544        764     135780

Then I killed the two apache processes and the memory usage stayed
basically the same.  I even checked top and ps, with no other programs
hogging memory.  I can't seem to get the memory to "clear".

I have tried re-seating all hardware, upgrading the kernel (I upgraded
originally from an older kernel), upgrading apache to the latest (the one
I am using now), etc.

In my testing and calculations, the memory should be large enough for
these apache processes.  I have also looked into "ipcs" and it shows I
have around 170K used in shared memory, but FREE states I have 250k plus
in shared memory.

Any help would be appreciated.  Again, thanks for reading my rambling
post.  I have included some more details below, if you need any more
information please let me know.

-John


Here are the system stats:
-------------------------------------------------------------------
Linux Kernel 2.2.15 #2 SMP
Dual Processor Pentium 3, 700 mhz, 256k cache
1 Gig of memory
Mylex Raid
Linux Kernel max processes per user upped to 512 from 256
(this was an attempt to resolve the problem, system crashing before this
was done as well)

The main processes that are running are:

Apache 1.3.14 running with max processes of 450, mostly serving tiny
static graphics (< 1k each) - standard apache, this is the one that gets
around 500,000 hits a day

Apache 1.3.14 running mod-perl 1.18, max processes around 50
(I am aware that mod-perl can "bloat" processes and overwhelm machine, but
I have ruled this out... this apache process is very lowly hit, only gets
like 10,000 hits a day)

There are some various perl 5.004_03 scripts running on cron-jobs to parse
log files, etc.


Machine Details
-------------------------------------------------------
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.607927
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips	: 1399.19

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.607927
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips	: 1402.47

             total       used       free     shared    buffers     cached
Mem:        971872     947944      23928     233900     361108     495764
-/+ buffers/cache:      91072     880800
Swap:       136544        764     135780

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
