Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268018AbTBMK6T>; Thu, 13 Feb 2003 05:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268019AbTBMK6T>; Thu, 13 Feb 2003 05:58:19 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:24812 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268018AbTBMK6S>;
	Thu, 13 Feb 2003 05:58:18 -0500
Date: Thu, 13 Feb 2003 16:43:27 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030213164327.A14429@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com> <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com> <20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org> <3E4A70EA.4020504@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E4A70EA.4020504@mvista.com>; from cminyard@mvista.com on Wed, Feb 12, 2003 at 10:06:02AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 10:06:02AM -0600, Corey Minyard wrote:
> |
> |It is trivial if you don't let alloc_pages give the memory to anyone for
> |any purpose.
> 
> Ok, agreed, if you reserve a section of physical memory just for kexec 
> to copy it's kernel into, it will
> prevent DMA from clobbering something from the time kexec copies the 
> kernel there to the time
> decompressing starts.
> 
> Another thought.  If you add a delay with all other processors and 
> interrupts off, the disk devices
> will run out of things to do.
> 
> Once you add all the necessary quiesce functions, these can go away.
> 
> I do doubt these will make a big difference, though.  The problem we 
> were seeing was with the
> shared control structures in memory.  The new kernel laid memory out a 
> little differently and
> things like buffer pointers were overwritten with new data.  This, in 
> turn, cause the device to
> do random things.  I would guess this is the most likely scenario, since 

The trick is that the new kernel's allocations are also from the
reserved area. (Using the same technique that MCL relies on to
avoid allocating from and stomping over the pages containing 
crash dump).

So the memory used by the old and new kernel are mutually 
exclusive.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

