Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVANXBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVANXBo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVANW7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:59:46 -0500
Received: from twister.ispgateway.de ([80.67.18.17]:34492 "EHLO
	twister.ispgateway.de") by vger.kernel.org with ESMTP
	id S261416AbVANWz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:55:58 -0500
Date: Fri, 14 Jan 2005 23:55:55 +0100
From: Steffen Moser <lists@steffen-moser.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-rc2
Message-ID: <20050114225555.GA17714@steffen-moser.de>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20050112151334.GC32024@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112151334.GC32024@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

* On Wed, Jan 12, 2005 at 01:13 PM (-0200), Marcelo Tosatti wrote:

> Here goes the second release candidate of v2.4.29.

I've just encountered a little problem with both "linux-2.4.29-rc1" 
and "linux-2.4.29-rc2" on one of two machines. 


[1.] One line summary of the problem: 

Kernel module "serial.o" cannot be loaded


[2.] Full description of the problem/report:

I cannot load the module "serial.o" anymore, so I won't have serial 
port support (which is needed to have the machine communicating with
the UPS):

 | fsa01:~ # modprobe serial
 | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: unresolved symbol tty_ldisc_flush
 | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: unresolved symbol tty_wakeup
 | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: insmod /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o failed
 | /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: insmod serial failed

Up to now I've tested 2.4.29-rc1 and 2.4.29-rc2 only on two machines
("fsa01": SuSE Linux 7.2, "gateway": SuSE Linux 8.0). 

So far I can only state:

 - The problem only occurs on machine "fsa01" - using both 
   "2.4.29-rc1" and "2.4.29-rc2". 

 - The problem doesn't occur using 2.4.27 and 2.4.28 on the same
   machine using the same ".config" which can be found here [1].

 - There is no (!) problem on "gateway" (there I've only tested
   "2.4.29-rc1", yet). "gateway"'s ".config" can be found here [2]. 
 
 - I haven't tested "2.4.29-pre1" ... "2.4.29-pre3", yet. So I can't
   say which kernel version "introduced" the problem.

 
[3.] Keywords (i.e., modules, networking, kernel):

modules, tty


[4.] Kernel version (from /proc/version):

 | fsa01:~ # cat /proc/version
 | Linux version 2.4.29-rc2 (root@fsa01) (gcc version 2.95.3 20010315 (SuSE)) #3 Fri Jan 14 20:21:08 CET 2005

"2.4.29-rc1" is also affected on the same machine.


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt):

There is no Oops message, even "dmesg" and "/var/log/messages"
respectively don't show anything wrong besides:

 | Jan 14 21:02:09 fsa01 insmod: /lib/modules/2.4.29-rc2/kernel/drivers/char/serial.o: insmod char-major-4 failed

which is generated during boot up.


[6.] A small shell script or example program which triggers the
     problem (if possible):

I just try to insert the module "serial.o"


