Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318968AbSHMRoX>; Tue, 13 Aug 2002 13:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318974AbSHMRoX>; Tue, 13 Aug 2002 13:44:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1193 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318968AbSHMRoV>;
	Tue, 13 Aug 2002 13:44:21 -0400
Date: Tue, 13 Aug 2002 10:34:28 -0700 (PDT)
Message-Id: <20020813.103428.76618477.davem@redhat.com>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/21] reduced locking in buffer.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208131032210.7411-100000@home.transmeta.com>
References: <3D561473.40A53C0D@zip.com.au>
	<Pine.LNX.4.44.0208131032210.7411-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 13 Aug 2002 10:34:37 -0700 (PDT)

   On Sun, 11 Aug 2002, Andrew Morton wrote:
   > Resend.  Replace the buffer lru spinlock protection with
   > local_irq_disable and a cross-CPU call to invalidate them.
   
   This almost certainly breaks on sparc, where CPU cross-calls are 
   non-maskable, so local_irq_disable doesn't do anything for them.
   
   Talk to Davem about this - there may be some workaround.

I told him it's OK in 2.5.x as I've discovered a way to implement
sparc32 (once we have it working again) such that local_irq_disable
blocks cross calls.
