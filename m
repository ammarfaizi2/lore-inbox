Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267970AbTBSELT>; Tue, 18 Feb 2003 23:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbTBSELT>; Tue, 18 Feb 2003 23:11:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14781 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267970AbTBSELS>;
	Tue, 18 Feb 2003 23:11:18 -0500
Date: Tue, 18 Feb 2003 20:03:53 -0800 (PST)
Message-Id: <20030218.200353.133754841.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: sendmsg and IP_PKTINFO
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15955.1148.929905.130326@notabene.cse.unsw.edu.au>
References: <15954.4693.893707.471216@notabene.cse.unsw.edu.au>
	<20030218.195205.85404023.davem@redhat.com>
	<15955.1148.929905.130326@notabene.cse.unsw.edu.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Wed, 19 Feb 2003 15:13:48 +1100

   On Tuesday February 18, davem@redhat.com wrote:
   > Alexey and myself totally disagree.  We have described for you
   > the intended purpose of this feature.  Please do not try to use
   > it in some other way, it may prove to be painful :-)
   
   Thankyou for making that clear.
   
You're very welcome, thank you for tracking all of this down.
   
   Currently the sunrpc/svc_udp.c code asks for an IP_PKTINFO from
   recvmsg, and passes it verbatim down through sendmsg.

And yes, this is buggy.

   My patch checks that the returned data looks believable and, if it
   does, zeros the ipi_ifindex field.

Please note also that ipi_addr is ignored on sendmsg().

You don't have to zero it, this is just a reminder about
what the kernel will do with this thing.