[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

 - fsa01 (problem occurs):

 | If some fields are empty or look unusual you may have an old version.
 | Compare to the current minimal requirements in Documentation/Changes.
 | 
 | Linux fsa01 2.4.29-rc2 #3 Fri Jan 14 20:21:08 CET 2005 i686 unknown
 | 
 | Gnu C                  2.95.3
 | Gnu make               3.79.1
 | binutils               2.10.91.0.4
 | util-linux             2.11l
 | mount                  2.11l
 | modutils               2.4.5
 | e2fsprogs              1.25
 | pcmcia-cs              3.1.25
 | quota-tools            3.08.
 | Linux C Library        x    1 root     root      1341670 Dec 18  2001 /lib/libc.so.6
 | Dynamic linker (ldd)   2.2.2
 | Procps                 2.0.7
 | Net-tools              1.60
 | Kbd                    1.04
 | Sh-utils               2.0
 | Modules Loaded         ipv6 3c59x ipchains

 - gateway (no problem):

 | If some fields are empty or look unusual you may have an old version.
 | Compare to the current minimal requirements in Documentation/Changes.
 | 
 | Linux gateway 2.4.29-rc1 #4 Tue Jan 11 14:57:41 CET 2005 i686 unknown
 | 
 | Gnu C                  2.95.3
 | Gnu make               3.79.1
 | util-linux             2.11n
 | mount                  2.11n
 | modutils               2.4.12
 | e2fsprogs              1.26
 | jfsutils               1.0.15
 | xfsprogs               2.0.0
 | PPP                    2.4.1
 | Linux C Library        x    1 root     root      1394302 Aug 10  2002 /lib/libc.so.6
 | Dynamic linker (ldd)   2.2.5
 | Procps                 2.0.7
 | Net-tools              1.60
 | Kbd                    1.06
 | Sh-utils               2.0
 | Modules Loaded         serial ip_nat_ftp ip_conntrack_ftp ipt_REJECT
 |                        iptable_filter ipt_MASQUERADE iptable_nat ip_conntrack 
 |                        ip_tables ipv6 3c59x

[7.2.] Processor information (from /proc/cpuinfo):

 | v00001@fsa01:~ > cat /proc/cpuinfo
 | processor       : 0
 | vendor_id       : GenuineIntel
 | cpu family      : 6
 | model           : 8
 | model name      : Pentium III (Coppermine)
 | stepping        : 10
 | cpu MHz         : 871.032
 | cache size      : 256 KB
 | fdiv_bug        : no
 | hlt_bug         : no
 | f00f_bug        : no
 | coma_bug        : no
 | fpu             : yes
 | fpu_exception   : yes
 | cpuid level     : 2
 | wp              : yes
 | flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
 | bogomips        : 1736.70


[7.3.] Module information (from /proc/modules):

 | v00001@fsa01:~ > cat /proc/modules
 | ipv6                  144736  -1 (autoclean)
 | 3c59x                  25088   1 (autoclean)
 | ipchains               37504   0


[7.4.] Loaded driver and hardware information (/proc/ioports,
       /proc/iomem):

 | v00001@fsa01:~ > cat /proc/ioports
 | 0000-001f : dma1
 | 0020-003f : pic1
 | 0040-005f : timer
 | 0060-006f : keyboard
 | 0080-008f : dma page reg
 | 00a0-00bf : pic2
 | 00c0-00df : dma2
 | 00f0-00ff : fpu
 | 01f0-01f7 : ide0
 | 03c0-03df : vga+
 | 03f6-03f6 : ide0
 | 0cf8-0cff : PCI conf1
 | a000-a01f : Intel Corp. 82801BA/BAM USB (Hub #2)
 | a400-a41f : Intel Corp. 82801BA/BAM USB (Hub #1)
 | a800-a80f : Intel Corp. 82801BA IDE U100
 |   a800-a807 : ide0
 |   a808-a80f : ide1
 | b800-b87f : 3Com Corporation 3c905C-TX/TX-M [Tornado] (#2)
 |   b800-b87f : 02:0d.0
 | d000-d07f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
 |   d000-d07f : 02:0c.0
 | d400-d4ff : Adaptec AIC-7892A U160/m
 | d800-d87f : Silicon Integrated Systems [SiS] 86C326 5598/6326
 | e800-e80f : Intel Corp. 82801BA/BAM SMBus

 | v00001@fsa01:~ > cat /proc/iomem
 | 00000000-0009f7ff : System RAM
 | 0009f800-0009ffff : reserved
 | 000a0000-000bffff : Video RAM area
 | 000c0000-000c7fff : Video ROM
 | 000c8000-000ce5ff : Extension ROM
 | 000d0000-000d07ff : Extension ROM
 | 000d4000-000d47ff : Extension ROM
 | 000f0000-000fffff : System ROM
 | 00100000-1ffeafff : System RAM
 |   00100000-0022d5a6 : Kernel code
 |   0022d5a7-002af243 : Kernel data
 | 1ffeb000-1ffeefff : ACPI Tables
 | 1ffef000-1fffefff : reserved
 | 1ffff000-1fffffff : ACPI Non-volatile Storage
 | f5000000-f500007f : 3Com Corporation 3c905C-TX/TX-M [Tornado] (#2)
 | f5800000-f580007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
 | f6000000-f6000fff : Adaptec AIC-7892A U160/m
 |   f6000000-f6000fff : aic7xxx
 | f6800000-f680ffff : Silicon Integrated Systems [SiS] 86C326 5598/6326
 | f7800000-f7ffffff : Silicon Integrated Systems [SiS] 86C326 5598/6326
 | f8000000-fbffffff : Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub
 | ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root):

Find this information at [3] (fsa01) and [4] (gateway).


[7.6.] SCSI information (from /proc/scsi/scsi):

 | v00001@fsa01:~ > cat /proc/scsi/scsi
 | Attached devices:
 | Host: scsi0 Channel: 00 Id: 00 Lun: 00
 |   Vendor: IBM      Model: DPSS-336950M     Rev: S96H
 |   Type:   Direct-Access                    ANSI SCSI revision: 03
 | Host: scsi0 Channel: 00 Id: 01 Lun: 00
 |   Vendor: IBM      Model: DPSS-336950M     Rev: S96H
 |   Type:   Direct-Access                    ANSI SCSI revision: 03
 | Host: scsi0 Channel: 00 Id: 03 Lun: 00
 |   Vendor: HP       Model: C1537A           Rev: L005
 |   Type:   Sequential-Access                ANSI SCSI revision: 02
 | Host: scsi0 Channel: 00 Id: 04 Lun: 00
 |   Vendor: IBM      Model: DNES-318350      Rev: SA30
 |   Type:   Direct-Access                    ANSI SCSI revision: 03
 | Host: scsi0 Channel: 00 Id: 05 Lun: 00
 |   Vendor: IBM      Model: DNES-318350      Rev: SA30
 |   Type:   Direct-Access                    ANSI SCSI revision: 03


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

If you need more information or testing, please let me know... 

I suppose the problem isn't related to the hardware of "fsa01" but 
perhaps to the different ".config" or the different version of the 
modutils, for example. 

Are you or is someone else able to reproduce the problem I have?

TIA!

Bye,
Steffen

[1] http://www.steffen-moser.de/temp/ml/lkml/2005-01-14_01/fsa01_config 
[2] http://www.steffen-moser.de/temp/ml/lkml/2005-01-14_01/gateway_config
[3] http://www.steffen-moser.de/temp/ml/lkml/2005-01-14_01/fsa01_lspci
[4] http://www.steffen-moser.de/temp/ml/lkml/2005-01-14_01/gateway_lspci
