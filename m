Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268321AbUHFX0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268321AbUHFX0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 19:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267912AbUHFXZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 19:25:49 -0400
Received: from waste.org ([209.173.204.2]:49838 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267922AbUHFXZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 19:25:31 -0400
Date: Fri, 6 Aug 2004 18:24:52 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: James Morris <jmorris@redhat.com>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       mludvig@suse.cz, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH]
Message-ID: <20040806232452.GA5414@waste.org>
References: <20040806042852.GD23994@certainkey.com> <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com> <20040806125427.GE23994@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806125427.GE23994@certainkey.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 08:54:27AM -0400, Jean-Luc Cooke wrote:
> On Fri, Aug 06, 2004 at 12:42:38AM -0400, James Morris wrote:
> > On Fri, 6 Aug 2004, Jean-Luc Cooke wrote:
> > 
> > > James,
> > >   Back to your question:
> > >     I want to replace the legacy MD5 and the incorrectly implemented SHA-1
> > >     implementations from driver/char/random.c
> > 
> > Incorrectly implemented?  Do you mean not appending the bit count?
> 
> That and it's not endian-correct.

Are you saying that it's hashing incorrectly or that the final form is
not in the standard bit-order? For the purposes of a random number
generator, the latter isn't terribly important. Nor is it particularly
important for GUIDs.

> There are other issues with random.c (lack
> for forward secrecy in the case of seed discovery, use of the insecure MD4 in
> creating syn and seq# for tcp, the use of halfMD4 and twothridsMD4 is
> madness
> (what is 2/3's of 16!?!), the use of LFSRs for "mixing" when they're linear,
> the polymonials used are not even primitive, the ability for root to wipe-out
> the random pool, the ability for root to access the random seed directly, the
> paper I'm co-authoring will explain all of this).
> 
> Basically, the paper will be describing about 12 security problems with the
> current random.c and propose (with patch included) a new design that solves
> all of these, uses crypto-api, uses known crypto primitives, is simpler to
> read
> and analyse and for a bonus is 2x to 4x faster in adding and retrieving data
> from the pool.

Last time I proposed a cryptoapi-based version, I couldn't get any
buy-off on making cryptoapi a non-optional part of the kernel. Looking
forward to your patch/paper.

-- 
Mathematics is the supreme nostalgia of our time.
