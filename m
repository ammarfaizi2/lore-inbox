Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSDMTVB>; Sat, 13 Apr 2002 15:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293596AbSDMTVA>; Sat, 13 Apr 2002 15:21:00 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:4736 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S293510AbSDMTU7>;
	Sat, 13 Apr 2002 15:20:59 -0400
Date: Sat, 13 Apr 2002 12:21:05 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.16] Clock locking bugs?
Message-ID: <20020413192105.GA853@netnation.com>
In-Reply-To: <20020114180215.GA20200@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm...Just had this happen on my dual celeron desktop, exactly the same
problem.  Kernel 2.5.7.  Everything I typed in an rxvt was one character
lagged. :)

Simon-

On Mon, Jan 14, 2002 at 10:02:15AM -0800, Simon Kirby wrote:

> Just had a server's clock stop at 9:02:30am.  Very interesting
> results:
> 
> [sroot@pro:/]# cat /proc/interrupts
>            CPU0       CPU1       
>   0:  172839353  172896882    IO-APIC-edge  timer
>   1:        578        522    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   4:      22002      21840    IO-APIC-edge  serial
>  10:  581309135  580556518   IO-APIC-level  eth0
>  12:   63077142   63023533   IO-APIC-level  aic7xxx
> NMI:          0          0 
> LOC:  345979794  345980089 
> ERR:          0
> MIS:          0
> 
> ...
> 
> [sroot@pro:/]# cat /proc/interrupts
>            CPU0       CPU1       
>   0:  172839353  172896882    IO-APIC-edge  timer
>   1:        578        522    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   4:      22002      21840    IO-APIC-edge  serial
>  10:  581309219  580556518   IO-APIC-level  eth0
>  12:   63077142   63023533   IO-APIC-level  aic7xxx
> NMI:          0          0 
> LOC:  345979883  345980178 
> ERR:          0
> MIS:          0
> 
> Alan says this is due to locking problems with the timer I/O code. 
> 
> On the console were a lot of "set_rtc_mmss: can't update from 79 to 32"
> type messages that have always happened on SMP kernels with ntpd.
> 
> Has anybody created any patches for this?
> 
> Simon-
> 
> [  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
> [       sim@stormix.com       ][       sim@netnation.com        ]
> [ Opinions expressed are not necessarily those of my employers. ]
