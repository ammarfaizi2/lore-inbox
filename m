Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSI3AVs>; Sun, 29 Sep 2002 20:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSI3AVs>; Sun, 29 Sep 2002 20:21:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1707 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261854AbSI3AVr>;
	Sun, 29 Sep 2002 20:21:47 -0400
Date: Sun, 29 Sep 2002 17:20:22 -0700 (PDT)
Message-Id: <20020929.172022.23984844.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       wli@holomorphy.com, kuznet@ms2.inr.ac.ru
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020930004559.A19071@in.ibm.com>
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
	<20020930004559.A19071@in.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Mon, 30 Sep 2002 00:45:59 +0530

   > net_bh_lock: i have removed it, since it would synchronize to nothing. The
   > old protocol handlers should still run on UP, and on SMP the kernel prints
   > a warning upon use. Alexey, is this approach fine with you?
   
   The cache line bouncing of global_bh_lock and net_bh_lock in
   run_timer_tasklet() show up in our profiles, so getting rid of
   them is a good thing (TM).
   
What ancient protocols are you running that make use of this?

IPv4 and IPv6 both do not use it at all.  Even IPX, Appletalk, and
DecNET layers do not use it
