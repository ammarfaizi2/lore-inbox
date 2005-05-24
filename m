Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVEXJaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVEXJaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVEXJ3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:29:02 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:20674 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261987AbVEXJR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:17:56 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091756.04470FA50@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:17:56 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 8548EFB7D

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:50 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261306AbVEXCV1 (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 22:21:27 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVEXCV1

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 22:21:27 -0400

Received: from arnor.apana.org.au ([203.14.152.115]:39434 "EHLO

	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261306AbVEXCVX

	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 22:21:23 -0400

Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)

	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))

	id 1DaP2b-0002ec-00; Tue, 24 May 2005 12:21:09 +1000

Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))

	id 1DaP2Y-0007Zp-00; Tue, 24 May 2005 12:21:06 +1000

Date:	Tue, 24 May 2005 12:21:06 +1000

To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	James Morris <jmorris@redhat.com>
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()

Message-ID: <20050524022106.GA29081@gondor.apana.org.au>

References: <200505232300.j4NN07lE012726@hera.kernel.org> <20050523162806.0e70ae4f.akpm@osdl.org>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

In-Reply-To: <20050523162806.0e70ae4f.akpm@osdl.org>

User-Agent: Mutt/1.5.9i

From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



On Mon, May 23, 2005 at 11:28:06PM +0000, Andrew Morton wrote:
> 
> This code can cause deadlocks on CONFIG_SMP && !CONFIG_PREEMPT kernels.
> 
> Please see http://lkml.org/lkml/2005/3/10/358
> 
> You (the programmer) *have* to know what context you're running in before
> doing a voluntary yield.  There is simply no way to work this out at
> runtime.

You're right.

Perhaps we should code this into the crypto API instead? For instance,
we can have a tfm flag that says whether we can sleep or not.

Dave & James, What do you think?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

