Return-Path: <linux-kernel-owner+w=401wt.eu-S1755231AbXAAQVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbXAAQVw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbXAAQVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:21:52 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2923 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbXAAQVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:21:51 -0500
Date: Mon, 1 Jan 2007 16:21:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20070101162142.GA30535@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk> <20061230163955.GA12622@flint.arm.linux.org.uk> <20061230165012.GB12622@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org> <1167662118.5302.52.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167662118.5302.52.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 09:35:17AM -0500, James Bottomley wrote:
> On Sat, 2006-12-30 at 10:26 -0800, Linus Torvalds wrote:
> > 
> > On Sat, 30 Dec 2006, Russell King wrote:
> > > 
> > > And here's the flush_anon_page() part.
> 
> This looks fine to me (if you need my ack).
> 
> > > Add flush_anon_page() for ARM, to avoid data corruption issues when using
> > > fuse or other subsystems using get_user_pages().
> > 
> > Btw, since this doesn't actually change any code for anybody but ARM, just 
> > adds a parameter that is obviously unused by everybody else, and if it 
> > actually fixes a real bug for ARM, I'll obviously happily take it even 
> > before 2.6.20. So go ahead put it in your ARM tree, and we'll get some 
> > testing through that. And just ask me to pull at some point.
> > 
> > I wonder why nobody else seems to have a "flush_anon_page()"? This would 
> > seem to be a potential issue for architectures like sparc too.. Although 
> > maybe sparc can do a flush by physical index with "flush_dcache_page()".
> 
> The sparc handling of anonymous pages is different ... they accitentally
> sweep them up in flush_dcache_page().  When I audited the architectures
> to try to make fuse work on parisc, parisc and arm were the only ones
> that actually needed flush_anon_page().

However, as David has said, anonymous pages _are_ supposed to be handled
by flush_dcache_page(), so I now have an (untested) implementation for
ARM which does this.  Therefore, I'm revoking the previous two patches.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
