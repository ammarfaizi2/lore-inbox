Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbTDKKV5 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 06:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264216AbTDKKV5 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 06:21:57 -0400
Received: from web20104.mail.yahoo.com ([216.136.226.41]:9090 "HELO
	web20104.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263621AbTDKKVv (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 06:21:51 -0400
Message-ID: <20030411103334.10825.qmail@web20104.mail.yahoo.com>
Date: Fri, 11 Apr 2003 03:33:34 -0700 (PDT)
From: Alisha Nigam <mail_to_alisha@yahoo.com>
Subject: module installation in TCP/IP stack error.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
       i was trying to write a simple kernel module
to print the destination address of all the packets
comming to my machine.

       i was able to compile my module but with a lots
of gcc warnings.But while trying to install module 
its giving ERROR. 

-------------------------------------------------------
   MY PROG :
-------------------------------------------------------

#include<linux/module.h>
#include <linux/config.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/mm.h>
#include <linux/interrupt.h>
#include <linux/in.h>
#include <linux/inet.h>
#include <linux/slab.h>
#include <linux/netdevice.h>
#include <linux/string.h>
#include <linux/skbuff.h>
#include <linux/cache.h>
#include <linux/rtnetlink.h>
#include <linux/init.h>
#include <linux/highmem.h>

#include <net/protocol.h>
#include <net/dst.h>
#include <net/sock.h>
#include <net/checksum.h>

#include <asm/uaccess.h>
#include <asm/system.h>

int init_module(struct sk_buff *skb)
{  printk(" packet addr: %s.\n",skb->nh.iph->daddr);
	 kfree_skb(skb);
            return 0;
}
void cleanup_module(void)
   { printk(" <1> Module is removed succesfully\n");
  }


-------------------------------------------------------
O/P of insmod mymodule.o
-------------------------------------------------------

<1>Unable to handle kernel paging request at virtual
address f00b7458
 printing eip:
c489f06d
*pde = 00000000
Oops: 0000
mymodule autofs via-rhine mii ipt_REJECT
iptable_filter ip_
CPU:    0
EIP:    0010:[<c489f06d>]    Tainted: P 
EFLAGS: 00010292

EIP is at init_module [mymodule] 0xd (2.4.18-14)
eax: f00b7448   ebx: c489f060   ecx: c0305480   edx:
c0305488
esi: 00000000   edi: 00000000   ebp: c166ff18   esp:
c166ff08
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 1436, stackpage=c166f000)
Stack: 0000104f ffffffea 00000000 ffffffea c489f000
c011bf79 c489f060 08074538 
       000002f4 00000000 080745dc 00000104 00000060
00000060 00000005 c2d084c0 
       c1b7f000 c309e000 00000060 c489d000 c489f060
00000354 00000000 00000000 
Call Trace: [<c011bf79>] sys_init_module [kernel]
0x4d9 (0xc166ff1c))
[<c489f060>] init_module [mymodule] 0x0 (0xc166ff20))
[<c489f060>] init_module [mymodule] 0x0 (0xc166ff58))
[<c010910f>] system_call [mymodule] 0x33 (0xc166ffc0))


Code: ff 70 10 68 b6 f0 89 c4 e8 66 bf 87 fb 8b 43 70
83 c4 10 48 
segmentation fault. 


  NOW WHAT TO DO ?????????????????


              Alisha Nigam


------------------------------------------------------
  O/P of gcc : (  WARNING messages  )
-----------------------------------------------------

In file included from
/lib/modules/2.4.18-14/build/include/linux/prefetch.h:13,
                 from
/lib/modules/2.4.18-14/build/include/linux/list.h:6,
                 from
/lib/modules/2.4.18-14/build/include/linux/module.h:12,
                 from p10.c:3:
