Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSJQA2v>; Wed, 16 Oct 2002 20:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbSJQA2v>; Wed, 16 Oct 2002 20:28:51 -0400
Received: from mail.cs.nmsu.edu ([128.123.64.3]:22005 "EHLO mail")
	by vger.kernel.org with ESMTP id <S261595AbSJQA2s>;
	Wed, 16 Oct 2002 20:28:48 -0400
Subject: Re: Kernel reports 4 CPUS instead of 2...
From: Mark Chernault <marchern@cs.nmsu.edu>
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: root@chaos.analogic.com, Mark Cuss <mcuss@cdlsystems.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3DADF488.1080204@jpl.nasa.gov>
References: <Pine.LNX.3.95.1021016133227.139A-100000@chaos.analogic.com> 
	<3DADF488.1080204@jpl.nasa.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Oct 2002 18:34:54 -0600
Message-Id: <1034814895.31448.24.camel@kali.cs.nmsu.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 17:21, Bryan Whitehead wrote:
> My /proc/cpuinfo says I have ht CPU's... but i only see 2 CPU's... (Yet 
> I have 2 1.7Ghz XEONs in the box so shouldn't I see 4?)
> 
> It's a Dell Precisions 530 workstation.
> 
> Does intel have ht CPU's that are messed up? and I'm one of the "lucky 
> ones". ?

Intel lists the Xeon with a 256KB cache as a workstation processor, and
indicate that it doesn't do hyperthreading.  They indicate that you need
to buy the higher end Xeons to use hyperthreading.  I don't know if this
is similar to AMD and the Athlon XP, Athlon MP; or, they really don't do
hyperthreading.

If someone knows how to get hyperthreading working on Xeons with a 256KB
cache I'd love to know.  We have a cluster of these running on
SuperMicro P4DC6's that I'd like to try hyperthreading on.  The
motherboards don't have a bios setting for hyperthreading
though.          

http://www.intel.com/design/Xeon/prodbref/

> 
> Building a kernel myself did not help... Any idea's?
> 
> [driver@mulan ~]$ cat /proc/cpuinfo
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 15
> model		: 1
> model name	: Intel(R) Xeon(TM) CPU 1.70GHz
> stepping	: 2
> cpu MHz		: 1694.863
> cache size	: 256 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 2
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips	: 3381.65
> 
> processor	: 1
> vendor_id	: GenuineIntel
> cpu family	: 15
> model		: 1
> model name	: Intel(R) Xeon(TM) CPU 1.70GHz
> stepping	: 2
> cpu MHz		: 1694.863
> cache size	: 256 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 2
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips	: 3381.65
> 
> 
> Richard B. Johnson wrote:
> > On Wed, 16 Oct 2002, Mark Cuss wrote:
> > 
> > 
> >>Hello all
> >>
> >>I'm working with a new Dell Poweredge 4600 Server with Dual CPUs.  However,
> >>Linux reports that it sees 4 CPUs...  I have opened the thing to see if Dell
> >>gave me 2 extras for free, but no luck:  Attached is /proc/cpuinfo.
> >>
> >>I've tried the RedHat 8.0 stock kernel, as well as a freshly compiled 2.4.19
> >>but both exhibit the same behavior.
> >>
> >>The specifics on the machine:
> >>
> >>Dual Xeon 2.2 GHz CPUs (512 k L2 cache)
> >>2 Gigs DDR RAM
> >>The chipset is a ServerWorks CMIC-HE (see attached lspci for complete
> >>listing).
> >>
> >>Has anyone else seen this behavior?  The only other SMP machine I have is an
> >>older Dell server with Dual 1 GHz coppermines, and it reports 2 CPUs...
> >>
> >>Any information or advice is greatly appreciated...
> >>
> >>Thanks in Advance,
> >>
> >>Mark
> >>
> > 
> > 
> > This has become a FAQ. The processors are capable of so-called
> > "hyperthreading". They have two execution units, therefore seem
> > like two CPUs.
> > 
> > This is the correct behavior. If you don't like this, you can
> > swap motherboards with me ;) Otherwise, grin and bear it!
> > 
> > 
> > Cheers,
> > Dick Johnson
> > Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> > The US military has given us many words, FUBAR, SNAFU, now ENRON.
> > Yes, top management were graduates of West Point and Annapolis.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -- 
> Bryan Whitehead
> SysAdmin - JPL - Interferometry Systems and Technology
> Phone: 818 354 2903
> driver@jpl.nasa.gov
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Mark Chernault <marchern@cs.nmsu.edu>
Technical Assistant, COG, CS Dept., NMSU

