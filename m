Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274533AbRJEXZQ>; Fri, 5 Oct 2001 19:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274544AbRJEXZH>; Fri, 5 Oct 2001 19:25:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:716 "EHLO e32.bld.us.ibm.com")
	by vger.kernel.org with ESMTP id <S274533AbRJEXZC>;
	Fri, 5 Oct 2001 19:25:02 -0400
Date: Fri, 05 Oct 2001 16:20:56 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andreas Dilger <adilger@turbolabs.com>,
        Alessandro Suardi <alessandro.suardi@oracle.com>
cc: Dan Merillat <harik@chaos.ao.net>, linux-kernel@vger.kernel.org
Subject: Re: Wierd /proc/cpuinfo with 2.4.11-pre4
Message-ID: <1571476398.1002298856@mbligh.des.sequent.com>
In-Reply-To: <20011005171815.O315@turbolinux.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This will also fail if, for some reason "clustered_apic_mode" is set and
> you have less than 8 CPUs.  What you really want is to have "max(8:NR_CPUS)"
> in the loop (or make the loop actually work with > 8 CPUs, which is probably
> the correct solution in the long run).

Nope, the cpu_online map should catch this. NR_CPUS is always 32
in SMP mode.

in get_cpuinfo ....

                if (!(cpu_online_map & (1<<n)))
                        continue;

I didn't notice that this would only work in SMP mode. 

It's a horrible hack, but it's less horrible than corrupting memory randomly ;-)

M.

