Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVA0ACW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVA0ACW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVA0ABb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:01:31 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:42172 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262321AbVAZU0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:26:39 -0500
Date: Wed, 26 Jan 2005 12:26:39 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: linux-os <linux-os@analogic.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050126202639.GA10106@hexapodia.org>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 11:38:15AM -0500, linux-os wrote:
> On Wed, 26 Jan 2005, Rik van Riel wrote:
> >With some programs the 2.6 kernel can end up allocating memory
> >at address zero, for a non-MAP_FIXED mmap call!  This causes
> >problems with some programs and is generally rude to do. This
> >simple patch fixes the problem in my tests.
> 
> Does this mean that we can't mmap the screen regen buffer at
> 0x000b8000 anymore?

That would be a MAP_FIXED call, so not affected by this change.

> How do I look at the real-mode interrupt table starting at
> offset 0? You know that the return value of mmap is to be
> checked for MAP_FAILED, not for NULL, don't you?

All MAP_FIXED, too.

> What 'C' standard do you refer to? Seg-faults on null pointers
> have nothing to do with the 'C' standard and everything to
> do with the platform.

Obviously having malloc() return NULL for a successful allocation would
be a bad thing, no?  That's precisely what could happen if an anonymous
allocation got mapped at 0x0.

> >+#define SHLIB_BASE             0x00111000

Any particular thoughts as to how large a window should be reserved?
SHLIB_BASE is a bit more than 1MB, which is fairly small in the grand
scheme of things, but I guess I don't see why you'd reserve more than
PAGE_SIZE (or maybe PAGE_SIZE*2, though I can't actually articulate why
that seems like a good idea).

FWIW, mmap(2) also will return NULL if length==0.  That sure did confuse
me the first time I noticed.

-andy
