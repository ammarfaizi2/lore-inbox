Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265601AbTF2Hbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 03:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbTF2Hbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 03:31:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:54034 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S265601AbTF2Hba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 03:31:30 -0400
Date: Sun, 29 Jun 2003 09:45:42 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Edward Tandi <ed@efix.biz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre2 and AthlonMP?
Message-ID: <20030629074542.GA207@pcw.home.local>
References: <1056833424.30265.39.camel@wires.home.biz> <1056837060.6778.2.camel@dhcp22.swansea.linux.org.uk> <1056840603.30264.45.camel@wires.home.biz> <1056842271.6753.19.camel@dhcp22.swansea.linux.org.uk> <1056845040.2315.27.camel@wires.home.biz> <1056848334.2332.6.camel@wires.home.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056848334.2332.6.camel@wires.home.biz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

I too got rather strange results with ASUS boards :

- on the first one (first rev A7M266D, without on-board USB),
  I stuck 2 Athlon-XP 1800 (yes, I risked XPs because it's only
  a dev machine and at that time, XPs were less than half the
  price of MPs). They were seen as XPs by the BIOS (rev 1004)
  and by Linux. I had a few problems with APIC at that time
  and Alan suggested me to try a more recent BIOS, which I did.
  Now, with rev 1007, the BIOS tells me I have two AthlonMP,
  which are both MP capable. Linux now sees a model name changed
  to AthlonMP :

  willy@pcw:willy$ cat /proc/cpuinfo
  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 6
  model name      : AMD Athlon(TM) MP 1800+
  stepping        : 2
  cpu MHz         : 1546.160
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
  bogomips        : 3039.23

  processor       : 1
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 6
  model name      : AMD Athlon(TM) MP 1800+
  stepping        : 2
  cpu MHz         : 1546.160
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
  bogomips        : 3088.38

==> the BIOS seems to change this itself at boot time. Now I
    have absolutely no way to tell if I really have MPs or XPs,
    except opening the box and removing the HS/Fan, or downgrading
    the BIOS ! My mistake is not to have checked if
    family/model/stepping were the same before the BIOS upgrade,
    but honnestly I didn't expect the BIOS to affect the way the
    processor reports itself to the cpuid instruction ! But x86info
    also tells me I have MPs, and I think I would have noticed it
    if it had already been the case before...


  willy@pcw:willy$ x86info
  x86info v1.11.  Dave Jones 2001, 2002
  Feedback to <davej@suse.de>.

  Found 2 CPUs
  CPU #1
  Family: 6 Model: 6 Stepping: 2
  CPU Model : Athlon MP (palomino)
  Processor name string: AMD Athlon(TM) MP 1800+

  PowerNOW! Technology information
  Available features:
        Temperature sensing diode present.


- the second board, a new generation ASUS A7M266D (with working
  on-board USB) :
  I bought this card to use at work as a heavy computation/compilation
  server. This time I didn't want to play with stability, so I bought
  two real AthlonMP 2200 sold in an AMD box labeled AthlonMP, etc...
  I believe the BIOS is rev 1007 too. And guess what ? at boot, the bios
  stops and tells me that CPU1 is NOT MP capable !!! It doesn't come from
  the CPU since I swapped them and only CPU1 is reported not to be MP
  capable ! Which means that, according to that crappy BIOS, my XPs are
  more MP capable than true MPs ! And the must :

  root@aluminium:root# cat /proc/cpuinfo
  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 8
  model name      : AMD Duron(TM) MP Processor
  stepping        : 0
  cpu MHz         : 1800.040
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
  bogomips        : 3547.13

  processor       : 1
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 8
  model name      : AMD Duron(TM) MP Processor
  stepping        : 0
  cpu MHz         : 1800.040
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
  bogomips        : 3596.28


Notice how they now are named "Duron MP" !
Fortunately, x86info is not fooled by this stupid BIOS :

  x86info v1.11.  Dave Jones 2001, 2002
  Feedback to <davej@suse.de>.
  
  Found 2 CPUs
  CPU #1
  Family: 6 Model: 8 Stepping: 0
  CPU Model : Athlon MP (Thoroughbred)[A0]
  Processor name string: AMD Duron(TM) MP Processor


