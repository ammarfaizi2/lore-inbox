Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUHFM66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUHFM66 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 08:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268118AbUHFM65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 08:58:57 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:58813 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S265920AbUHFM6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 08:58:46 -0400
Date: Fri, 6 Aug 2004 08:54:27 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       mludvig@suse.cz, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH]
Message-ID: <20040806125427.GE23994@certainkey.com>
References: <20040806042852.GD23994@certainkey.com> <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 12:42:38AM -0400, James Morris wrote:
> On Fri, 6 Aug 2004, Jean-Luc Cooke wrote:
> 
> > James,
> >   Back to your question:
> >     I want to replace the legacy MD5 and the incorrectly implemented SHA-1
> >     implementations from driver/char/random.c
> 
> Incorrectly implemented?  Do you mean not appending the bit count?

That and it's not endian-correct.  There are other issues with random.c (lack
for forward secrecy in the case of seed discovery, use of the insecure MD4 in
creating syn and seq# for tcp, the use of halfMD4 and twothridsMD4 is
madness
(what is 2/3's of 16!?!), the use of LFSRs for "mixing" when they're linear,
the polymonials used are not even primitive, the ability for root to wipe-out
the random pool, the ability for root to access the random seed directly, the
paper I'm co-authoring will explain all of this).

Basically, the paper will be describing about 12 security problems with the
current random.c and propose (with patch included) a new design that solves
all of these, uses crypto-api, uses known crypto primitives, is simpler to
read
and analyse and for a bonus is 2x to 4x faster in adding and retrieving data
from the pool.

If I can avoid scatter-gather for what is effectively just mixing bytes with
SHA256
& AES256 then this would make things very neat and tidy (read: easier for
peer review)

Cheers,

JLC
