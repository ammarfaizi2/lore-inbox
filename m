Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVEXJO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVEXJO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVEXJON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:14:13 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:52408 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261448AbVEXJLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:11:53 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091152.68D65FA3F@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:11:52 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id AC3BBFAEE

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 09:59:59 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261348AbVEXCne (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 22:43:34 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVEXCnd

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 22:43:33 -0400

Received: from arnor.apana.org.au ([203.14.152.115]:7691 "EHLO

	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261309AbVEXCn1

	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 22:43:27 -0400

Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)

	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))

	id 1DaPO4-0002pd-00; Tue, 24 May 2005 12:43:20 +1000

Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))

	id 1DaPO2-0007dP-00; Tue, 24 May 2005 12:43:18 +1000

Date:	Tue, 24 May 2005 12:43:18 +1000

To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	davem@davemloft.net, jmorris@redhat.com
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()

Message-ID: <20050524024318.GB29242@gondor.apana.org.au>

References: <200505232300.j4NN07lE012726@hera.kernel.org> <20050523162806.0e70ae4f.akpm@osdl.org> <20050524022106.GA29081@gondor.apana.org.au> <20050523193116.62844826.akpm@osdl.org>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

In-Reply-To: <20050523193116.62844826.akpm@osdl.org>

User-Agent: Mutt/1.5.9i

From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



On Mon, May 23, 2005 at 07:31:16PM -0700, Andrew Morton wrote:
> 
> Are you sure it's actually needed? Have significant scheduling latencies
> actually been observed?

I certainly don't have any problems with removing the yield altogether.

> Bear in mind that anyone who cares a lot about latency will be running
> CONFIG_PREEMPT kernels, in which case the whole thing is redundant anyway. 
> I generally take the position that if we're going to put a scheduling point
> into a non-premept kernel then it'd better be for a pretty bad latency
> point - more than 10 milliseconds, say.

The crypt() function can easily take more than 10 milliseconds with
a large enough buffer.

James & Dave, do you have any opinions on this?

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

