Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264539AbSIQUzk>; Tue, 17 Sep 2002 16:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264543AbSIQUzk>; Tue, 17 Sep 2002 16:55:40 -0400
Received: from ns.suse.de ([213.95.15.193]:31506 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264539AbSIQUzi>;
	Tue, 17 Sep 2002 16:55:38 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
References: <200209172020.g8HKKPF13227@eng2.beaverton.ibm.com.suse.lists.linux.kernel> <1032294559.22815.180.camel@cog.suse.lists.linux.kernel> <20020917.133933.69057655.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Sep 2002 23:00:38 +0200
In-Reply-To: "David S. Miller"'s message of "17 Sep 2002 22:52:50 +0200"
Message-ID: <p73vg54tjpl.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: john stultz <johnstul@us.ibm.com>
>    Date: 17 Sep 2002 13:29:18 -0700
>    
>    Some NUMA boxes do not have synced TSC, so on those systems your
>    code won't work.
> 
> It would have been really nice if x86 had specified a "system tick"
> register that incremented based upon the system bus cycles and thus
> were immune the processor rates.

It has - the local APIC timer. It has a tick register too that you can
read. Unfortunately it's buggy/unreliable on many systems. Linux uses
it for task scheduling and the local timer interrupt when it works,
but it's not really good enough for gettimeofday.

Microsoft/Intel have specified the HPET timer as replacement, but 
it is still missing in many chipsets and buggy in others.

Also reading HPET is somewhat more costly than reading TSCs because it
goes to the southbridge, so there are cases where using TSC is
probably better (e.g. I think for networking packet time stamping the
TSC is just fine with all its limitations)

> I foresee lots of patches coming which basically are "how does this
> x86 system provide a stable synchronized tick source".

>From those who didn't implement HPET but some own spec like IBM.

-Andi
