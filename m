Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSG2C65>; Sun, 28 Jul 2002 22:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSG2C65>; Sun, 28 Jul 2002 22:58:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55778 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317471AbSG2C64>;
	Sun, 28 Jul 2002 22:58:56 -0400
Date: Sun, 28 Jul 2002 19:50:55 -0700 (PDT)
Message-Id: <20020728.195055.105468330.davem@redhat.com>
To: akpm@zip.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D448D38.D156C249@zip.com.au>
References: <3D439E10.67A839A5@zip.com.au>
	<Pine.LNX.4.44.0207281649560.9427-100000@home.transmeta.com>
	<3D448D38.D156C249@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Sun, 28 Jul 2002 17:32:56 -0700
   
   Also skb_release_data(), ___pskb_trim() and __pskb_pull_tail().  Can these
   ever perform the final release against a page which is on the LRU?
   In interrupt context?

These page releases run from either user or softint context.

They must never run from HW irqs, in fact there is a BUG()
check there against this.

Any page that can be found in the page cache can end up here.  So
whatever that mean for "release against a page which is on the LRU"
applies here.
