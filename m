Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVCUJlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVCUJlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCUJlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:41:49 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:35085 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261700AbVCUJlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:41:47 -0500
Date: Mon, 21 Mar 2005 20:40:47 +1100
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
Subject: [0/5] [CRYPTO] Speed up crypt()
Message-ID: <20050321094047.GA23084@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I've developed a series of patches that speed up the operations of crypt()
based on the generic scatterwalk patch by Fruhwirth Clemens.  My testing
shows that the results are comparable to that of the original patch.

What I found is that the primary source of the boost in performance is
the change that results in one pair of kmap operations per page instead
of one set per block as is done currently.  Since the average block size
is around 8/16 bytes this is understandable.

Apart from that eliminating unnecessary out-of-line function calls for
the fast path in crypt() also helps quite a lot.

Please let me know if you find any problems with these patches.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
