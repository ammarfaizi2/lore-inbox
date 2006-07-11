Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWGKJCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWGKJCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWGKJCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:02:08 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:29312
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750799AbWGKJCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:02:07 -0400
Message-ID: <44B36910.3010801@lsrfire.ath.cx>
Date: Tue, 11 Jul 2006 11:02:08 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, devel@openvz.org, kuznet@ms2.inr.ac.ru,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fdset's leakage
References: <44B258E3.7070708@openvz.org> <20060711010104.16ed5d4b.akpm@osdl.org>
In-Reply-To: <20060711010104.16ed5d4b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[strange loop snipped]

> That's going to take a long time to compute if nr > NR_OPEN.  I just fixed
> a similar infinite loop in this function.

That other fix looks buggy btw.  Here it is:

-	nfds = 8 * L1_CACHE_BYTES;
-  	/* Expand to the max in easy steps */
-  	while (nfds <= nr) {
-		nfds = nfds * 2;
-		if (nfds > NR_OPEN)
-			nfds = NR_OPEN;
-	}
+	nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nfds));
+	if (nfds > NR_OPEN)
+		nfds = NR_OPEN;

Surely you meant to say "roundup_pow_of_two(nr + 1)"?

René
