Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbUCCIfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 03:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUCCIfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 03:35:14 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:49117 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262421AbUCCIfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 03:35:08 -0500
Date: Wed, 3 Mar 2004 00:35:07 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
In-Reply-To: <20040221164821.GA14723@certainkey.com>
Message-ID: <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org>
References: <20040220172237.GA9918@certainkey.com>
 <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com>
 <20040221164821.GA14723@certainkey.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004, Jean-Luc Cooke wrote:

> Well, CTR mode is not recommended for encrypted file systems because it is very
> easy to corrupt single bits, bytes, blocks, etc without an integrity check.
> If we add a MAC, then any mode of operation except ECB can be used for
> encrypted file systems.

what does "easy to corrupt" mean?  i haven't really seen disks generate
bit errors ever.  this MAC means you'll need to write integrity data for
every real write.  that really doesn't seem worth it...

it seems like a block is either right, or it isn't -- the only thing the
MAC is telling you is that the block isn't right... it doesn't tell you
how to fix it.  that's a total waste of write bandwidth -- you might as
well return the bogus decrypted block.


> [3] Why not use IV == block number or IV == firstIV + block number?
> Certain modes of operation (like CTR) begin to leak information about the
> plaintext if you ever use the same Key-IV pair for your data.
> The IV will need to be updated every time you update the block.
> The IV generation does need not be from a cryptographicly strong PRNG,
> it need only be different from the previous IV.
> So incrementing the IV by 1 mod 2^128 every time you write to the block will
> suffice.

is CTR the only mode which is weak with simple IV / block number
relationships?

if you absolutely need this IV update for every write then you should
consider a disk layout which mixes IV (or IV+MAC) blocks so that they are
grouped near their data blocks, to reduce seek overhead.

i.e. 1 block containing 15 IV+MAC, followed by 15 data blocks, followed by
IV+MAC, followed by 15 data...

-dean
