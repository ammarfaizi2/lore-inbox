Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRC0Tmk>; Tue, 27 Mar 2001 14:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbRC0Tmb>; Tue, 27 Mar 2001 14:42:31 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:17163 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S131508AbRC0TmZ>; Tue, 27 Mar 2001 14:42:25 -0500
Message-ID: <3AC0ED60.639FD21F@nbase.co.il>
Date: Tue, 27 Mar 2001 21:43:28 +0200
From: eran@nbase.co.il (Eran Man)
X-Mailer: Mozilla 4.74 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert-Velisav MICIOVICI <roby@dexter.allieddomecq.ro>
CC: linux-kernel@vger.kernel.org
Subject: [patch] Re: 2.4.3-pre8: IPX not building
In-Reply-To: <Pine.LNX.4.21md.0103271844240.5513-100000@dexter.allieddomecq.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchlet solves it:
========================================================================
--- linux-2.4.3pre8.orig/net/ipx/af_ipx.c       Mon Mar 26 13:17:08 2001
+++ linux/net/ipx/af_ipx.c      Mon Mar 26 13:14:52 2001
@@ -1542,7 +1542,7 @@
        ipx_offset = intrfc->if_ipx_offset;
        size = sizeof(struct ipxhdr) + len + ipx_offset;

-       skb = sock_alloc_send_skb(sk, size, noblock, &err);
+       skb = sock_alloc_send_skb(sk, size, 0, noblock, &err);
        if (!skb)
                goto out_put;

@@ -2531,7 +2531,6 @@
        sendmsg:        ipx_sendmsg,
        recvmsg:        ipx_recvmsg,
        mmap:           sock_no_mmap,
-       sendpage:       sock_no_sendpage,
 };

 #include <linux/smp_lock.h>
========================================================================

Robert-Velisav MICIOVICI wrote:
> 
> Hi,
> 
> Just a build problem report.
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-pre8/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer
> -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
> -march=athlon  -DMODULE -DMODVERSIONS -include
> /usr/src/linux-2.4.3-pre8/include/linux/modversions.h   -c -o
> ip6table_mangle.o ip6table_mangle.c
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-pre8/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer
> -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
> -march=athlon  -DMODULE -DMODVERSIONS -include
> /usr/src/linux-2.4.3-pre8/include/linux/modversions.h   -c -o
> ip6t_MARK.o ip6t_MARK.c
> make[2]: Leaving directory /usr/src/linux-2.4.3-pre8/net/ipv6/netfilter'
> make -C ipx modules
> make[2]: Entering directory /usr/src/linux-2.4.3-pre8/net/ipx'
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-pre8/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer
> -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
> -march=athlon  -DMODULE -DMODVERSIONS -include
> /usr/src/linux-2.4.3-pre8/include/linux/modversions.h   -DEXPORT_SYMTAB
> -c af_ipx.c
> af_ipx.c: In function   pxrtr_route_packet':
> af_ipx.c:1545: warning: passing arg 4 of `sock_alloc_send_skb_R7094cf19'
> makes integer from pointer without a cast
> af_ipx.c:1545: too few arguments to function
> `sock_alloc_send_skb_R7094cf19'
> af_ipx.c: At top level:
> af_ipx.c:2534: unknown field `sendpage' specified in initializer
> af_ipx.c:2534: `sock_no_sendpage' undeclared here (not in a function)
> af_ipx.c:2534: warning: excess elements in struct initializer
> af_ipx.c:2534: warning: (near initialization for        px_dgram_ops')
> make[2]: *** [af_ipx.o] Error 1
> make[2]: Leaving directory /usr/src/linux-2.4.3-pre8/net/ipx'
> make[1]: *** [_modsubdir_ipx] Error 2
> make[1]: Leaving directory /usr/src/linux-2.4.3-pre8/net'
> make: *** [_mod_net] Error 2
> [root@bigfoot linux-2.4.3-pre8]#
> 
> Best regards to you kernel-wizzards!
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
