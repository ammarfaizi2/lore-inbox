Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131128AbQKZVdg>; Sun, 26 Nov 2000 16:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131399AbQKZVd0>; Sun, 26 Nov 2000 16:33:26 -0500
Received: from trgras.timpanogas.org ([207.109.151.236]:4 "EHLO
        trgras.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131128AbQKZVdF>; Sun, 26 Nov 2000 16:33:05 -0500
Date: Sun, 26 Nov 2000 13:57:17 -0700
From: root <root@trgras.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Oops on 2.2.18-21(23) with pppd dial-in 
Message-ID: <20001126135717.A869@trgras.timpanogas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii



I had backreved this system to 2.2.18-21 but I can reproduce this Oops on
both 2.2.18-21 and 2.2.18-23.  I am providing the Oops information from 
kernel 2.2.18-21 since this is what was running on the system at the time
the pppd dial in server crashed.  

The server crashes after several dial clients who are routing both
IPX and IP attach and disconnect several times, then you attempt 
to telnet or ssh into the box over the ethernet link.  The oops 
is actually occurring when a telnet session is attempted after 
someone disconnects from a pppd session.  

This Oops was created against the System.map file for a 2.2.18-21 
build.  This bug takes about two days to reproduce, and also 
requires that the local gateway system be misconfigured to point
a non-existent network route to the target machine.  It's very 
difficult to reproduce, but is very annoying.

Jeff
  


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 0.7c on i686 2.2.18pre21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18pre21/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
unable to handle kernel paing request virtual address 90c16C24
Oops: 0002
CPU:  0
EIP:  0010:[<c0137596>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax:  90c16c20  ebx:  c16c6145  ecx: 00000000 edx: c0226e2c 
esi:  c0259200  edi:  c16c614d  ebp: c0259200 esp: c17f9ee8
ds: 18  es: 18  ss: 18
Call Trace: [<c01377fe>] [<c0137816>] [<c0144bbc>] [<c0131238>] [<c0131434>] [<c013151c>] [<c012f532>] [<c010a2fc>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0137596 <aout_core_dump+be/2bc>   <=====
Trace; c01377fe <create_aout_tables+6a/108>
Trace; c0137816 <create_aout_tables+82/108>
Trace; c0144bbc <proc_file_read+174/1d4>
Trace; c0131238 <fifo_open+14c/2f0>
Trace; c0131434 <init_fifo+58/64>
Trace; c013151c <locks_wake_up_blocks+1c/60>
Trace; c012f532 <sys_dup2+1a/29c>
Trace; c010a2fc <sys_vm86+110/114>


3 warnings issued.  Results may not be reliable.

--h31gzZEtNLTqOjlF--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
