Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292489AbSBPTDK>; Sat, 16 Feb 2002 14:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292491AbSBPTDB>; Sat, 16 Feb 2002 14:03:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:17908 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S292489AbSBPTCs>; Sat, 16 Feb 2002 14:02:48 -0500
Message-ID: <3C6EACBD.A380D235@mvista.com>
Date: Sat, 16 Feb 2002 11:02:21 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tyson D Sawyer <tyson@rwii.com>, linux-kernel@vger.kernel.org,
        "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Missed jiffies
In-Reply-To: <E16c7yN-0006a2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > My system looses about 8 seconds every 20 minutes.  This is reported
> > by ntp and verified by comparing 'date' to 'hwclock --show' and a wall
> > clock.
> >
> > My system is a x86 Dell laptop with HZ=1024.
> >
> > I am quite certain that the issue is the System Management Interrupt
> > (SMI).
> 
> Possibly and if it is you can't really do much about it.
> 
> > I don't know that there is a solution for all systems, however, at
> > least on pentium systems it seems possible to use the TSC to catch
> 
> Most vendor systems don't have SMI problems that bad, you can normally hit
> the 100Hz or 1Khz tick quite reliably.
> 
> > tsc_remainder += last_tsc_low-tsc_low;
> 
> The tsc is not a constant on some laptops, and may not be present, or not
> be reliable.
> 
> > What strategies might be employed to prevent degraded system
> > performance since this code is in a criticle path?
> 
> Adding a time slew is a well understood problem - the NTP code and papers
> cover some very efficient implementation techniques. If you can work out
> the drift then drifting back is extremely efficient and the kernel already
> implements the needed PLL.
> 
> > Have I competely missed something, the kernel already takes care of
> > this and I have the problem all wrong?
> 
> You have it pretty much right. We have several time sources on a PC -
> the rtc (variable rate, not always present), the cmos clock (low res and
> on many modern machines horribly inaccurate due to the use of low grade
> components), the acpi timers (on newer machines only, high resolution
> constant rate, unknown accuracy).

I rather thought that since it runs at exactly 3 times the PIC clock
rate that it used the same "rock".  Andrew, any thoughts here?
> 
> ACPI may help here but lots of vendors implement their ACPI subsystem using
> I/O cycles to jump into SMM mode so its game over again.
> 
> > This problem also comes up with IDE access with dma off and I've
> > seen reports of it when using frame buffers.
> 
> The frame buffer one is fixed for newer kernels. The IDE one is a physical
> constraint on some older IDE controllers. See man hdparm.
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
