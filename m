Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263224AbREWTTR>; Wed, 23 May 2001 15:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263226AbREWTTI>; Wed, 23 May 2001 15:19:08 -0400
Received: from imr1.ericy.com ([208.237.135.240]:42232 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S263224AbREWTSw>;
	Wed, 23 May 2001 15:18:52 -0400
From: "David Gordon (LMC)" <David.Gordon@ericsson.ca>
To: linux-kernel@vger.kernel.org
Cc: "Ibrahim Haddad (LMC)" <Ibrahim.Haddad@lmc.ericsson.se>
Message-ID: <3B0C0D0B.2010101@lmc.ericsson.se>
Date: Wed, 23 May 2001 15:18:35 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
Subject: IPv6 implementation in kernel 2.4.4 oopses
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can I be cc'ed at lmcdgor@lmc.ericsson.se (as per a normal reply) ? 
Thank you.

Included at the end is the ksymoops output after the crash (one of them 
anyhow :-)

My setup involves 2 PII installed with Linux RedHat 7.0 and 2.4.4 kernel 
with IPv6 enabled:
CONFIG_EXPERIMENTAL=y
CONFIG_IPV6=y
CONFIG_IPV6_EUI64=y
CONFIG_IPV6_NO_PB=y

Also, the following application web servers were installed (enabled for 
IPv6) :
Jigsaw 2.2.0
Tomcat 3.2.1
Apache 1.3.19

To enable IPv6 with the Java based web servers, I used jipsy 0.2.1. 
Lastly, netkit 0.5.1 was installed containing in particular ping6 utility.

To reproduce the crash, I ping6'ed one machine from the other in 
command-line mode, no servers running. That's it. Originally, the first 
crash occurred in a X server environment while querying the web servers 
in IPv6.

Thank you,

David Gordon
Ericsson Research



Here's the output:
**************

ksymoops 2.3.4 on i686 2.4.4.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.4/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid 
lsmod file?
Warning (compare_maps): ksyms_base symbol 
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring 
ksyms_base entry
c0237bc4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0237bc4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c157c040   ebx: fffffffd   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000018   ebp: c15ac800   esp: c02f1e84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02f100)
Stack: c023f913 00000000 00000000 c157c040 cfb8ebd4 c022fc6b cfcab780 
00000000
        c020ce8d cfcab780 010000e0 7d4985ce cfcab780 fffffffd ccf90d84 
00000000
        c15ac800 c023fe74 c15ac800 ccf90d20 ccf90d84 ccf90d84 00000000 
c15ac800
Call Trace: [<c023f913>] [<c022fc6b>] [<c020ce8d>] [<c023fe74>] 
[<c020e986>] [<c023fdc0>] [<c02088a0>]
        [<c011ac90>] [<c0208710>] [<c011afb6>] [<c0117dfc>] [<c0117cb5>] 
[<c0117b2d>] [<c0108a07>] [<c01051a0>]
        [<c0106ef8>] [<c01051a0>] [<c0100018>] [<c01051cc>] [<c0105252>] 
[<c0105000>] [<c01001cf>]
Code: 8b 11 f7 c2 e0 00 00 00 74 14 89 d0 25 e0 00 00 00 3d e0 00

 >>EIP; c0237bc4 <ipv6_addr_type+4/e0>   <=====
Trace; c023f913 <ndisc_send_ns+33/250>
Trace; c022fc6b <igmp_rcv+15b/170>
Trace; c020ce8d <ip_route_input+11d/190>
Trace; c023fe74 <ndisc_solicit+b4/c0>
Trace; c020e986 <ip_rcv+2f6/380>
Trace; c023fdc0 <ndisc_solicit+0/c0>
Trace; c02088a0 <neigh_timer_handler+190/1d0>
Trace; c011ac90 <update_process_times+20/a0>
Trace; c0208710 <neigh_timer_handler+0/1d0>
Trace; c011afb6 <timer_bh+256/2b0>
Trace; c0117dfc <bh_action+4c/b0>
Trace; c0117cb5 <tasklet_hi_action+55/90>
Trace; c0117b2d <do_softirq+6d/a0>
Trace; c0108a07 <do_IRQ+e7/100>
Trace; c01051a0 <default_idle+0/40>
Trace; c0106ef8 <ret_from_intr+0/20>
Trace; c01051a0 <default_idle+0/40>
Trace; c0100018 <startup_32+18/cb>
Trace; c01051cc <default_idle+2c/40>
Trace; c0105252 <cpu_idle+52/70>
Trace; c0105000 <init+0/180>
Trace; c01001cf <L6+0/2>
Code;  c0237bc4 <ipv6_addr_type+4/e0>
00000000 <_EIP>:
Code;  c0237bc4 <ipv6_addr_type+4/e0>   <=====
    0:   8b 11                     mov    (%ecx),%edx   <=====
Code;  c0237bc6 <ipv6_addr_type+6/e0>
    2:   f7 c2 e0 00 00 00         test   $0xe0,%edx
Code;  c0237bcc <ipv6_addr_type+c/e0>
    8:   74 14                     je     1e <_EIP+0x1e> c0237be2 
<ipv6_addr_type+22/e0>
Code;  c0237bce <ipv6_addr_type+e/e0>
    a:   89 d0                     mov    %edx,%eax
Code;  c0237bd0 <ipv6_addr_type+10/e0>
    c:   25 e0 00 00 00            and    $0xe0,%eax
Code;  c0237bd5 <ipv6_addr_type+15/e0>
   11:   3d e0 00 00 00            cmp    $0xe0,%eax

Kernel panic: Aiee, killing interrupt handler!

3 warnings issued.  Results may not be reliable.
***********************

End email message
