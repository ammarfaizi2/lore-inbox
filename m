Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSKAKlr>; Fri, 1 Nov 2002 05:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265684AbSKAKlr>; Fri, 1 Nov 2002 05:41:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27083 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265681AbSKAKlq>;
	Fri, 1 Nov 2002 05:41:46 -0500
Date: Fri, 01 Nov 2002 02:37:18 -0800 (PST)
Message-Id: <20021101.023718.64663422.davem@redhat.com>
To: jagana@us.ibm.com
Cc: yoshfuji@wide.ad.jp, kkumar@beaverton.ibm.com, kuznet@ms2.inr.ac.ru,
       ajtuomin@tml.hut.fi, lpetande@tml.hut.fi, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFFA13F15A.27343A7E-ON88256C64.00238392@boulder.ibm.com>
References: <OFFA13F15A.27343A7E-ON88256C64.00238392@boulder.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Venkata Jagana" <jagana@us.ibm.com>
   Date: Thu, 31 Oct 2002 22:51:13 -0800

   I believe even the registration part should belong to kernel and
   here are the reasons why.
   
   The Home Agent needs to ...

None of the things you've listed make it desirable to put the home
agent registration into the kernel.  All of the operations you
describe could be invoked by the userland home agent daemon using very
minimal glue logic in the kernel (invoked, for example, via netlink
messages).

(Hint: this glue logic could even be useful for other things)

Look, it is bad enough we have to put pfkey2 security database into
the kernel (and that most IKE daemons duplicate the whole database in
the user process as well), so let's not continue with such disasters.

Just like a router changes and monitors routes, a home agent daemon
would change and monitor mipv6 state.  So for the same reason we don't
put OSPF routing databases into the kernel, we do not put the home
agent registration into the kernel :-)
