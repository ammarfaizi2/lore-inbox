Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWFHH1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWFHH1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFHH1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:27:44 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:62477 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932548AbWFHH1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:27:43 -0400
Date: Thu, 8 Jun 2006 17:27:35 +1000
To: Joachim Fritschi <jfritschi@freenet.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
Message-ID: <20060608072735.GA10613@gondor.apana.org.au>
References: <200606041516.21967.jfritschi@freenet.de> <200606072137.24176.jfritschi@freenet.de> <20060608015728.GA8314@gondor.apana.org.au> <200606080920.04480.jfritschi@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606080920.04480.jfritschi@freenet.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 09:20:04AM +0200, Joachim Fritschi wrote:
> 
> Solve the naming conflict when compiling. Seemed to me like it is impossible to create a
> twofish.o out of twofish.o and twofish_common.o . And since having the original module name
> seemed more important to me i changed the name. I didn't find any other way in documentation
> of the kernel makefiles. I hope this isn't another newbie mistake. =)

Just make a module out of the common code.  See sound/isa/sb/Makefile
for an example.  It would also help to make a common Kconfig symbol
that is not visible to the user but instead is selected by any one
of the twofish implementations.

If you do it this way then the assembly implementations just need to
select that Kconfig symbol to get the common code either built as a
module or compiled in.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
