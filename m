Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSLHT41>; Sun, 8 Dec 2002 14:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSLHT41>; Sun, 8 Dec 2002 14:56:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16776 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261587AbSLHT41>;
	Sun, 8 Dec 2002 14:56:27 -0500
Date: Sun, 08 Dec 2002 12:00:44 -0800 (PST)
Message-Id: <20021208.120044.08024570.davem@redhat.com>
To: akpm@digeo.com
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DF28748.186AB31F@digeo.com>
References: <3DF2844C.F9216283@digeo.com>
	<20021207.153045.26640406.davem@redhat.com>
	<3DF28748.186AB31F@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Sat, 07 Dec 2002 15:42:00 -0800

   "David S. Miller" wrote:
   > non-smp machines lack L2 caches?  That's new to me :-)
   > 
   > More seriously, there are real benefits on non-SMP systems.
   
   Then I am most confused.  None of these fields will be put under
   busmastering or anything like that, so what advantage is there in
   spreading them out?
   
When you are in the "tx path" you'll take one L2 cache miss
to bring all the necessary information into the cpu's caches.

Otherwise, when data is arbitrarily scattered over multiple L2
cache lines, you'll need to service potentially more L2 cache
misses.

This optimization has nothing to do with false data sharing amoungst
multiple processors.  It's about packing the data accesses optimally
for specific code paths.
