Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315820AbSEJHDw>; Fri, 10 May 2002 03:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315821AbSEJHDv>; Fri, 10 May 2002 03:03:51 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:22995 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315820AbSEJHDu>;
	Fri, 10 May 2002 03:03:50 -0400
Date: Fri, 10 May 2002 16:58:36 +1000
From: Anton Blanchard <anton@samba.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Robert Love <rml@tech9.net>, tchiwam <tchiwam@ees2.oulu.fi>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
        Gerrit Huizenga <gh@us.ibm.com>, Clifford White <ctwhite@us.ibm.com>,
        oliendm@us.ibm.com
Subject: Re: x86 question: Can a process have > 3GB memory?
Message-ID: <20020510065836.GD17965@krispykreme>
In-Reply-To: <1020980411.880.93.camel@summit> <200205092356.g49NuTS70861@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Huh? Unless you mean ppc64, ppc is worse.
> On a Mac, you get 2 GB of virtual memory per
> process. You get up to 512 MB of physical memory
> without highmem support, or usually 4 GB with
> highmem support. 

This is fixed in recent kernels, you can specify it with a CONFIG
option:

# uname -a
Linux 2.4.19-pre5 #185 Fri Apr 5 14:36:40 EST 2002 ppc

# cat /proc/self/maps  
0fea5000-0ffbb000 r-xp 00000000 03:0c 163581     /lib/libc-2.2.5.so
0ffbb000-0ffc5000 ---p 00116000 03:0c 163581     /lib/libc-2.2.5.so
0ffc5000-0ffeb000 rw-p 00110000 03:0c 163581     /lib/libc-2.2.5.so
0ffeb000-0fff0000 rw-p 00000000 00:00 0
10000000-10003000 r-xp 00000000 03:0c 1554092    /bin/cat
10012000-10013000 rw-p 00002000 03:0c 1554092    /bin/cat
10013000-10015000 rwxp 00000000 00:00 0
48000000-48014000 r-xp 00000000 03:0c 163537     /lib/ld-2.2.5.so
48014000-48015000 rw-p 00000000 00:00 0
48023000-48027000 rw-p 00013000 03:0c 163537     /lib/ld-2.2.5.so
bfffe000-c0000000 rwxp fffff000 00:00 0

Of course on ppc64 kernels you have a full 4GB of userspace since
the kernel sits at the top of the 64bit address space.

> As with x86, the latest chips
> offer a 36-bit (64 GB) physical address space.

Paulus also has a hack that allows up to 15G of memory on POWER3 class
machines although that isnt currently in the ppc32 tree.

> That's not all! Linus recently singled out the PowerPC
> MMU for a nice long abusive rant. :-) You get hashed
> page tables. You get this:
> 
> As with x86, segment registers map a 32-bit virtual
> address space onto a larger one. The top 4 bits of
> a 32-bit virtual address are used to select a segment,
> and the segment provides 24 more address bits to
> give you a 52-bit virtual address. Eeeew.

This is all very well and good, put my ppc64 machine still outperforms
anything out there on the kernel compile benchmark :)

Anton
