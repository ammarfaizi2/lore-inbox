Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbUCMPyw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbUCMPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 10:54:52 -0500
Received: from hera.kernel.org ([63.209.29.2]:39121 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263118AbUCMPyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 10:54:46 -0500
Date: Sat, 13 Mar 2004 12:52:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: "Klaus M. Brantl" <kmb@deam.org>
cc: linux-kernel@vger.kernel.org, <neilb@cse.unsw.edu.au>, <andrea@suse.de>,
       <mingo@redhat.com>
Subject: Re: bug-report about a stability-problem with highmem and nfs
In-Reply-To: <29759D23-7361-11D8-A905-000A9575DB74@deam.org>
Message-ID: <Pine.LNX.4.44.0403131238120.19494-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Klaus, 

On Thu, 11 Mar 2004, Klaus M. Brantl wrote:

> sear kernel-team,
> 
> i hope the following report gives you enought information to figure out 
> whats wrong/ or tell me that i did something wrong :-)
> 
> if you have further questions tell me.
> 
> [1.] One line summary of the problem:
> Total halt of the machine without kernel-panic-message; reboot only 
> possible with hardware-reset.
> 
> [2.] Full description of the problem/report:
> [2.0.] Background
> We are using a number of machines as webserver an two machines as 
> fileserver for part of the filesystem that is needed for all nodes.
> At the beginning (with kernel 2.4.20) there was no problem at all, but 
> there was also not much load and traffic :-)
> During autumn 2003 we had a number of those "silent crashes" - the 
> uptime between shrinkened during this period from two months to three 
> weeks.
> We started testing on the backup-fileserver at the very first crash and 
> it took us until february to get closer.
> We always used the current kernel-version (2.4.25) in our tests during 
> february.
> 
> [2.1.] Summary
> Finally we "developed" a simple method to provoke a crash. We simply 
> wrote tons of files from a nfs-client to the nfs-server - and deleted 
> and over-wrote....
> Finally the only thing that prevented a crash (so far) was limiting the 
> HIGHMEM to 4GB - we have 6GB build in.
> 
> It looks like the machine crashes only if you can fill up the memory 
> (cached mem) over a longer period.
> The provoked crashes happend within one hour (see 6.) of out testing.
> 
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> Memory/ RAM, PAE, NFS-Kernel-Server
> 
> 
> [4.] Kernel version (from /proc/version):
> Linux version 2.4.25 (root@myserver) (gcc version 2.95.4 20011002 
> (Debian prerelease)) #6 SMP Tue Feb 24 11:46:24 CET 2004
> 
> 
> [5.] Output of Oops.. message (if applicable) with symbolic information 
> resolved (see Documentation/oops-tracing.txt)
> none.
> 
> 
> [6.] A small shell script or example program which triggers the problem 
> (if possible)
> We simply started multiple dd's to write and overwrite lot of files.
> In the crash-test we only needed to write around 80.000 small files (dd 
> count=60 if=/dev/zero of=/server/smallN) and around 3.000 larger files 
> (dd count=230000 if=/dev/zero of=/server/largeN).
> In addition we used a lot of memory on the Server with an Apache (this 
> action only shortend the time until it crashed).

Can you please plug in a serial cable, turn the NMI oopser on
(Documentation/nmi_watchdog.txt), and rerun the tests with 6GB to crash
the box? This should get us an output of what is happening. 

You say the system is stable with 4GB, so indeed the problem seems to be
related to PAE.

You say 2.4.20 stock is flawless with 6GB, yes? Or were you using distro's 
2.4.20 ? Did you remember trying other 2.4's with 6GB enabled ?

Thanks

> [7.] Environment
> [7.0.] Systembase
> Debian-Woody-Installation - no backports.
> 
> Hardware:
> - - Compaq DL380 R03
> - - 2 x XEON 2.8 GHz
> - - 6 GB RAM
> - - 2 x 18 GB HD mirrored (system)
> - - 3 x 36 GB RAID-5 (shared files)
> - - 1 x AIT 50/100 GB Tape
> - - 2 x GE NIC " 1 x 100 Mbit NIC
> 
> 
> [7.1.] Software (add the output of the ver_linux script here)
> Linux myserver 2.4.25 #6 SMP Tue Feb 24 11:46:24 CET 2004 i686 unknown
> 
> Gnu C                  2.95.4
> Gnu make               3.79.1
> util-linux             2.11n
> mount                  2.11n
> modutils               2.4.15
> e2fsprogs              1.27
> PPP                    2.4.1
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Procps                 2.0.7
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               2.0.11
> 
> [7.2.] Processor information (from /proc/cpuinfo):
> Linux version 2.4.25 (root@myserver) (gcc version 2.95.4 20011002 
> (Debian prerelease)) #6 SMP Tue Feb 24 11:46:24 CET 2004
> klaus@myserver:~$ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.80GHz
> stepping        : 7
> cpu MHz         : 2786.278
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 5557.45
> 
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.80GHz
> stepping        : 7
> cpu MHz         : 2786.278
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 5570.56
> 
> processor       : 2
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.80GHz
> stepping        : 7
> cpu MHz         : 2786.278
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 5570.56
> 
> processor       : 3
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.80GHz
> stepping        : 7
> cpu MHz         : 2786.278
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 5570.56

