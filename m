Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSEGHNb>; Tue, 7 May 2002 03:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSEGHNa>; Tue, 7 May 2002 03:13:30 -0400
Received: from adsl-63-200-86-10.dsl.scrm01.pacbell.net ([63.200.86.10]:58826
	"EHLO frx774.dhs.org") by vger.kernel.org with ESMTP
	id <S315374AbSEGHN3>; Tue, 7 May 2002 03:13:29 -0400
From: Jesse Wyant <jrwyant@frx774.dhs.org>
Message-Id: <200205070712.g477CSt00441@frx774.dhs.org>
Subject: Re: P4 Xeon summary inquiry
To: jamagallon@able.es (J.A. Magallon)
Date: Tue, 7 May 2002 00:12:28 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org (Lista Linux-Kernel)
In-Reply-To: <20020506232721.GC3019@werewolf.able.es> from "J.A. Magallon" at May 07, 2002 01:27:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just put together a SuperMicro P4DCE+ (Intel i860/ICH2/CS4299 AC'97 codec
[use the OSS i810_audio or ALSA's intel_8x0 or whatever it is]) with 1GB of
Samsung RDRAM and two 2.0GHz Xeon (Prestonias.)  Currently 2.4.19-pre7 with
Ingo's interrupt patch, and timer balancing patch.  Running on ext3, using
RedHat 7.2.

I also tried the acpismp=force option to get into hyperthreading
(successfully--it appears as though I have 4 CPUs), and the overall system
seems just as fast as with the HT disabled.  Qualitatively: kernel compile
with HT disabled, using 

    'make -j2 bzImage; make -j2 modules; make modules_install; sync'

results in compile times around 3 minutes 45 seconds or so.  With HT enabled,
and using -j4 instead of -j2, my compile time comes down to around 2:57 or
so--a significant improvement.

However, 'dnetc's throughput in RC5 keys/s is much lower with HT enabled: 
it runs 4 clients, and each client chugs through about 720kKeys/s.  
With HT disabled, the two dnetc clients run through 2.8MKeys/s each.  (So
it's around half as fast with HT enabled!)  When I'm finished downloading
RedHat 7.3, I'll reboot into Hyperthreading-enabled mode, and run 
'dnetc --benchmark' to confirm this.

Haven't had a chance to benchmark more than that yet.  But no gross issues
when running with HT enabled.  (Tribes2, Q3A and RTCW feel equally fast 
between the two configurations.)

-jesse


> I am trying to make a dual P4-Xeon box (P4DCE, Intel 869) work optimally.
> After some search in list archives, I have found this points:
> 
> - You need ACPI, and boot with acpismp=force, to have hyperthreading
>   (see 4 cpus)
> - To balance interrupts, a patch from Ingo is needed
> - To balance timers, one other patch was needed, but this in included
>   in 2.4.19-pre8 (do not know since which pre is there)
> 
> I tried to boot with acpismp=force, but then performance was dog slow,
> I could count lines scrolling on a rxvt.
> I checked mtrr and look like working. Box has 1Gb of ram, so kernel
> is using CONFIG_HIGHMEM4G=y.
> Kernel is the standard highmem Mandrake kernel in 8.2
> (2.4.18-6mdkenterprise) that is mainly a plain 2.4.18 with some
> .19-pre1 fixes.
> 
> Any correction ? Any known problem in 2.4.18 about this issue that
> has bee corrected in pres for 19 ?
> 
> Any idea about the performance loss ?
> 
