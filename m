Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRAaABN>; Tue, 30 Jan 2001 19:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbRAaABD>; Tue, 30 Jan 2001 19:01:03 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:24060 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S129184AbRAaAAu>;
	Tue, 30 Jan 2001 19:00:50 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Reuben Farrelly <reuben@reub.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        netfilter@us5.samba.org
Subject: Re: Unresolved symbols 
In-Reply-To: Your message of "Fri, 26 Jan 2001 01:14:09 +1100."
             <5.0.2.1.2.20010126010507.00af5128@mail.reub.net> 
Date: Wed, 31 Jan 2001 11:00:07 +1100
Message-Id: <E14Nkgz-0006Oy-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.0.2.1.2.20010126010507.00af5128@mail.reub.net> you write:
> Hi again Rusty

God I'm an idiot.  I swear I've fixed this before.  <<search>>.  Yep,
I did.  And before that, the same bug in the conntrack code.

This fixed the `core nat compiled in, rest as modules' case, of
course, by actually exporting the symbols.

Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ -X /tmp/kerndiff.GyILWe --minimal linux-2.4.0-official/net/ipv4/netfilter/ip_nat_standalone.c working-2.4.0/net/ipv4/netfilter/ip_nat_standalone.c
--- linux-2.4.0-official/net/ipv4/netfilter/ip_nat_standalone.c	Tue Oct 31 09:27:49 2000
+++ working-2.4.0/net/ipv4/netfilter/ip_nat_standalone.c	Wed Jan 31 10:50:50 2001
@@ -330,11 +330,9 @@
 module_init(init);
 module_exit(fini);
 
-#ifdef MODULE
 EXPORT_SYMBOL(ip_nat_setup_info);
 EXPORT_SYMBOL(ip_nat_helper_register);
 EXPORT_SYMBOL(ip_nat_helper_unregister);
 EXPORT_SYMBOL(ip_nat_expect_register);
 EXPORT_SYMBOL(ip_nat_expect_unregister);
 EXPORT_SYMBOL(ip_nat_cheat_check);
-#endif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
