Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274653AbRJEX6c>; Fri, 5 Oct 2001 19:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274681AbRJEX6W>; Fri, 5 Oct 2001 19:58:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:9914 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274653AbRJEX6J>; Fri, 5 Oct 2001 19:58:09 -0400
Date: Fri, 05 Oct 2001 16:54:06 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: paulus@samba.org, Peter Rival <frival@zk3.dec.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        benh@kernel.crashing.org
Subject: Re: [PATCH] change name of rep_nop
Message-ID: <1573466920.1002300846@mbligh.des.sequent.com>
In-Reply-To: <15294.16913.2117.383987@cargo.ozlabs.ibm.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You also need to move the call to smp_boot_cpus() below the 
>> clear_bit(...) line in smp_init().  Without it, my Wildfire doesn't get 
> 
> No, that won't work for me, because cpu_online_map is set by
> smp_boot_cpus(), at least on PPC (in fact each CPU sets its bit in
> cpu_online_map as it spins up).
> 
> There shouldn't be a race on x86 at all, because the secondary
> processors don't call init_idle until after they see that the primary
> cpu has call smp_commence.  (There is currently a race on PPC since we
> call init_idle before waiting for smp_commence, but that would not be
> your problem.)

There *is* a race on x86 - the problem is that the primary cpu can 
get to reschedule_idle before the secondarys have done init_idle.
I'm not claiming the way I fixed it is beautiful, but the race definitely
exists (I hit it) and the patch makes the problem go away. 

Sounds like rep_nop was the wrong way to spin - aplogies.

Martin.

