Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131834AbRCXV6r>; Sat, 24 Mar 2001 16:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131836AbRCXV6k>; Sat, 24 Mar 2001 16:58:40 -0500
Received: from [213.128.193.148] ([213.128.193.148]:23817 "EHLO
	dredd.crimea.edu") by vger.kernel.org with ESMTP id <S131834AbRCXV62>;
	Sat, 24 Mar 2001 16:58:28 -0500
Date: Sun, 25 Mar 2001 00:57:31 +0300
From: Oleg Drokin <green@dredd.crimea.edu>
To: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: IP layer bug?
Message-ID: <20010325005731.A5243@dredd.crimea.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   2.4.x kernel. have not tried 2.2
   I just found somethig, I believe is kernel bug.
   I am working with usbnet.c driver, which stores some of its
   internal state in sk_buff.cb area. But once such skb passed to
   upper layer with netif_rx, net/ipv4/ip_input.c reuses content of cb
   (line #345), and all packets that should go outside of beyond hosts
   we have direct routes to, fails, because we think, they have source routing
   enabled.
   For now I workarounded it with filling skb->cb with zeroes before
   netif_rx(), but I believe it is a kludge and networking layer should be fixed
   instead.

   Thank you.

Bye,
    Oleg
