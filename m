Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWBVBbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWBVBbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWBVBbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:31:41 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:46862
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1161144AbWBVBbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:31:41 -0500
Date: Wed, 22 Feb 2006 12:31:37 +1100
To: Michael Heyse <mhk@designassembly.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: which one is broken: VIA padlock aes or aes_i586?
Message-ID: <20060222013137.GA844@gondor.apana.org.au>
References: <43FB0746.5010200@designassembly.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB0746.5010200@designassembly.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 01:27:50PM +0100, Michael Heyse wrote:
> 
> after upgrading the kernel from 2.6.12.5 to 2.6.16-rc4, decryption of my disk fails. As I am using the Nehemia's Padlock and aes-cbc-essiv, I guess this is the reason:
> 
> (from ChangeLog-2.6.13)
> commit 476df259cd577e20379b02a7f7ffd086ea925a83
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Wed Jul 6 13:54:09 2005 -0700
> 
>     [CRYPTO] Update IV correctly for Padlock CBC encryption
> 
>     When the Padlock does CBC encryption, the memory pointed to by EAX is
>     not updated at all.  Instead, it updates the value of EAX by pointing
>     it to the last block in the output.  Therefore to maintain the correct
>     semantics we need to copy the IV.

I don't think this patch is your problem since it's part of the multiblock
code which doesn't exist in 2.6.12 at all.  Of course the multiblock code
itself could be buggy.  I'll take a look.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
