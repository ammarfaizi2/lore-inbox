Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293161AbSCOTVO>; Fri, 15 Mar 2002 14:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293169AbSCOTVH>; Fri, 15 Mar 2002 14:21:07 -0500
Received: from usfw01.photomask.com ([198.6.73.7]:19538 "EHLO
	yellow.photomask.com") by vger.kernel.org with ESMTP
	id <S293161AbSCOTUw> convert rfc822-to-8bit; Fri, 15 Mar 2002 14:20:52 -0500
From: John Helms <john.helms@photomask.com>
Date: Fri, 15 Mar 2002 19:25:17 GMT
Message-ID: <20020315.19251700@linux.local>
Subject: bug (trouble?) report on high mem support
To: linux-kernel@vger.kernel.org
CC: "Trice, Jim" <Jim.Trice@photomask.com>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is John Helms and I am trying to
convert our systems over to linux from 
HP-UX.  However, one of our critical
programs is giving problems because it
runs so slowly as to be useless when 
running under the 2.4.7-10 enterprise 
kernel.  This same program runs fine
under the 2.4.7-10 smp kernel.  The main
difference is that in a top output, most
of the cpu time is in system mode and very
little user mode under the enterprise kernel,
and just the opposite under the smp kernel.

Any help would be greatly appreciated.


Thanks,
John Helms 
Admin.
DuPont Photomasks, Inc.
512-310-6185





1.  Program runs slowly in kernel mode in high memory kernel

2.  A program we use runs almost entirely in kernel 
mode in a kernel compiled for large (>4GB) memory support.
Same program runs in user mode in a kernel only compiled
for smp support (4GB memory limit).  Top output shows only
~5% cpu for user, ~95% for system and program runs VERY slow.
SMP kernel has ~60% user, ~40% system and program runs
acceptably.

3.  kernel, memory

4.  Linux version 2.4.7-10enterprise 
(bhcompile@stripples.devel.redhat.com)

5.  No Oops 

6.  No example script available.

7. Environment:

rrux01 28: more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 4
cpu MHz         : 899.324
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsrsse
bogomips        : 1795.68

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 4
cpu MHz         : 899.324
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr
sse
bogomips        : 1795.68
 
processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 4
cpu MHz         : 899.324
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr
sse
bogomips        : 1795.68
 
processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 4
cpu MHz         : 899.324
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr
sse
bogomips        : 1795.68        


rrux01 30: more /proc/modules
iptable_mangle          2272   0 (autoclean) (unused)
iptable_nat            19280   0 (autoclean) (unused)
ip_conntrack           18544   1 (autoclean) [iptable_nat]
iptable_filter          2272   0 (autoclean) (unused)
ip_tables              11936   5 [iptable_mangle iptable_nat 
iptable_filter]
sg                     29552   0 (autoclean)
reiserfs              161360   1 (autoclean)
nfs                    83680   3 (autoclean)
lockd                  53744   1 (autoclean) [nfs]
sunrpc                 70000   1 (autoclean) [nfs lockd]
ide-cd                 27136   0 (autoclean)
cdrom                  28800   0 (autoclean) [ide-cd]
soundcore               4848   0 (autoclean)
autofs                 12064   2 (autoclean)
e1000                  62944   1
pcnet32                12368   0 (unused)
st                     27024   0 (unused)
usb-ohci               19360   0 (unused)
usbcore                54560   1 [usb-ohci]
ext3                   67728   8
jbd                    44480   8 [ext3]
ips                    39552  10
aic7xxx               114704   0 (unused)
sd_mod                 11584  10
scsi_mod               98512   5 [sg st ips aic7xxx sd_mod]    



rrux01 31: more /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0700-070f : ServerWorks OSB4 IDE Controller
  0700-0707 : ide0
  0708-070f : ide1
0cf8-0cff : PCI conf1
2200-22ff : Adaptec AHA-294x / AIC-7884U
  2200-22fe : aic7xxx
2300-231f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
  2300-231f : PCnet/FAST III 79C975
4000-40ff : Adaptec 7899P
  4000-40fe : aic7xxx
4100-41ff : Adaptec 7899P (#2)
  4100-41fe : aic7xxx
4200-42ff : Adaptec 7892A
  4200-42fe : aic7xxx           



rrux01 29: more /proc/iomem
00000000-0009cfff : System RAM
0009d000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca000-000ca7ff : Extension ROM
000ca800-000d27ff : Extension ROM
000f0000-000fffff : System ROM
00100000-dfff937f : System RAM
  00100000-0025e40f : Kernel code
  0025e410-00277d3f : Kernel data
dfff9380-dfffffff : ACPI Tables
ec2d0000-ec2dffff : PCI device 8086:1001 (Intel Corporation)
ec2e0000-ec2fffff : PCI device 8086:1001 (Intel Corporation)
  ec2e0000-ec2fffff : e1000
ed7fe000-ed7fffff : PCI device 1014:01bd (IBM)
  ed7fe000-ed7fffff : ips
efbfd000-efbfdfff : Adaptec 7892A
efbfe000-efbfefff : Adaptec 7899P (#2)
efbff000-efbfffff : Adaptec 7899P
f0000000-f7ffffff : S3 Inc. Savage 4
feb00000-feb7ffff : S3 Inc. Savage 4
febfd000-febfdfff : ServerWorks OSB4/CSB5 OHCI USB Controller
  febfd000-febfdfff : usb-ohci
febfec00-febfec1f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
febff000-febfffff : Adaptec AHA-294x / AIC-7884U
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved           



