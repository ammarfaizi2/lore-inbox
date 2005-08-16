Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVHPXHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVHPXHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVHPXHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:07:04 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2475 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750723AbVHPXHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:07:02 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
	between /dev/kmem and /dev/mem)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Edwards <edwardsg@sgi.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jack Steiner <steiner@sgi.com>
In-Reply-To: <20050816221223.GA9991@sgi.com>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <1123951810.3187.20.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org>
	 <1123953924.3187.22.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
	 <1123957087.3187.31.camel@laptopd505.fenrus.org>
	 <20050816221223.GA9991@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Aug 2005 00:33:45 +0100
Message-Id: <1124235225.25433.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-16 at 17:12 -0500, Greg Edwards wrote:
> mmap_mem suffers from a lack of proper checks as well.  For example, on
> Altix page 0 of each node is reserved for prom and a read or write to it
> will cause an MCA.  mmaping /dev/mem with offset 0 will nicely explode.
> Would adding a pfn_valid test in mmap_mem be the best bet, or could we
> consolidate the checks currently in mmap_kmem into mmap_mem?

If you use /dev/mem you should know what you are doing. Even with
"checks" dd if=/dev/zero of=/dev/mem will do bad things. Trapping
obviously bad cases is fine, but complete sanity checking may actually
be counter productive.

