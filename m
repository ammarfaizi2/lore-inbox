Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRDFPXE>; Fri, 6 Apr 2001 11:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131724AbRDFPWy>; Fri, 6 Apr 2001 11:22:54 -0400
Received: from ns.suse.de ([213.95.15.193]:53008 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131730AbRDFPWn>;
	Fri, 6 Apr 2001 11:22:43 -0400
Date: Fri, 6 Apr 2001 17:21:55 +0200
From: Andi Kleen <ak@suse.de>
To: majer@endeca.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory allocation problems
Message-ID: <20010406172155.A17128@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0104061001280.9562-300000@caffeine.ops.endeca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104061001280.9562-300000@caffeine.ops.endeca.com>; from majer@endeca.com on Fri, Apr 06, 2001 at 10:06:47AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 10:06:47AM -0400, majer@endeca.com wrote:
>   Essentially, the problem can be summarized to be that on a machine
>   with ample ram (2G, 4G, etc), I am unable to malloc a gig if I ask 
>   for the memory in small ( <= 128k) chunks. I've enclosed some results 
>   and a little program which was put together to demonstrate the problems
>   we're having.  All of the failures seem to occur around 930MB.

It's bumping against some mapping (just do system("cat /proc/self/maps")
on allocation failure to see which). Usual suspects are shared libraries.
One possible solution is to upgrade to a newer glibc, the 2.2 glibc malloc 
should handle this case better.  
A way to get mappings like shared libraries out of the way is to 
increase the value of TASK_UNMAPPED_BASE in include/asm-i386/processor.h.
For that the kernel needs to be recompiled and it should be smaller
TASK_SIZE-enough space for your shared libraries. With that even the older
malloc will probably work.


-Andi
