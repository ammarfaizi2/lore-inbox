Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422679AbWA0XW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422679AbWA0XW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbWA0XW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:22:57 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:46340 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1422682AbWA0XW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:22:56 -0500
Date: Sat, 28 Jan 2006 10:22:41 +1100
To: David Howells <dhowells@redhat.com>
Cc: David =?us-ascii?B?PT9pc28tODg1OS0xP1E/SD1FNHJkZW1hbj89?= 
	<david@2gen.com>,
       linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Subject: Re: [PATCH 00/04] Add DSA key type
Message-ID: <20060127232241.GA3870@gondor.apana.org.au>
References: <20060127071806.GA4082@hardeman.nu> <1138312694656@2gen.com> <E1F2I7q-0007F6-00@gondolin.me.apana.org.au> <6497.1138392685@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6497.1138392685@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 08:11:25PM +0000, David Howells wrote:
> David H?rdeman <david@2gen.com> wrote:
> 
> > I have no problems with moving it to lib/mpi unless someone feels its a bad
> > idea (DHowells, do you agree?).
> 
> I don't think that's the right place for it, except for the fact you can then
> use the archive library generated to only include as much of mpilib as you
> actually require. It seems to me that it should really belong with the crypto
> stuff.

IMHO crypto/ should only contain things that are actually part of the
crypto layer: API code and crypto_alg implementations.

We have precedents for this.  We have the crypto_alg implementation of
sha1 in crypto, but the actual algorithm lives in lib.  Ditto for crc
and zlib.

In this case, the MPI library is even further away from the crypto layer
than any of these cases since it is not a crypto algorithm by itself.
In fact, we can't be sure that there won't ever be another part of the
kernel that requires direct access to the MPI library without going
through the crypto layer.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
