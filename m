Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSJVUz7>; Tue, 22 Oct 2002 16:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264900AbSJVUz7>; Tue, 22 Oct 2002 16:55:59 -0400
Received: from user19.okena.com ([65.196.32.19]:2987 "EHLO
	gatemaster.okena.com") by vger.kernel.org with ESMTP
	id <S261683AbSJVUz6>; Tue, 22 Oct 2002 16:55:58 -0400
From: Slavcho Nikolov <snikolov@okena.com>
To: linux-kernel@vger.kernel.org
Message-ID: <00b201c27a0e$3f82c220$800a140a@SLNW2K>
Subject: feature request - why not make netif_rx() a pointer?
Date: Tue, 22 Oct 2002 17:01:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Non GPL modules that want to attach themselves between all L2 drivers and
upper layers would not have to incur a performance loss if netif_rx() is
made a
pointer instead of a function (whether or not NET filters are compiled in
the kernel).
Currently control can be easily wrested from netif_rx() and others through
injection of a few instructions into the running kernel (SMC - self
modifying code)
but decreased performance is one sad consequence. Architecture specific
maintenance of SMC slows down portability, too.
The following suggestion would lead to the least amount of modifications.

The global variable "int (*netif_rx)(struct sk_buff *) = &default_netif_rx;"
gets initialized to the address of a function whose body is the default
implementation.
Drivers calling netif_rx explicitly need to be able to see the prototype
"extern int (*netif_rx)(struct sk_buff *);" or else blow up.
No further changes would be necessary because the current 200+ explicit
references
to "netif_rx(skb);"  become a poorly written "(*netif_rx)(skb);" call.
S.N.
