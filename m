Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTEaKyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 06:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTEaKyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 06:54:53 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:34785 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264273AbTEaKyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 06:54:52 -0400
Date: Sat, 31 May 2003 13:07:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Morris <jmorris@intercode.com.au>
Cc: "David S. Miller" <davem@redhat.com>, dwmw2@infradead.org,
       matsunaga_kazuhisa@yahoo.co.jp, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030531110743.GA24300@wohnheim.fh-wedel.de>
References: <20030530.232004.115919834.davem@redhat.com> <Mutt.LNX.4.44.0305312025270.6696-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Mutt.LNX.4.44.0305312025270.6696-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 20:51:04 +1000, James Morris wrote:
> On Fri, 30 May 2003, David S. Miller wrote:
> 
> > My understanding is that these are just scratchpads.  The contents
> > while a decompress/compress operation is not occuring does not
> > matter.
> 
> It depends on how the zlib library is used.  The filesystems and crypto
> code use it so that each operation is distinct, although it is possible to
> maintain compression history between operations: PPP does this via a
> sliding compression window, and there are other potential users such as
> ROHC.
> 
> One way of addressing this would to allow the user to supply their own 
> workspace if compression history needs to be maintained.

Agreed.  How much memory is needed for the history?  Most of the
workspace or substancially less?

> > So if we have 2 such scratchpads per cpu, one for normal and one for
> > BH context, his idea truly can work and be useful to everyone.
> > It would also be lockless on SMP.
> 
> And perhaps implement with a lazy allocation scheme so that these
> scratchpads are only allocated if needed (i.e. a caller does not provide
> its own workspace).

Disagreed.  Two scratchpads per cpu won't hurt in the mean case much
and lazy allocation wouldn't improve the worst case either.  Keep them
static and simple.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
