Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSH0Rex>; Tue, 27 Aug 2002 13:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSH0Rex>; Tue, 27 Aug 2002 13:34:53 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:13841 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S316586AbSH0Rex>; Tue, 27 Aug 2002 13:34:53 -0400
Message-ID: <3D6BB9E2.DE71FE2C@compro.net>
Date: Tue, 27 Aug 2002 13:41:54 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
References: <D3524C0FFDC6A54F9D7B6BBEECD341D5D56FDB@HBMNTX0.da.hbm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Wessler, Siegfried" wrote:
> 
> Hello,
> 
> I am running and will in near future kernel 2.4.18 on an embedded system.
> 
> I have to speed up interrupt latency and need to understand how in what
> timing tasklets are called and arbitraded.
> 
> I have to dig deep, but the kernel tree is quiet huge. As a non kernel
> programmer I ask you, if anyone could give me a hint, where to start reading
> from and which kernel source to pick first.
> 
> Any help highly appreaciated.
> (BTW: I will not bother you personaly with further questions unless you give
> permission.)
> 
> What's behind it: We patched NMI and do some stuff we have to do very
> regularly in there. After NMI we have to quiet fast start a kernel or even a
> user space function with low latency. Also I measured 8 milliseconds after a
> hardware interrupt before the corresponding interrupt function is called. At
> RTI time it is even longer (around 12 microseconds). Need to find a way to
> exactly understand why, and maybe speed up a bit.
> 
> Thank You.
> Siegfried.

I've found that with the combination of process affinity and irq affinity you
can get very good interrupt latency/determinism. We use a pci card that has
some external interrupts and some 250ns resolution timers and have found the
interrupt latency/determinism of the external interrupts to be more than 
exceptable as long as the process and irq of that pci card are forced
to one cpu and ALL other processes/irq's are forced to another cpu. Of coarse
you need an SMP box for best results. We found that with a UMP box you can
get the latency but there is no determinism to that latency.

Mark
