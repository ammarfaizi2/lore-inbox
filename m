Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUIORge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUIORge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUIORea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:34:30 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:47769 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267184AbUIORcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:32:42 -0400
Date: Wed, 15 Sep 2004 19:32:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915173236.GE6158@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 September 2004 10:07:29 -0700, Linus Torvalds wrote:
> On Wed, 15 Sep 2004, Jörn Engel wrote:
> > 
> > C now supports pointer arithmetic with void*?
> 
> C doesn't. gcc does. It's a documented extension, and it acts like if it 
> was done on a byte.
> 
> See gcc's user guide "Extension to the C Language Family".
> 
> It's a singularly good feature. 

Nice.

But it still leaves me confused.  Before I had this code:

	struct regs {
		uint32_t status;
		...
	}

	...

	struct regs *regs = ioremap(...);
	uint32_t status = regs->status;
	...

So now I should do it like this:

	#define REG_STATUS 0

	...

	void __iomem *regs = ioremap(...);
	uint32_t status = readl(regs + REG_STATUS);
	...

But wait, that only works when long is 32bit wide.  Plus I could be
stupid enough and "#define REG_STATUS 64" while the register space is
just 64 bytes long.  It solves the confusion about address spaces,
agreed, but overall I'm more confused now.  Hope it's just temporary.

Jörn

-- 
There is no worse hell than that provided by the regrets
for wasted opportunities.
-- Andre-Louis Moreau in Scarabouche
