Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271370AbRH1PMj>; Tue, 28 Aug 2001 11:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271371AbRH1PMa>; Tue, 28 Aug 2001 11:12:30 -0400
Received: from z.thunderworx.net ([217.27.32.64]:18449 "EHLO francoudi.com")
	by vger.kernel.org with ESMTP id <S271370AbRH1PMS>;
	Tue, 28 Aug 2001 11:12:18 -0400
Date: Tue, 28 Aug 2001 18:10:23 +0300
From: Vladimir Ivaschenko <hazard@francoudi.com>
To: linux-kernel@vger.kernel.org
Subject: stuck on TLB IPI wait
Message-ID: <20010828181023.A18890@francoudi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Operating-System: Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Please CC any answers to my e-mail, as I'm not a subscriber to the list.

I run two nodes with identical RH-based 2.2.19 kernels with ext3 patches
in a cluster using "heartbeat". I also use InterMezzo module. The nodes
are Compaq DL360, 2x933 Mhz PIII, 2x36 GB HDDs on Compaq Smartarray. Node
#1 has 256MB RAM, node #2 has 512MB RAM. Distribution is RedHat 6.2.

/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 930.465
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr xmm
bogomips        : 1854.66

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 930.465
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr xmm
bogomips        : 1854.66


>From time to time, on node #2 (which is a stand-by node) I get the
following message:

Aug 15 19:55:01 mail2 kernel: stuck on TLB IPI wait (CPU#3)
Aug 15 19:55:01 mail2 last message repeated 5 times

Followed by messages from heartbeat the mail1 is down and is it taking
over the resouces. After that everything functions normally. Please note
that I'm running with "noapic", otherwise system often freezes when it
initializes the network cards - I can press the keys, but apparently all
IO is blocked as there is no response. These "freezes" happen with all 
kernels I tried, both RedHat and clean kernels from linux.org.

Aug 15 19:55:03 mail2 heartbeat: info: Running /etc/ha.d/rc.d/shutdone shutdone
Aug 15 19:55:11 mail2 heartbeat[554]: WARN: node mail1.X.X: is dead
Aug 15 19:55:11 mail2 heartbeat: info: Running /etc/ha.d/rc.d/status status
Aug 15 19:55:11 mail2 heartbeat: info: Taking over resource group X.X.X.193
Aug 15 19:55:12 mail2 heartbeat: info: Acquiring resource group: mail1.X.X X.X.X.193 isinglass
Aug 15 19:55:12 mail2 heartbeat: info: Running /etc/ha.d/resource.d/IPaddr X.X.X.193 start
Aug 15 19:55:12 mail2 heartbeat: info: ifconfig eth0:0 X.X.X.193 netmask 255.255.255.0^Ibroadcast X.X.X.255
Aug 15 19:55:12 mail2 heartbeat: info: Sending Gratuitous Arp for X.X.X.193 on eth0:0 [eth0]
Aug 15 19:55:12 mail2 heartbeat: info: Running /etc/ha.d/resource.d/isinglass  start
Aug 15 19:55:13 mail2 heartbeat: info: mach_down takeover complete.
Aug 15 19:55:13 mail2 heartbeat[554]: info: Link mail1.X.X:eth1 dead.
Aug 15 19:55:13 mail2 heartbeat: info: Running /etc/ha.d/rc.d/ifstat ifstat

Please let me know if any other information is needed.

-- 
Best Regards
Vladimir Ivaschenko

