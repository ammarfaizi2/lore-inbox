Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbTAUHHW>; Tue, 21 Jan 2003 02:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTAUHHW>; Tue, 21 Jan 2003 02:07:22 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:64655
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266295AbTAUHHU>; Tue, 21 Jan 2003 02:07:20 -0500
Date: Tue, 21 Jan 2003 02:16:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][2.5] smp_call_function_mask
In-Reply-To: <1043104744.12609.2.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301210215550.2653-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jan 2003, Alan wrote:

> On Fri, 2003-01-17 at 05:18, Zwane Mwaikambo wrote:
> > +	/* Wait for response */
> > +	while (atomic_read(&data.started) != num_cpus)
> > +		barrier();
> 
> Only old old intel x86 that does -bad- things as it
> generates a lot of bus locked cycles. Better to do
> 
> 	while(atomic_read(&data.started) != num_cpus)
> 		while(data.started.value != num_cpus)
> 		{
> 			barrier();
> 			cpu_relax();
> 		}
> 
> I would think ?

Cool, would a cpu_relax only be sufficient since that also has the memory 
barrier?

	Zwane
-- 
function.linuxpower.ca

