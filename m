Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbVLWXOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbVLWXOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbVLWXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 18:14:35 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:57521 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161103AbVLWXOe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 18:14:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gm6QvFddRTOUpcbumV9dSdNLTY11dVYeOJHEyL09wDuNTRhlL7poJ4v3/jCh+uuq49Ky5sYv0zkdXbSvi4aXEEtqNIQXdVxtNejJW/0FhnWHThh0RvQExX7Lnga5PIiOCt6EqcdoY7+OHp4Lt2XQDWrP9UWDyXF5pH2j8knAhL4=
Message-ID: <b7561c4a0512231514y3bd6564jd13d16ea4476f07e@mail.gmail.com>
Date: Fri, 23 Dec 2005 15:14:33 -0800
From: Leroy van Logchem <leroy.vanlogchem@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: bug in e1000 module causes very high CPU load
Cc: Kernel Netdev Mailing List <netdev@vger.kernel.org>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       ph0x <ph0x@freequest.net>
In-Reply-To: <20051211194114.GBCH17186.mxfep02.bredband.com@ph0x>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4807377b0512101416t2f3a04c5ua6859ab3d99e8d07@mail.gmail.com>
	 <20051211194114.GBCH17186.mxfep02.bredband.com@ph0x>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> Yes, let the server act as usual, it just starts happening out of the blue.
> No new hardware has been added or removed, no new programs has been
> installed.

"Me too"

[2.] Full description of the problem/report:
Last week I had the same issue twice. In short: load goes through the
roof from 2 to 950 within five minutes. Never been able to use the
console -no response-. These servers where part of a HA nfs cluster so
we had to pull the plug (we dont have a mon plugin for extreme load
values yet). Once triggered, it seems, there is noway back. But once
fail-over has occured the other server does break - so my simplistic
conclusion is that this behaviour isnt based on usage patterns by our
nfs clients beating the server.

# lspci | grep -i giga
02:03.0 Ethernet controller: Intel Corporation 82546EB Gigabit
Ethernet Controller (Copper) (rev 01)
02:03.1 Ethernet controller: Intel Corporation 82546EB Gigabit
Ethernet Controller (Copper) (rev 01)

# more /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:   26571295   26559117   40034487   40909166    IO-APIC-edge  timer
  1:          9          0          0          0    IO-APIC-edge  i8042
  2:          0          0          0          0          XT-PIC  cascade
  8:          1          0          0          0    IO-APIC-edge  rtc
 12:         59          0          0          0    IO-APIC-edge  i8042
 15:         20          0          0          0    IO-APIC-edge  ide1
153:          0          0          0          0   IO-APIC-level  uhci_hcd
161:          0          0          0          0   IO-APIC-level  uhci_hcd
169:          0          0          0          0   IO-APIC-level  uhci_hcd
177:     176067     319337     329774     239612   IO-APIC-level  aic79xx
185:     534649    3958315    6395749    9602510   IO-APIC-level  aic79xx
193:   88511141          0          0          0   IO-APIC-level  eth0
201:         60          0   24342441          0   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:  134085019  134085069  134084971  134085090
ERR:          0
MIS:          0

[7.1.] Software (add the output of the ver_linux script here)
Linux somewhere 2.6.9-11.ELsmp #1 SMP Fri May 20 18:26:27 EDT 2005
i686 i686 i386 GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nfsd exportfs drbd nfs lockd sunrpc md5 ipv6
parport_pc lp parport autofs4 w83781d adm1021 i2c_sensor i2c_i801
i2c_core dm_mod uhci_hcd hw_random e1000 floppy sg ext3 jbd aic79xx
sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 5
cpu MHz         : 2799.959
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse ss
e2 ss ht tm pbe cid xtpr
bogomips        : 5521.40
and so on... because of two xeon's in HT-mode

[7.5.] PCI information ('lspci -vvv' as root) ((Just the ethernet))
02:03.0 Ethernet controller: Intel Corporation 82546EB Gigabit
Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corporation PRO/1000 MT Dual Port Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at fc200000 (64-bit, non-prefetchable) [size=128K]
        Region 4: I/O ports at 3000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=2 Dev=3 Func=0 64bit+ 133MHz+ SCD- USC-,
DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
        Capabilities: [f0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

Is there a method which can give hints about what was going on during
the sharply rising load? My guess is that even monitoring/sampling
aint doable anymore if the bad situation occurs. Tips on obtaining
information about subjects like:
- who was using which tcp/udp connection with what bandwidth
- who was generating how many read/writes on which filesystem incl. location
- etc etc.
are more then welcome too. Does using profile=2 and storing
readprofile output to files every 5 seconds give enough information to
tacle the source of this problem?

Please CC, thanks.

Best regards,
Leroy