/lib/modules/2.4.18-14/build/include/asm/processor.h:490:
warning: no previous prototype for `prefetch'
In file included from
/lib/modules/2.4.18-14/build/include/asm/system.h:8,
                 from
/lib/modules/2.4.18-14/build/include/asm/semaphore.h:39,
                 from
/lib/modules/2.4.18-14/build/include/linux/fs.h:200,
                 from
/lib/modules/2.4.18-14/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.18-14/build/include/linux/binfmts.h:5,
                 from
/lib/modules/2.4.18-14/build/include/linux/sched.h:9,
                 from p10.c:7:
/lib/modules/2.4.18-14/build/include/linux/bitops.h:45:
warning: no previous prototype for `generic_fls'
/lib/modules/2.4.18-14/build/include/linux/bitops.h:74:
warning: no previous prototype for `get_bitmask_order'
In file included from
/lib/modules/2.4.18-14/build/include/linux/fs.h:201,
                 from
/lib/modules/2.4.18-14/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.18-14/build/include/linux/binfmts.h:5,
                 from
/lib/modules/2.4.18-14/build/include/linux/sched.h:9,
                 from p10.c:7:
/lib/modules/2.4.18-14/build/include/asm/byteorder.h:14:
warning: type qualifiers ignored on function return
type
/lib/modules/2.4.18-14/build/include/asm/byteorder.h:28:
warning: type qualifiers ignored on function return
type
In file included from
/lib/modules/2.4.18-14/build/include/linux/byteorder/little_endian.h:11,
                 from
/lib/modules/2.4.18-14/build/include/asm/byteorder.h:45,
                 from
/lib/modules/2.4.18-14/build/include/linux/fs.h:201,
                 from
/lib/modules/2.4.18-14/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.18-14/build/include/linux/binfmts.h:5,
                 from
/lib/modules/2.4.18-14/build/include/linux/sched.h:9,
                 from p10.c:7:
/lib/modules/2.4.18-14/build/include/linux/byteorder/swab.h:132:
warning: type qualifiers ignored on function return
type
/lib/modules/2.4.18-14/build/include/linux/byteorder/swab.h:145:
warning: type qualifiers ignored on function return
type
/lib/modules/2.4.18-14/build/include/linux/byteorder/swab.h:159:
warning: type qualifiers ignored on function return
type
In file included from
/lib/modules/2.4.18-14/build/include/linux/fs.h:375,
                 from
/lib/modules/2.4.18-14/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.18-14/build/include/linux/binfmts.h:5,
                 from
/lib/modules/2.4.18-14/build/include/linux/sched.h:9,
                 from p10.c:7:
/lib/modules/2.4.18-14/build/include/linux/quota.h:176:
warning: no previous prototype for `mark_info_dirty'
In file included from
/lib/modules/2.4.18-14/build/include/linux/sched.h:26,
                 from p10.c:7:
