Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319239AbSHUWwv>; Wed, 21 Aug 2002 18:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319240AbSHUWwu>; Wed, 21 Aug 2002 18:52:50 -0400
Received: from fmr05.intel.com ([134.134.136.6]:63184 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S319239AbSHUWwT>; Wed, 21 Aug 2002 18:52:19 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000BA1E06E@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Banai Zoltan <bazooka@emitel.hu>, Kelsey Hudson <khudson@compendium.us>
Cc: James Bourne <jbourne@mtroyal.ab.ca>, Hugh Dickins <hugh@veritas.com>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Hyperthreading
Date: Wed, 21 Aug 2002 15:56:12 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Pentium 4 and Xeon share the same core, you see the HT bit on Pentium
4 as well. The HT bit does not mean HT is enabled (you can enable/disable
usually by the BIOS setup), but the number of the threads (i.e. logical
CPUs) in a processor package must be 2 (via cpuid instruction) so that the
OS can be sure that HT is enabled (see setup.c). The HT bit is just useful
as a prerequisite for HT.

Thanks,
Jun
-----Original Message-----
From: Banai Zoltan [mailto:bazooka@emitel.hu]
Sent: Wednesday, August 21, 2002 2:55 PM
To: Kelsey Hudson
Cc: James Bourne; Hugh Dickins; Reed, Timothy A;
linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading


On Wed, Aug 21, 2002 at 02:16:11PM -0700, Kelsey Hudson wrote:
> On Wed, 21 Aug 2002, James Bourne wrote:
> 
> > On Wed, 21 Aug 2002, Hugh Dickins wrote:
> > 
> > > You do need CONFIG_SMP and a processor capable of HyperThreading,
> > > i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> > > just appropriate to that processor in other ways.
> > 
> > I was under the impression that the only CPU capable of hyperthreading
was
> > the P4 Xeon.  Is this not correct?  I don't know of any other CPUs that
> > have the ht feature.
> 
> This is currently correct, although I believe Intel has plans to release a

> Hyperthreading-capable version of its desktop P4. 

If this is correct, and there is not destop P4 capable of ht,
then what does mean the ht flag in cpuinfo?

$cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1694.907
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3381.65
                                                         ^^

> 
> > Also, looking at setup.c it's hard to determine if CONFIG_SMP is
> > actually required, but it doesn't look like it...
> 
> Of course it's required. How are you to take advantage of a "second CPU" 
> if your scheduler only works on a uniprocessor machine?
> 
> -- 
>  Kelsey Hudson                                       khudson@compendium.us
>  Software Engineer/UNIX Systems Administrator
>  Compendium Technologies, Inc                               (619) 725-0771
>
---------------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Banai Zoltan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
