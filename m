Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271089AbTGPTpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271092AbTGPTpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:45:03 -0400
Received: from AMarseille-107-1-15-86.w81-51.abo.wanadoo.fr ([81.51.74.86]:7296
	"EHLO diablo") by vger.kernel.org with ESMTP id S271089AbTGPToy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:44:54 -0400
Message-ID: <3F15AF87.3000500@free.fr>
Date: Wed, 16 Jul 2003 22:03:19 +0200
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re:[Oops report] (ppp/pppoatm) 2.6.0-test1
References: <3F157830.8030402@free.fr>
In-Reply-To: <3F157830.8030402@free.fr>
Content-Type: multipart/mixed;
 boundary="------------030306060904070600010003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306060904070600010003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

More information.
Replying to myself... this oops :

- doesn't occur up to 2.5.75-bk3 / 2.5.75-mm1
- also happens on 2.6.0-test1 :

-------------------------------------------------------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000026
  printing eip:
c027014b
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c027014b>]    Not tainted
EFLAGS: 00210206
EIP is at __vcc_connect+0x2b/0x230
eax: 0000000a   ebx: 00000000   ecx: 00000023   edx: c02e81bc
esi: ce30d200   edi: 00000000   ebp: 00000023   esp: c8297e60
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 1097, threadinfo=c8296000 task=c8883880)
Stack: 00000000 c0306a00 c8296000 00000000 cffcf1c0 ce30d200 c9106080
c0270407
        ce30d200 00000000 00000008 00000023 00200246 0008d200 c8296000
cffcf1c0
        c8297ee8 c9106080 c026d602 c9106080 00000000 00000008 00000023
ffffffb3
Call Trace:
  [<c0270407>] vcc_connect+0xb7/0x1f0
  [<c026d602>] pvc_bind+0xb2/0x150
  [<c0212a75>] sys_connect+0x85/0xc0
  [<c026d74f>] pvc_setsockopt+0x9f/0xf0
  [<c0212f28>] sys_setsockopt+0x78/0xc0
  [<c021360d>] sys_socketcall+0xcd/0x2a0
  [<c0109087>] syscall_call+0x7/0xb
-----------------------------------------------------------------------

I'm still trying to locate the exact changeset causing this bug... but 
so far, I'm shooting in the dark : perhaps someone knowlegeable can make 
a suggestion ?
I enclose the diffstat between the two kernel trees (2.5.75-bk3 -> 
2.6.0-test1) in case it may help...

Thank you for any help,

Vincent


I wrote:
> Hi,
> 
> I get the following oops when launching ppp on 2.6.0-test1-mm1 
> (2.5.75-mm1 was fine, I've not yet tested 2.6.0-test1 itself but can do 
> it if necessary). 100% reproductible.
> I'm using ppp with pppoatm and the kernel speedtouch driver, but 
> previous versions of 2.5 were working fine with the same configuration 
> so far, so probably a recent change is to blame...
 > [...]

