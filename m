Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYOSD>; Thu, 25 Jan 2001 09:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRAYORn>; Thu, 25 Jan 2001 09:17:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15239 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129051AbRAYORb>;
	Thu, 25 Jan 2001 09:17:31 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.13645.936452.235135@pizda.ninka.net>
Date: Thu, 25 Jan 2001 06:16:45 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: [UPDATE] Zerocopy, last one today I promise :-)
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's pretty fast, but due to a critical bug fix, there's a new
one going up:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.1p10-3.diff.gz

o If sock_writepage is called on path via device without SG support,
  the cooked up sock_sendmsg() call needs to switch to KERNEL_DS.
  Discovered and fixed by Ingo Molnar.

This does show that not too many people are testing this all that
thoroughly :-) Basically, any sys_sendfile() over TCP using a network
card other than loopback/3c59x/sunhme/acenic would fail with -EFAULT
or even worse a kernel crash depending upon architecture.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
