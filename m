Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRCNLfZ>; Wed, 14 Mar 2001 06:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131332AbRCNLfQ>; Wed, 14 Mar 2001 06:35:16 -0500
Received: from sunny.pacific.net.au ([210.23.129.40]:26361 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S131317AbRCNLfF>; Wed, 14 Mar 2001 06:35:05 -0500
Date: Wed, 14 Mar 2001 22:34:22 +1100
From: David Luyer <david_luyer@pacific.net.au>
Message-Id: <200103141134.f2EBYMb19017@typhaon.pacific.net.au>
To: linux-kernel@vger.kernel.org
Subject: bug in 2.4.2-ac20 net/irda/af_irda.c or init/main.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As per my previous e-mail (on l-k), built-in irda causes an infinite loop
during bootup (ie, a lockup) by double-registering the same notifier.

This happens because irda_proto_init is both called by init/main.c and set as
a module_init() function which is then mapped to __initcall when built
non-modular.  So the notifier chain becomes looped as per the previous e-mail.

The fix is to remove one of these, for my system I'm moving the module_init
inside the #ifdef MODULE, someone else can choose what's best for the kernel
at large...

David.
