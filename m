Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSE1XhW>; Tue, 28 May 2002 19:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSE1XhV>; Tue, 28 May 2002 19:37:21 -0400
Received: from uffda.sdsc.edu ([192.31.21.65]:28032 "EHLO uffda.sdsc.edu")
	by vger.kernel.org with ESMTP id <S311871AbSE1XhU>;
	Tue, 28 May 2002 19:37:20 -0400
Date: Tue, 28 May 2002 16:37:40 -0700
From: Keith Thompson <kst@uffda.sdsc.edu>
To: linux-kernel@vger.kernel.org
Cc: kst@sdsc.edu
Subject: PROBLEM: kernel bug, dcache.c:362
Message-ID: <20020528163740.A2607@uffda.sdsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem: /var/log/messages reports a kernel bug at dcache.c:362,
an invalid operand.  See the excerpt below.

The system is uffda.sdsc.edu, a Dell OptiPlex GX1 running Red Hat 7.3.
I installed it on May 7 (an upgrade from Windows NT).  Since then,
I've installed XFree86-doc, AbiWord, fvwm2, nvi, openssh-server, and
Opera 6.0.  I've also installed several updates from Red Hat Network,
including a kernel update from 2.4.18-3 to 2.4.18-4.

Prior to the occurrence of the bug, I had been able to connect to
the system using ssh.  Afterwards, the system responded to ping, but
"ssh uffda" from a Solaris box hung indefinitely (i.e., until I killed
it with control-C).

I wasn't actively using the system at the time, and I know of no
significant processes that were running when the bug occurred.
I probably had several shells and xterms running, but they were idle.

About 11 hours after the bug occurred, I cycled power on uffda, and
it rebooted normally, other than some unsurprising messages about the
file system having been shut down uncleanly; I don't recall the exact
wording.  I ran a file system check, and it didn't find any problems.

Please let me know if I can provide any more information.

ver_linux says:
BEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGIN
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux uffda.sdsc.edu 2.4.18-4 #1 Thu May 2 18:47:38 EDT 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         binfmt_misc autofs 3c59x ide-cd cdrom cs4232 ad1848 uart401 sound soundcore usb-uhci usbcore ext3 jbd
ENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDEND

/proc/version says:
BEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGIN
Linux version 2.4.18-4 (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Thu May 2 18:47:38 EDT 2002
ENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDEND

/proc/cpuinfo says:
BEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGIN
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 447.699
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 891.28
ENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDEND

/proc/modules says:
BEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGIN
binfmt_misc             7556   1
autofs                 12164   0 (autoclean) (unused)
3c59x                  28520   1
ide-cd                 30272   0 (autoclean)
cdrom                  32192   0 (autoclean) [ide-cd]
cs4232                  5056   0
ad1848                 25696   0 [cs4232]
uart401                 7936   0 [cs4232]
sound                  72012   0 [cs4232 ad1848 uart401]
soundcore               6692   4 [sound]
usb-uhci               24484   0 (unused)
usbcore                73152   1 [usb-uhci]
ext3                   67136   2
jbd                    49464   2 [ext3]
ENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDEND

/etc/redhat-release says:
BEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGIN
Red Hat Linux release 7.3 (Valhalla)
ENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDEND

Here's the relevant excerpt from /var/log/messages.  Times are PDT (7
hours west of UTC).  The last message before this block was a couple of
days earlier; the first message after this block was over 11 hours later.
BEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGINBEGIN
May 28 04:02:15 uffda kernel: kernel BUG at dcache.c:362!
May 28 04:02:15 uffda kernel: invalid operand: 0000
May 28 04:02:15 uffda kernel: binfmt_misc autofs 3c59x ide-cd cdrom cs4232 ad1848 uart401 sound soundcore us
May 28 04:02:15 uffda kernel: CPU:    0
May 28 04:02:15 uffda kernel: EIP:    0010:[<c014a66c>]    Not tainted
May 28 04:02:15 uffda kernel: EFLAGS: 00010282
May 28 04:02:15 uffda kernel: 
May 28 04:02:15 uffda kernel: EIP is at prune_dcache [kernel] 0xac (2.4.18-4)
May 28 04:02:15 uffda kernel: eax: 0000001c   ebx: c9c52830   ecx: 00000001   edx: 0000180a
May 28 04:02:15 uffda kernel: esi: c9c52818   edi: c1387130   ebp: 00000048   esp: c1391f64
May 28 04:02:15 uffda kernel: ds: 0018   es: 0018   ss: 0018
May 28 04:02:15 uffda kernel: Process kswapd (pid: 5, stackpage=c1391000)
May 28 04:02:15 uffda kernel: Stack: c0229019 0000016a c1390000 00000000 00000000 ffffffff c02c4898 00000000 
May 28 04:02:15 uffda kernel:        00000000 000000c1 c01304d3 000001d0 000000c1 00000000 00000000 c014aa30 
May 28 04:02:16 uffda kernel:        00003c84 c0130c1c 00000006 000001d0 000001d0 c1390000 00000000 00000000 
May 28 04:02:16 uffda kernel: Call Trace: [<c01304d3>] page_launder [kernel] 0x2b3 
May 28 04:02:16 uffda kernel: [<c014aa30>] shrink_dcache_memory [kernel] 0x20 
May 28 04:02:16 uffda kernel: [<c0130c1c>] do_try_to_free_pages [kernel] 0x1c 
May 28 04:02:16 uffda kernel: [<c0130f11>] kswapd [kernel] 0x101 
May 28 04:02:16 uffda kernel: [<c0105000>] stext [kernel] 0x0 
May 28 04:02:16 uffda kernel: [<c0107136>] kernel_thread [kernel] 0x26 
May 28 04:02:16 uffda kernel: [<c0130e10>] kswapd [kernel] 0x0 
May 28 04:02:16 uffda kernel: 
May 28 04:02:16 uffda kernel: 
May 28 04:02:16 uffda kernel: Code: 0f 0b 5f 58 8d 4e 10 8b 51 04 8b 46 10 89 50 04 89 02 89 4e 
May 28 15:29:21 uffda syslogd 1.4.1: restart.
ENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDENDEND

-- 
Keith Thompson, San Diego Supercomputer Center, Camp X-Ray
kst@sdsc.edu  <http://www.sdsc.edu/~kst/>  858-822-0853  Fax: 858-822-5407
Schroedinger does Shakespeare: "To be *and* not to be"
