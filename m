Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbUB0U4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUB0U4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:56:41 -0500
Received: from waste.org ([209.173.204.2]:57476 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263109AbUB0UzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:55:13 -0500
Date: Fri, 27 Feb 2004 14:55:01 -0600
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040227205501.GM3883@waste.org>
References: <20040221021724.GA8841@leto.cs.pocnet.net> <20040224191142.GT3883@waste.org> <1077651839.11170.4.camel@leto.cs.pocnet.net> <20040224203825.GV3883@waste.org> <20040225214308.GD3883@waste.org> <1077824146.14794.8.camel@leto.cs.pocnet.net> <20040226200244.GH3883@waste.org> <1077897901.29711.44.camel@leto.cs.pocnet.net> <20040227200214.GK3883@waste.org> <1077912813.2505.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077912813.2505.8.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 09:13:33PM +0100, Christophe Saout wrote:
> > I'd like to keep it to the minimal three new external functions until
> > we have a case that really demonstrates a need for the other stuff.
> > Let's keep it simple, get it merged, and go from there. The API I
> > posted will work for the three other users I'm aware of, if it works
> > for dm-crypt let's go with it.
> 
> I've added methods for copying the tfm context because it will fail very
> badly for everything that has a pointer in the private context.
> Use-after-free and these things. Ugly.

I certainly understand the issues of deep vs shallow copy. What I'm
saying is we should try to avoid needing deep copies in the first
place. They invite lots of complexity and for something as
straightforward as a cipher or digest should not be necessary.
 
> > I also want to hold off on adding ->copy until we find an algorithm
> > that can't be cleanly fixed not to need it.
> 
> Hmm. It should be there, but could return -EOPNOTSUPP. Copying a
> compress tfm doesn't make much sense. We need a way to detect things
> that are bad in a generic way, everything else is hacky.

Some way of preventing copies of some TFMs is called for, agreed.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
