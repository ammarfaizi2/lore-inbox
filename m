Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVHITN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVHITN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVHITN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:13:56 -0400
Received: from smtp.istop.com ([66.11.167.126]:37770 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932127AbVHITN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:13:56 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Wed, 10 Aug 2005 05:14:13 +1000
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <42F7F5AE.6070403@yahoo.com.au>
In-Reply-To: <42F7F5AE.6070403@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508100514.13672.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 August 2005 10:15, Nick Piggin wrote:
> Daniel Phillips wrote:
> > Why don't you pass the vma in zap_details?  For that matter, why are addr
> > and end still passed down the zap chain when zap_details appears to
> > duplicate that information?  OK, it is because zap_details is NULL in
> > about twice as many places as it carries data.  But since the details
> > parameter is already there, would it not make sense to press it into
> > service to slim down those parameter lists a little?
>
> Possibly. I initially did it that way, but it ended up fattening
> paths that don't use details.

It should not, it only affects, hmm, less than 10 places, each at the 
beginning of a massive call chain, e.g., in madvise_dontneed:

-	zap_page_range(vma, start, end - start, NULL);
+	zap_page_range(start, end - start, &(struct zap){ .vma = vma });

> And this way is less intrusive.

Nearly the same I think, and makes forward progress in controlling this 
middle-aged belly roll of an internal API.

Regards,

Daniel