===> To conclude, I would say don't worry about the model name, since
     the BIOS seems to have the ability to change it to whatever it thinks
     is appropriate (I would laugh to see a 'GenuineIntel' here :-)). But
     your different steppings are more worrying. You may want to swap the
     two CPUs to see if the steppings follow the CPU or the socket, but you
     need some thermal grease if you dismount the heatsink/fan.

BTW, concerning stability, the two machines (XP and MP) have been rock solid,
sometimes spending a full day compiling kernels in parallel. I even made my
XPs more silent by slowing down the fans, and they can go as high as 92 degrees
after a few hours of intensive compilation, but I never have a stability problem
with them. OTOH, a collegue of mine bought two MP2000 which crashed in more than
one hour of intensive computation, and once the reseller finally replaced the
CPUs which were already AMD box, recommended fan..., the problems were gone !
So I begin to wonder if XPs would not be more reliable than MPs since they are
sold far more often...

Cheers,
Willy

[I leave your mail here for reference]

On Sun, Jun 29, 2003 at 01:58:54AM +0100, Edward Tandi wrote:
> The what processor thread...
> 
> On Sun, 2003-06-29 at 01:04, Edward Tandi wrote:
> > On Sun, 2003-06-29 at 00:17, Alan Cox wrote:
> > > On Sad, 2003-06-28 at 23:50, Edward Tandi wrote:
> > > > > > using option 'pci=noacpi' or even 'acpi=off'
> > > > > > Jun 28 18:27:46 machine kernel: BIOS failed to enable PCI standards
> > > > > > compliance, fixing this error.
> > > > > 
> > > > > Start by upgrading to their current BIOS
> > > > 
> > > > Believe or not, it _is_ the latest bios for that board
> > > > (Tyan S2460 BIOS v1.05, 2nd Jan 2003).
> > > 
> > > Then I guess you have a problem. We try and fix up BIOS problems but there
> > > is a limit to what we can do, and if it has problems like the one that is
> > > logged I'd be worried what else it might do - eg I suspect Nvidia 4x AGP cards
> > > aren't too solid on it.
> > > 
> > > The APIC errors also suggest something isn't happy at all at the hardware
> > > layer. Are you using MP processors ?
> > 
> > I have to admit, I have noticed something a little odd coming out of
> > /proc/cpuinfo:
> > 
> > processor       : 0
> > vendor_id       : AuthenticAMD
> > cpu family      : 6
> > model           : 6
> > model name      : AMD Athlon(tm) MP
> > stepping        : 1
> > cpu MHz         : 1194.690
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat
> > pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> > bogomips        : 2385.51
> >                                                                                 
> > processor       : 1
> > vendor_id       : AuthenticAMD
> > cpu family      : 6
> > model           : 6
> > model name      : AMD Athlon(tm) Processor
> > stepping        : 2
> > cpu MHz         : 1194.690
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat
> > pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> > bogomips        : 2385.51
> > 
> > What confuses me here is how on earth the second processor reports
> > itself without the "MP" bit and with a stepping of 2. They were
> > identical processors when I put them in and I haven't touched them
> > since. Is there any way this could be reported wrongly?
> 
> Further info on this, x86info gives the following results:
> 
> x86info v1.7.  Dave Jones 2001
> Feedback to <davej@suse.de>.
>  
> Found 2 CPUs
> CPU #1
> Family: 6 Model: 6 Stepping: 1 [Athlon 4 (Palomino core) Rev A2]
> Processor name string: AMD Athlon(tm) MP
>  
> PowerNOW! Technology information
> Available features:
>         Temperature sensing diode present.
>  
> CPU #2
> Family: 6 Model: 6 Stepping: 2 [Athlon MP]
> Processor name string: AMD Athlon(tm) Processor
>  
> PowerNOW! Technology information
> Available features:
>         Temperature sensing diode present.
>  
> 
> It looks like the processors may have been from two different batches!
> How bizarre. Should this make any difference?
> 
> Ed-T.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