/lib/modules/2.4.18-14/build/include/linux/signal.h:
In function `sigorsets':
/lib/modules/2.4.18-14/build/include/linux/signal.h:108:
warning: comparison of unsigned expression < 0 is
always false
/lib/modules/2.4.18-14/build/include/linux/signal.h:
In function `sigandsets':
/lib/modules/2.4.18-14/build/include/linux/signal.h:111:
warning: comparison of unsigned expression < 0 is
always false
/lib/modules/2.4.18-14/build/include/linux/signal.h:
In function `signandsets':
/lib/modules/2.4.18-14/build/include/linux/signal.h:114:
warning: comparison of unsigned expression < 0 is
always false
/lib/modules/2.4.18-14/build/include/linux/signal.h:
In function `signotset':
/lib/modules/2.4.18-14/build/include/linux/signal.h:140:
warning: comparison of unsigned expression < 0 is
always false
In file included from
/lib/modules/2.4.18-14/build/include/linux/netdevice.h:147,
                 from p10.c:13:
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:
In function `__pskb_pull':
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:855:
warning: comparison between signed and unsigned
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:
In function `pskb_may_pull':
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:871:
warning: comparison between signed and unsigned
p10.c: At top level:
p10.c:30: warning: no previous prototype for
`init_module'
p10.c: In function `init_module':
p10.c:30: warning: format argument is not a pointer
(arg 2)
p10.c:30: warning: format argument is not a pointer
(arg 2)
p10.c: At top level:
p10.c:35: warning: no previous prototype for
`cleanup_module'
/lib/modules/2.4.18-14/build/include/linux/prefetch.h:
In function `prefetchw':
/lib/modules/2.4.18-14/build/include/linux/prefetch.h:48:
warning: unused parameter `x'
/lib/modules/2.4.18-14/build/include/linux/wait.h: In
function `__remove_wait_queue':
/lib/modules/2.4.18-14/build/include/linux/wait.h:225:
warning: unused parameter `head'
/lib/modules/2.4.18-14/build/include/linux/pm.h: In
function `pm_access':
/lib/modules/2.4.18-14/build/include/linux/pm.h:150:
warning: unused parameter `dev'
/lib/modules/2.4.18-14/build/include/linux/pm.h: In
function `pm_dev_idle':
/lib/modules/2.4.18-14/build/include/linux/pm.h:151:
warning: unused parameter `dev'
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:
In function `pgd_none':
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:32:
warning: unused parameter `pgd'
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:
In function `pgd_bad':
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:33:
warning: unused parameter `pgd'
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:
In function `pgd_present':
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:34:
warning: unused parameter `pgd'
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:
In function `pmd_offset':
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:55:
warning: unused parameter `address'
/lib/modules/2.4.18-14/build/include/linux/mm.h: In
function `arch_validate':
/lib/modules/2.4.18-14/build/include/linux/mm.h:491:
warning: unused parameter `gfp_mask'
/lib/modules/2.4.18-14/build/include/linux/mm.h:491:
warning: unused parameter `order'
/lib/modules/2.4.18-14/build/include/asm/hw_irq.h: In
function `hw_resend_irq':
/lib/modules/2.4.18-14/build/include/asm/hw_irq.h:217:
warning: unused parameter `h'
/lib/modules/2.4.18-14/build/include/asm/hardirq.h: In
function `irq_enter':
/lib/modules/2.4.18-14/build/include/asm/hardirq.h:71:
warning: unused parameter `irq'
/lib/modules/2.4.18-14/build/include/asm/hardirq.h: In
function `irq_exit':
/lib/modules/2.4.18-14/build/include/asm/hardirq.h:80:
warning: unused parameter `irq'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h: In
function `pte_alloc_one':
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:107:
warning: unused parameter `mm'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:107:
warning: unused parameter `address'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h: In
function `pte_alloc_one_fast':
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:122:
warning: unused parameter `mm'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:123:
warning: unused parameter `address'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h: In
function `flush_tlb_range':
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:220:
warning: unused parameter `start'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:220:
warning: unused parameter `end'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h: In
function `flush_tlb_pgtables':
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:238:
warning: unused parameter `start'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:238:
warning: unused parameter `end'
/lib/modules/2.4.18-14/build/include/linux/highmem.h:
In function `clear_user_highpage':
/lib/modules/2.4.18-14/build/include/linux/highmem.h:83:
warning: unused parameter `vaddr'
/lib/modules/2.4.18-14/build/include/linux/highmem.h:
In function `copy_user_highpage':
/lib/modules/2.4.18-14/build/include/linux/highmem.h:112:
warning: unused parameter `vaddr'
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:
In function `kunmap_skb_frag':
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:1104:
warning: unused parameter `vaddr'
/lib/modules/2.4.18-14/build/include/linux/netdevice.h:
In function `dev_init_buffers':
/lib/modules/2.4.18-14/build/include/linux/netdevice.h:615:
warning: unused parameter `dev'
/lib/modules/2.4.18-14/build/include/net/ip.h: In
function `ip_tr_mc_map':
/lib/modules/2.4.18-14/build/include/net/ip.h:118:
warning: unused parameter `addr'
/lib/modules/2.4.18-14/build/include/asm/uaccess.h: In
function `verify_area':
/lib/modules/2.4.18-14/build/include/asm/uaccess.h:62:
warning: unused parameter `type'





__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
