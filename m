Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSIQXd6>; Tue, 17 Sep 2002 19:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSIQXd6>; Tue, 17 Sep 2002 19:33:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3001 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264677AbSIQXd5>;
	Tue, 17 Sep 2002 19:33:57 -0400
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: john stultz <johnstul@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: James <jamesclv@us.ibm.com>, ak@suse.de,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, anton.wilson@camotion.com
In-Reply-To: <20020917.161215.03597459.davem@redhat.com>
References: <20020918004442.A32234@wotan.suse.de>
	<20020917.153828.24171342.davem@redhat.com>
	<200209171555.52872.jamesclv@us.ibm.com> 
	<20020917.161215.03597459.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 16:32:15 -0700
Message-Id: <1032305535.7481.204.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 16:12, David S. Miller wrote:
>    From: James Cleverdon <jamesclv@us.ibm.com>
>    Date: Tue, 17 Sep 2002 15:55:52 -0700
>    
>    The initial sync was easy, even with variable latencies on cache lines.  A 
>    much simplified NTP-ish algorithm works fine.  The painful thing was bus 
>    clock drift and programs that foolishly relied on the TSC being the same 
>    between CPUs and between nodes.
> 
> This is why the gettimeofday implementation should use the system tick
> thing and also any profiling support in the C library should avoid
> TSC as well.

I think the point James is making is that on very large systems, you
will get system tick skew as well. On one system I know of, the bus
frequency is intensionally skewed slightly between nodes. This is what
causes the TSCs to skew, and I believe would also cause this "system
tick" to skew as well.

Additionally, where is this system tick thing? You make it sound like
its a register in the cpu, and while the Ultra-III may have one, I'm
unaware of a system/bus tick register on intel chips. Is it in some
semi-documented MSR?

I apologize for being confused, I'm just not sure if your criticizing
the code or the hardware. 

thanks
-john 

