Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUBCTbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUBCT26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:28:58 -0500
Received: from waste.org ([209.173.204.2]:52656 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266051AbUBCT1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:27:24 -0500
Date: Tue, 3 Feb 2004 13:27:11 -0600
From: Matt Mackall <mpm@selenic.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib routines
Message-ID: <20040203192711.GB31138@waste.org>
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com> <20040203175006.GA19751@chaapala-lnx2.cisco.com> <20040203185111.GA31138@waste.org> <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 01:13:48PM -0600, Clay Haapala wrote:
> On Tue, 3 Feb 2004, Matt Mackall uttered the following:
> 
> +/*
> + * Haven't generated a big-endian table yet, but the bit-wise version
> + * should at least work.
> + */
> > 
> > Big-endian in this context means, of course, the order of the bits in
> > the byte rather than bytes in a word, and as this CRC polynomial was
> > chosen especially for its robustness on noise bursts in little-endian
> > transmission (aka standard serial and network *bit* transmission
> > ordering), I think we should intentionally omit BE support and make
> > note of it.
> > 
> Yes, it is about transmission bit-order.  Is the crc32 BE code also
> not necessary?  Does it deal with how various networking hardware
> and architecture combos present this data?

The crc32_be stuff is used by at least Bluetooth, some of the digital
video stuff, and a couple other random things. I suspect it's mostly
historical accident.

> >> +static inline void crypto_chksum_final(struct crypto_tfm *tfm, u32 *out)
> >> +{
> >> +	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CHKSUM);
> > 
> > A lot of these BUG_ONs seem to be overkill. You're not going to get
> > here by someone accidentally misusing the interface. You can only get
> > here by some very willful abuse of the interface or by extremely
> > unlikely fandango on core, neither of which is worth trying to defend
> > against.
> 
> That would be a worth changing in a clean-up pass over all of
> crypto, then.

I'll do them if James has no objections. I've got a couple other
crypto bits queued.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
