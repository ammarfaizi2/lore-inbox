Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSJYX6r>; Fri, 25 Oct 2002 19:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261713AbSJYX6r>; Fri, 25 Oct 2002 19:58:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49169 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261703AbSJYX6q>;
	Fri, 25 Oct 2002 19:58:46 -0400
Message-ID: <3DB9DC1D.3000807@pobox.com>
Date: Fri, 25 Oct 2002 20:04:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Robert Love <rml@tech9.net>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
References: <F2DBA543B89AD51184B600508B68D4000EA1718C@fmsmsx103.fm.intel.com> <1035581420.734.3873.camel@phantasy> <20021026000137.GA19673@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Fri, Oct 25, 2002 at 05:30:19PM -0400, Robert Love wrote:
>
> > +#ifdef CONFIG_SMP
> > +	if (cpu_has_ht) {
> > +		seq_printf(m, "physical processor ID\t: %d\n", phys_proc_id[n]);
> > +		seq_printf(m, "number of siblings\t: %d\n", smp_num_siblings);
> > +	}
> > +#endif
>
>Something else looks suspect to me here.
>smp_num_siblings is going to say the same value on every CPU in the
>system. It's questionable whether we want to print it out n times.
>  
>


Not really... we print out other information that is duplicated N times, 
because it is the common case that N-way systems have matched processors 
with matched capabilities.  The above caught my eye as well, but the 
alternative is to subvert the standard /proc/cpuinfo format and print 
something out only once, that clearly applies to each processor.

    Jeff