--------------030306060904070600010003
Content-Type: text/plain;
 name="diffstat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diffstat"

 .config                           |    5 
 Documentation/CodingStyle         |    8 
 Makefile                          |    6 
 arch/alpha/Kconfig                |   11 
 arch/alpha/kernel/systbls.S       |    1 
 arch/i386/Makefile                |    3 
 arch/sparc/boot/Makefile          |    3 
 arch/sparc/defconfig              |   40 
 arch/sparc/kernel/Makefile        |    3 
 arch/sparc/kernel/pcic.c          |   23 
 arch/sparc/kernel/process.c       |   18 
 arch/sparc/kernel/sys_sparc.c     |    5 
 arch/sparc/mm/srmmu.c             |   10 
 arch/sparc64/Kconfig              |    7 
 arch/sparc64/kernel/entry.S       |   14 
 arch/sparc64/kernel/sys_sparc.c   |   51 
 arch/sparc64/kernel/sys_sparc32.c |   26 
 drivers/block/ll_rw_blk.c         |    2 
 drivers/char/agp/amd-k8-agp.c     |   82 -
 drivers/char/agp/frontend.c       |   62 -
 drivers/char/agp/hp-agp.c         |  250 ++--
 drivers/char/agp/sis-agp.c        |   56 
 drivers/pcmcia/bulkmem.c          |    6 
 drivers/pcmcia/cistpl.c           |    4 
 drivers/pcmcia/cs.c               |   98 -
 drivers/pcmcia/cs_internal.h      |    2 
 drivers/pcmcia/i82092.c           |    2 
 drivers/pcmcia/i82365.c           |    2 
 drivers/pcmcia/ricoh.h            |    2 
 drivers/pcmcia/rsrc_mgr.c         |    4 
 drivers/pcmcia/sa11xx_core.c      |    2 
 drivers/pcmcia/tcic.c             |    2 
 drivers/pcmcia/ti113x.h           |   29 
 drivers/pcmcia/yenta_socket.c     |    2 
 include/asm-alpha/timex.h         |    4 
 include/asm-alpha/unistd.h        |    3 
 include/asm-sparc/ipc.h           |    1 
 include/asm-sparc/pgtsrmmu.h      |    3 
 include/asm-sparc64/ipc.h         |    1 
 include/asm-sparc64/ptrace.h      |    2 
 include/asm-sparc64/thread_info.h |    8 
 include/net/ip6_route.h           |    6 
 include/net/ip_vs.h               | 1002 +++++++++++++++++
 include/pcmcia/ss.h               |    4 
 kernel/sys.c                      |    2 
 kernel/sysctl.c                   |   16 
 net/compat.c                      |   31 
 net/core/net-sysfs.c              |    2 
 net/ipv4/Kconfig                  |    1 
 net/ipv4/Makefile                 |    1 
 net/ipv4/ipvs/Kconfig             |  257 ++++
 net/ipv4/ipvs/Makefile            |   40 
 net/ipv4/ipvs/ip_vs_app.c         |  588 ++++++++++
 net/ipv4/ipvs/ip_vs_conn.c        |  869 ++++++++++++++
 net/ipv4/ipvs/ip_vs_core.c        | 1166 ++++++++++++++++++++
 net/ipv4/ipvs/ip_vs_ctl.c         | 2205 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/ipvs/ip_vs_dh.c          |  261 ++++
 net/ipv4/ipvs/ip_vs_est.c         |  197 +++
 net/ipv4/ipvs/ip_vs_ftp.c         |  383 ++++++
 net/ipv4/ipvs/ip_vs_lblc.c        |  629 ++++++++++
 net/ipv4/ipvs/ip_vs_lblcr.c       |  895 +++++++++++++++
 net/ipv4/ipvs/ip_vs_lc.c          |  144 ++
 net/ipv4/ipvs/ip_vs_nq.c          |  181 +++
 net/ipv4/ipvs/ip_vs_proto.c       |  231 +++
 net/ipv4/ipvs/ip_vs_proto_ah.c    |  181 +++
 net/ipv4/ipvs/ip_vs_proto_esp.c   |  180 +++
 net/ipv4/ipvs/ip_vs_proto_icmp.c  |  171 ++
 net/ipv4/ipvs/ip_vs_proto_tcp.c   |  611 ++++++++++
 net/ipv4/ipvs/ip_vs_proto_udp.c   |  396 ++++++
 net/ipv4/ipvs/ip_vs_rr.c          |  122 ++
 net/ipv4/ipvs/ip_vs_sched.c       |  261 ++++
 net/ipv4/ipvs/ip_vs_sed.c         |  171 ++
 net/ipv4/ipvs/ip_vs_sh.c          |  258 ++++
 net/ipv4/ipvs/ip_vs_sync.c        |  909 +++++++++++++++
 net/ipv4/ipvs/ip_vs_wlc.c         |  159 ++
 net/ipv4/ipvs/ip_vs_wrr.c         |  251 ++++
 net/ipv4/ipvs/ip_vs_xmit.c        |  635 ++++++++++
 net/ipv4/netfilter/ip_fw_compat.c |   14 
 net/ipv6/ip6_fib.c                |    7 
 net/ipv6/ndisc.c                  |   54 
 net/ipv6/route.c                  |   67 -
 net/netlink/af_netlink.c          |    4 
 net/netsyms.c                     |    1 
 net/xfrm/xfrm_policy.c            |    1 
 84 files changed, 13983 insertions(+), 444 deletions(-)

--------------030306060904070600010003--

