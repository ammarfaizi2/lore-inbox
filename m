Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264792AbUEKXSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbUEKXSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUEKXSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:18:25 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:20177 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264792AbUEKXSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:18:18 -0400
Subject: Re: [PATCH] Sort kallsyms in name order: kernel shrinks by 30k
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, randy.dunlap@osdl.org,
       Sam Ravnborg <sam@ravnborg.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@sgi.com>
In-Reply-To: <20040511080843.GB8751@colin2.muc.de>
References: <1084252135.31802.312.camel@bach>
	 <20040511080843.GB8751@colin2.muc.de>
Content-Type: text/plain
Message-Id: <1084317416.17692.29.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 09:16:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 18:08, Andi Kleen wrote:
> On Tue, May 11, 2004 at 03:08:55PM +1000, Rusty Russell wrote:
> > Admittedly, anyone who sets CONFIG_KALLSYMS doesn't care about space,
> > it's a fairly trivial change.
> 
> As long as nobody does binary search it's good. Wonder why I did not
> have this idea already with the original stem compression change ;-)

ISTR that someone (I thought you) mentioned doing this before.

In general this code was considered non-speed-critical, but Keith points
out its use in wchan.  A simple cache might make more sense there,
however.

A binary search as stands doesn't help much because we still need to
iterate through the names.  We could do "address, nameindex" pairs, but
with stem compression we need to at least wade back some way to decode
the name.

I have a 30-line static huffman decoder (from the IDE mini-oopser) which
we could use instead of stem compression, which we could combine with
"address, bitoffset" pairs which would be about 20k smaller and faster
than the current approach, but is it worth the trouble?

Thoughts welcome,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

