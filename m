Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbSI3AlK>; Sun, 29 Sep 2002 20:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSI3AlK>; Sun, 29 Sep 2002 20:41:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16043 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261863AbSI3AlI>;
	Sun, 29 Sep 2002 20:41:08 -0400
Date: Sun, 29 Sep 2002 17:39:46 -0700 (PDT)
Message-Id: <20020929.173946.33239830.davem@redhat.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       dipankar@in.ibm.com, kuznet@ms2.inr.ac.ru
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Sun, 29 Sep 2002 19:52:17 +0200 (CEST)
   
   net_bh_lock: i have removed it, since it would synchronize to nothing. The
   old protocol handlers should still run on UP, and on SMP the kernel prints
   a warning upon use. Alexey, is this approach fine with you?

Just kill this crap completely.  Old protocol handlers are %100
unsupported in 2.6

I know people are working on fixing up basically every old protocol
layer currently in the tree, so this will not be an issue.

When a "struct packet_type" is registered in dev_add_pack(), fail if
!pt->data which is the indication of "old protocol".  Once all the
protocols are finished being fixed up, pt->data and this test can
die.

