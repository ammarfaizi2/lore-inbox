Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTBSWfh>; Wed, 19 Feb 2003 17:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTBSWfh>; Wed, 19 Feb 2003 17:35:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41923 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262418AbTBSWfg>;
	Wed, 19 Feb 2003 17:35:36 -0500
Date: Wed, 19 Feb 2003 14:29:52 -0800 (PST)
Message-Id: <20030219.142952.27404695.davem@redhat.com>
To: ionut@badula.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0302191706330.29393-100000@guppy.limebrokerage.com>
References: <1045692476.14306.14.camel@rth.ninka.net>
	<Pine.LNX.4.44.0302191706330.29393-100000@guppy.limebrokerage.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ion Badulescu <ionut@badula.org>
   Date: Wed, 19 Feb 2003 17:41:39 -0500 (EST)

   > Nearly all cards today are 64-bit DMA address descriptors only.
   > So if anything, this new ifdef will get less and less used over
   > time.
   
   Not true. Even if the only descriptors available are 64-bit, there is no 
   reason why I should have to care about the upper 32 bits when I know that 
   my dma_addr_t will always be 32-bit, at compile time. I can simply 
   memset(0) the entire descriptor and initialize only the bottom 32 bits. 

Yes true, storing the two consequetive 32-bit values is better
for store buffer compression of the cpu.  Using memset is much
more inefficient because you push the full set of data once
then you push non-compressible stores to the same data through
the cpu.

I'm not talking out of my ass, I've measured this.
