Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbQKGWcD>; Tue, 7 Nov 2000 17:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbQKGWbx>; Tue, 7 Nov 2000 17:31:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129958AbQKGWbk>; Tue, 7 Nov 2000 17:31:40 -0500
Date: Tue, 7 Nov 2000 17:31:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
cc: Chris Meadors <clubneon@hereintown.net>,
        Ulrich Drepper <drepper@redhat.com>, kernel@kvack.org,
        "Dr. David Gilbert" <dg@px.uk.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.4.21.0011071401280.4438-100000@sol.compendium-tech.com>
Message-ID: <Pine.LNX.3.95.1001107172159.198A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Dr. Kelsey Hudson wrote:

> > This machine isn't even a Xeon, just a PIII CuMine on a ServerWorks HeIII
> > chipset.
> 
> Strange, I've got a dual Katmai (non-Xeon) and notice the same...
> 
>            CPU0       CPU1       
>   0:   95135438   95720832    IO-APIC-edge  timer
>   1:     579101     572402    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:    1414912    1423496    IO-APIC-edge  serial
>   5:    5563231    5551230    IO-APIC-edge  soundblaster
>   9:          0          0    IO-APIC-edge  acpi
>  10:   10945738   10944261   IO-APIC-level  eth0
>  11:     696382     700477   IO-APIC-level  ide0, ide1
>  12:    7251164    7251575    IO-APIC-edge  PS/2 Mouse
>  13:          0          0          XT-PIC  fpu
>  14:    3079238    3079438   IO-APIC-level  eth1
>  15:        111        130   IO-APIC-level  bttv
> NMI:  190856196  190856196 
> LOC:  190858464  190858463 
> ERR:          0
> 
> This cannot be good...
> 
>  Kelsey Hudson                                           khudson@ctica.com 
>  Software Engineer
>  Compendium Technologies, Inc                               (619) 725-0771
> ---------------------------------------------------------------------------     

The build time (of version 2.2.17) was 300 seconds +/- 20 seconds
with Linux version 2.2.17.

The build time (of version 2.2.17) is now 1240 seconds +/- 20 seconds
with Linux version 2.4.0.

So the system is about 4 times slower.

Also, I get some CPU watchdog timeout that I didn't ask for Grrr...

Nov  7 17:17:54 chaos nmbd[115]:   Samba server CHAOS is now a domain master browser for workgroup LINUX on subnet 204.178.40.224 
Nov  7 17:17:54 chaos nmbd[115]:    
Nov  7 17:17:54 chaos nmbd[115]:   ***** 
Nov  7 17:18:54 chaos kernel: NMI Watchdog detected LOCKUP on CPU0, registers: 
Nov  7 17:18:54 chaos kernel: CPU:    0 
Nov  7 17:19:01 chaos login: ROOT LOGIN ON tty2


           CPU0       CPU1       
  0:      10945      11869    IO-APIC-edge  timer
  1:        419        393    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          0    IO-APIC-edge  rtc
 10:       2990       2904   IO-APIC-level  eth0
 11:       1066       1124   IO-APIC-level  BusLogic BT-958
 13:          0          0          XT-PIC  fpu
NMI:      22748      22748 
LOC:      21731      22229 
ERR:          0


The NMI and LOC (timers) run faster than timer channel 0. This
cannot be correct. Anybody know what this is and how to get
rid of these CPU time stealers?


This is just a dual 400MHz Pentiumi II:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 400.000915
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 799.54

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 400.000915
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 801.18


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
