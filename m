Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317712AbSG2DvE>; Sun, 28 Jul 2002 23:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317750AbSG2DvE>; Sun, 28 Jul 2002 23:51:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14563 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317712AbSG2DvE>;
	Sun, 28 Jul 2002 23:51:04 -0400
Date: Sun, 28 Jul 2002 20:43:02 -0700 (PDT)
Message-Id: <20020728.204302.44950225.davem@redhat.com>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0207282048230.913-100000@home.transmeta.com>
References: <20020728.195055.105468330.davem@redhat.com>
	<Pine.LNX.4.44.0207282048230.913-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 28 Jul 2002 20:51:13 -0700 (PDT)

   On Sun, 28 Jul 2002, David S. Miller wrote:
   > They must never run from HW irqs, in fact there is a BUG()
   > check there against this.
   
   From a page cache standpoint softirq's are 100% equivalent to
   hardware irq's, so that doesn't much help here.

Wait are we trying to make the final freeing of (potentially)
LRU/page-cache pages from any non-base context illegal?

If that really becomes an issue we can do something which moves
this back to user context when the result of doing it in irq
context would be problematic.

