Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTEaKiV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 06:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTEaKiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 06:38:21 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:46340 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264268AbTEaKiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 06:38:20 -0400
Date: Sat, 31 May 2003 20:51:04 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: joern@wohnheim.fh-wedel.de, <dwmw2@infradead.org>,
       <matsunaga_kazuhisa@yahoo.co.jp>, <linux-mtd@lists.infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
In-Reply-To: <20030530.232004.115919834.davem@redhat.com>
Message-ID: <Mutt.LNX.4.44.0305312025270.6696-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, David S. Miller wrote:

>    From: James Morris <jmorris@intercode.com.au>
>    Date: Sat, 31 May 2003 01:29:42 +1000 (EST)
>    
>    This won't work for the bh lock protected case outlined above, and
>    will cause contention between different users of zlib.
> 
> My understanding is that these are just scratchpads.  The contents
> while a decompress/compress operation is not occuring does not
> matter.

It depends on how the zlib library is used.  The filesystems and crypto
code use it so that each operation is distinct, although it is possible to
maintain compression history between operations: PPP does this via a
sliding compression window, and there are other potential users such as
ROHC.

One way of addressing this would to allow the user to supply their own 
workspace if compression history needs to be maintained.

> So if we have 2 such scratchpads per cpu, one for normal and one for
> BH context, his idea truly can work and be useful to everyone.
> It would also be lockless on SMP.

And perhaps implement with a lazy allocation scheme so that these
scratchpads are only allocated if needed (i.e. a caller does not provide
its own workspace).


- James
-- 
James Morris
<jmorris@intercode.com.au>

