Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315851AbSEGPAi>; Tue, 7 May 2002 11:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315852AbSEGPAc>; Tue, 7 May 2002 11:00:32 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:9113 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S315851AbSEGPAa>; Tue, 7 May 2002 11:00:30 -0400
Date: Tue, 7 May 2002 09:00:19 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Jesse Wyant <jrwyant@frx774.dhs.org>
cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: P4 Xeon summary inquiry
In-Reply-To: <200205070712.g477CSt00441@frx774.dhs.org>
Message-ID: <Pine.LNX.4.44.0205070851250.12653-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Jesse Wyant wrote:

[...]
>     'make -j2 bzImage; make -j2 modules; make modules_install; sync'
> 
> results in compile times around 3 minutes 45 seconds or so.  With HT enabled,
> and using -j4 instead of -j2, my compile time comes down to around 2:57 or
> so--a significant improvement.
> 
> However, 'dnetc's throughput in RC5 keys/s is much lower with HT enabled: 
> it runs 4 clients, and each client chugs through about 720kKeys/s.  
> With HT disabled, the two dnetc clients run through 2.8MKeys/s each.  (So
> it's around half as fast with HT enabled!)  When I'm finished downloading
> RedHat 7.3, I'll reboot into Hyperthreading-enabled mode, and run 
> 'dnetc --benchmark' to confirm this.

We have found the same thing.  If you are running single threaded, 2 or
less consecutive on a 2-proc system it's better to disable HT, however,
on a system which will have multiple runable processes looking for CPU
time concurrently, then using HT is a benefit.

We noticed ~2%-5% drop in single process performance with HT
enabled, but >20% with multiple processes with HT enabled.

Thing is, with 2 1.8 GHz CPUs, a 2% drop may be appreciable, but not
generally noticable overall.

The tests were done with a Dell PE4600 (2x1.8GHz, 2GB RAM), 2.4.18, with
Ingos' irqbalance-2.4.17-B1.patch and timer-irq-balance-2.4.18.patch.

The system is now in production with these patches and kernel, and has
been very stable (of course now it *will* crash).

Regards
James Bourne

> 
> Haven't had a chance to benchmark more than that yet.  But no gross issues
> when running with HT enabled.  (Tribes2, Q3A and RTCW feel equally fast 
> between the two configurations.)
> 
> -jesse
> 
> 
> > I am trying to make a dual P4-Xeon box (P4DCE, Intel 869) work optimally.
> > After some search in list archives, I have found this points:
> > 
> > - You need ACPI, and boot with acpismp=force, to have hyperthreading
> >   (see 4 cpus)
> > - To balance interrupts, a patch from Ingo is needed
> > - To balance timers, one other patch was needed, but this in included
> >   in 2.4.19-pre8 (do not know since which pre is there)
> > 
> > I tried to boot with acpismp=force, but then performance was dog slow,
> > I could count lines scrolling on a rxvt.
> > I checked mtrr and look like working. Box has 1Gb of ram, so kernel
> > is using CONFIG_HIGHMEM4G=y.
> > Kernel is the standard highmem Mandrake kernel in 8.2
> > (2.4.18-6mdkenterprise) that is mainly a plain 2.4.18 with some
> > .19-pre1 fixes.
> > 
> > Any correction ? Any known problem in 2.4.18 about this issue that
> > has bee corrected in pres for 19 ?
> > 
> > Any idea about the performance loss ?
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

