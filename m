Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTIRQ7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 12:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTIRQ7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 12:59:14 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:9979 "EHLO
	albatross.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261910AbTIRQ7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 12:59:10 -0400
Date: Thu, 18 Sep 2003 09:59:05 -0700
To: linux-kernel@vger.kernel.org
Cc: Ross Boylan <RossBoylan@stanfordalumni.org>,
       Manoj Srivastava <srivasta@debian.org>
Subject: PROBLEM: Default initial config options all N
Message-ID: <20030918165905.GX12620@wheat.boylan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ross Boylan <RossBoylan@stanfordalumni.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me on replies.

[1.] One line summary of the problem:  
Defaults for oldconfig options not set correctly in recent 2.4 kernels
  
[2.] Full description of the problem/report:
Built 2.4.21 kernel, starting with config file from 2.4.20 and running
oldconfig.  *All* new config options had default values of N.  The
help text for the following options suggested "if unsure, pick Y":
PF_KEY
CONFIG_INET_AH
CONFIG_INET_ESP
CONFIG_INET_IPCOMP
CONFIG_IP_NF_TFTP
CONFIG_XFRM_USER

I did not check the help text for all options, so there may be
others. 

I speculate that as new options are introduced into the kernel the
default values are not getting set.  In the past I've seen default
values that are not N.  Alternately, perhaps oldconfig is ignoring the
defaults. 

Built the Debian way with Debianised kernel-source (2.4.21-5) and
make-kpkg.  Various patches applied to kernel (new NTFS, EVMS, XFS)
applied before configuration ran.  Debian kernel-package maintainer
thinks the issue (if any) is with the original sources.

[3.] Keywords (i.e., modules, networking, kernel):
configuration; 2.4.21; defaults; build; Debian; 2.4.19; 2.4.20;
oldconfig 

[4.] Kernel version (from /proc/version):
Building 2.4.21 on a 2.4.20 kernel
Also an issue for 2.4.19 and 2.4.20

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Sample from the config dialog:

PF_KEY sockets (CONFIG_NET_KEY) [N/y/m/?] (NEW) ?

CONFIG_NET_KEY:

  PF_KEYv2 socket family, compatible to KAME ones.
  They are required if you are going to use IPsec tools ported
  from KAME.

  Say Y unless you know what you are doing.
PF_KEY sockets (CONFIG_NET_KEY) [N/y/m/?] (NEW) y


[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A.  Invoked with
 make-kpkg --revision rb.1 --append-to-version advncdfs --rootcmd
 fakeroot configure

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Probably not relevant, but here it is:
Linux wheat 2.4.20advncdfs #1 Thu May 15 22:28:21 PDT 2003 i686 GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
binutils               2.14.90.0.4
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.34-WIP
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         parport_pc lp ipt_MASQUERADE ipt_LOG ipt_limit iptable_mangle iptable_filter iptable_nat ip_tables ip_conntrack_ftp ip_conntrack ppp_deflate zlib_inflate zlib_deflate bsd_comp ppp_async ppp_generic slhc af_packet snd-seq-midi snd-emu8000-synth snd-emux-synth snd-seq-virmidi snd-util-mem snd-opl3-synth snd-seq-instr snd-seq-midi-emul snd-ainstr-fm snd-seq-oss snd-seq-midi-event snd-seq rtc reiserfs nls_iso8859-1 nls_cp437 vfat fat mga agpgart scanner usb-ohci usbcore eeprom w83781d i2c-proc i2c-core isofs sg sr_mod ide-scsi ide-cd cdrom scsi_mod snd-pcm-oss snd-mixer-oss snd-sbawe snd-sb16-dsp snd-pcm snd-page-alloc snd-sb16-csp snd-sb-common snd-opl3-lib
snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.985
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1612.18

[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
Workaround is to pay attention and not accept the default response.
If the defaults are wrong it would be good to fix them.
If the procedure generating the defaults for new options is wrong, it
would be good to fix that.

2.4.19 and 2.4.20 oldconfig also shows all default options as N.  I'm
not sure when this behavior started.

Possibly the problem is specific to oldconfig, rather than other
configuration methods.

I can provide the full log of the build, if that would help.

Thanks.


