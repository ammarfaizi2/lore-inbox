Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289917AbSBFBjp>; Tue, 5 Feb 2002 20:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289972AbSBFBji>; Tue, 5 Feb 2002 20:39:38 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:18696 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289917AbSBFBjW>; Tue, 5 Feb 2002 20:39:22 -0500
Subject: Re: stumped with APM suspend/resume problem going from 2.4.5 ->
	2.4.17
From: Matt <mjg23@yahoo.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202050107.CAA06035@harpo.it.uu.se>
In-Reply-To: <200202050107.CAA06035@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 05 Feb 2002 20:39:15 -0500
Message-Id: <1012959556.1117.7.camel@blackbird.sectionone>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

disabling both CONFIG_SMP and CONFIG_X86_UP_APIC fixed the
suspend/resume problem.  I haven't confirmed whether or not
CONFIG_X86_UP_APIC alone brings back the problem -- will let you know.

the dmi settings are:

    DMI 2.3 present. 
    DMI table at 0x000E0010. 
    
/proc/cpuinfo comes up as:

    processor	: 0
    vendor_id	: GenuineIntel
    cpu family	: 6
    model		: 8
    model name	: Pentium III (Coppermine)
    stepping	: 6
    cpu MHz		: 696.980
    cache size	: 256 KB
    fdiv_bug	: no
    hlt_bug		: no
    f00f_bug	: no
    coma_bug	: no
    fpu		: yes
    fpu_exception	: yes
    cpuid level	: 2
    wp		: yes
    flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
    pat pse36 mmx fxsr sse
    bogomips	: 1389.36
    

thanks for all your help.
-Matt

On Mon, 2002-02-04 at 20:07, Mikael Pettersson wrote: 
> On Sun, 03 Feb 2002 12:18:50 -0500, Matt <mjg23@yahoo.com> wrote:
> >I have a Thinkpad T20 and have been using a hand-built 2.4.5 kernel for 
> >some time.  Recently, ever since I got a USB scanner and camera, I've 
> >been experiencing spurious machine hangs.  I read on one of the lists 
> >that there was a bug in the USB core that sounded related so I tried to 
> >upgrade.
> >
> >Everything works ok with the stock 2.4.17 kernel (except the addition of 
> >the pcmcia-cs pacakge version 3.1.31) I built except that "apm -s" and 
> >then resume causes the machine to hang.  On resume, even outside of X, 
> >the screen blanks or appears but doesn't respond to keyboard input.  No 
> >oops, no messages, no nothing.  The only choice I have at that point is 
> >a hard reset.
> >
> >I just tried the 2.5.3 beta kernel and had the same problem.
> >
> >Please let me know if there's anything else I can do to help diagnose 
> >the problem and/or workaroound it.  I'll include my .config file in case 
> >that helps.
> >
> >Thanks and keep up the great work.
> >-Matt
> >...
> >CONFIG_SMP=y
> 
> CONFIG_SMP could actually trigger the problem. Since about 2.4.10,
> the kernel will try to enable and use the processor's "local APIC"
> (a built-in interrupt controller) if CONFIG_SMP _or_ CONFIG_X86_UP_APIC
> is enabled. Unfortunately, some machines have crap BIOSen that break
> this feature. The Dell Inspiron is the standard example of this,
> but the T20 might also be affected.
> 
> Does /proc/cpuinfo list the "apic" feature flag?
> 
> If so, does disabling CONFIG_SMP and running a normal UP kernel
> eliminate the hangs?
> 
> If a plain UP kernel works, does UP with CONFIG_X86_UP_APIC
> reintroduce the hangs?
> 
> If all this is true, then it's a safe bet that your BIOSs (actually
> the "SMM" part of it) can't handle an enabled local APIC. I'm
> working on a patch for this: could you edit arch/i386/kernel/dmi_scan.c,
> change the #define dmi_printk(x) to use printk instead of being
> empty, reboot, and send me the DMI strings printed during boot?
> 
> /Mikael


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

