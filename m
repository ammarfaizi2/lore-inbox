Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317551AbSGTWeG>; Sat, 20 Jul 2002 18:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSGTWeG>; Sat, 20 Jul 2002 18:34:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58004 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317551AbSGTWeG>;
	Sat, 20 Jul 2002 18:34:06 -0400
Date: Sat, 20 Jul 2002 15:27:03 -0700 (PDT)
Message-Id: <20020720.152703.102669295.davem@redhat.com>
To: rml@tech9.net
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@conectiva.com.br, wli@holomorphy.com
Subject: Re: [PATCH] generalized spin_lock_bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1027196511.1555.767.camel@sinai>
References: <1027196511.1555.767.camel@sinai>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 20 Jul 2002 13:21:51 -0700
   
   Thanks to Christoph Hellwig for prodding to make it per-architecture,
   Ben LaHaise for the loop optimization, and William Irwin for the
   original bit locking.

Just note that the implementation of these bit spinlocks will be
extremely expensive on some platforms that lack "compare and swap"
type instructions (or something similar like "load locked, store
conditional" as per mips/alpha).

Why not just use the existing bitops implementation?  The code is
going to be mostly identical, ala:

	while (test_and_set_bit(ptr, nr)) {
		while (test_bit(ptr, nr))
			barrier();
	}

This makes less work for architectures to support this thing.
