Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbSJZPlI>; Sat, 26 Oct 2002 11:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSJZPlI>; Sat, 26 Oct 2002 11:41:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21300 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261526AbSJZPlH>; Sat, 26 Oct 2002 11:41:07 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Robert Love <rml@tech9.net>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
References: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com>
	<1035584076.13032.96.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Oct 2002 09:45:18 -0600
In-Reply-To: <1035584076.13032.96.camel@irongate.swansea.linux.org.uk>
Message-ID: <m165vpkxv5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Fri, 2002-10-25 at 22:50, Nakajima, Jun wrote:
> > Sorry,
> > 
> > Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for example,
> > is already doing it:
> 
> Could do
> > 
> > +#ifdef CONFIG_SMP
> > +	if (cpu_has_ht) {
> > +		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
> > +		seq_printf(m, "threads\t\t: %d\n", smp_num_siblings);
> > +	}
> > +#endif
> 
> 
> Im just wondering what we would then use to describe a true multiple cpu
> on a die x86. Im curious what the powerpc people think since they have
> this kind of stuff - is there a generic terminology they prefer ?

How about using "SMT width" for the P4 case?
And if we needed to break it down per package for a Power4 and the
like we could talk about CMP something, or other.

Only SMT and CMP seem to be unambiguous prefixes.  Though for CMP
we probably do not need to do anything because it really is 2 cpus, and we
only need to worry about locatity in the cache hierarchy not the fact that
if we schedule a cpu intensive job on 1 ``cpu'' the others are useless.

Eric
