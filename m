Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSIIHWA>; Mon, 9 Sep 2002 03:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSIIHWA>; Mon, 9 Sep 2002 03:22:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38300 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316578AbSIIHV7>;
	Mon, 9 Sep 2002 03:21:59 -0400
Date: Mon, 09 Sep 2002 00:19:02 -0700 (PDT)
Message-Id: <20020909.001902.28439948.davem@redhat.com>
To: taka@valinux.co.jp
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS for 2.5.33
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020909.161123.74745039.taka@valinux.co.jp>
References: <20020909.161123.74745039.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Mon, 09 Sep 2002 16:11:23 +0900 (JST)

   Using TSO code is commented out at this moment as TSO for UDP isn't
   implemented yet. I'm waiting for it so that we would remove "#ifdef NotYet"
   to send jumbo UDP frames without any fragmentation and any checksumming.
   Then I hope we will get great performance.
   
Actually, device interface for what could be used is there, see
NETIF_F_FRAGLIST.  No devices set this and IP never makes use of it
yet though :-)

Acenic and Tigon3 will be able to do this, probably e1000 has this
feature as well.

But it does not work how you imagine.  One passes already fragmented
list of packets to card, and it can checksum the packet if you tell it
which descriptor is first of fragmented frame and which is last.

It does not do the fragmentation of UDP frames for you, only
checksumming of UDP portion.  No card does what you mention.

Franks a lot,
David S. Miller
davem@redhat.com
