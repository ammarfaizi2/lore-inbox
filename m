Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265586AbSJXSUh>; Thu, 24 Oct 2002 14:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbSJXSUg>; Thu, 24 Oct 2002 14:20:36 -0400
Received: from [208.48.139.185] ([208.48.139.185]:54476 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S265586AbSJXSUf>; Thu, 24 Oct 2002 14:20:35 -0400
Date: Thu, 24 Oct 2002 11:26:42 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024112642.A27303@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>; from manfred@colorfullife.com on Thu, Oct 24, 2002 at 07:15:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 07:15:43PM +0200, Manfred Spraul wrote:
> AMD recommends to perform memory copies with backward read operations 
> instead of prefetch.
> 
> http://208.15.46.63/events/gdc2002.htm
> 
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?
> 
> Please run 2 or 3 times.

Ran on two machines.  Ran 10 times each, removed high and low, averaged the
rest.

Machine 1, Duron 600, KT133 chipset, 512MB PC100 memory

'warm up run'      11494.25
'2.4 non MMX'      16536.625
'2.4 MMX fallback' 16559.375
'2.4 MMX version'  11463.75
'faster_copy'      6757
'even_faster'      6620.375
'no_prefetch'      5996.5

> cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 0
cpu MHz         : 605.410
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1205.86
> cat /proc/pci 
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).


Machine 2, Original Athlon 700, Via Apollo Pro133 chipset, 512MB PC100 memory
(note: this machine wasn't totally idle during testing)

'warm up run'      15621.875
'2.4 non MMX'      22805
'2.4 MMX fallback' 19881.75
'2.4 MMX version'  15237.5
'faster_copy'      8985.5
'even_faster'      9134.25
'no_prefetch'      7960.5

> cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 700.057
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.91
 cat /proc/pci 
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 2).
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
