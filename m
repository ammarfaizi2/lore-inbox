Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWBBPKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWBBPKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWBBPKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:10:20 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40076 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751123AbWBBPKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:10:18 -0500
Subject: Re: [RFC] VM: I have a dream...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Boldi <a1426z@gawab.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Bryan Henderson <hbryan@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200601311856.17569.a1426z@gawab.com>
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com>
	 <200601301621.24051.a1426z@gawab.com>
	 <8F530CA8-1AC8-4AE5-8F1E-DC6518BD7D42@mac.com>
	 <200601311856.17569.a1426z@gawab.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Feb 2006 15:11:29 +0000
Message-Id: <1138893090.9861.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-31 at 18:56 +0300, Al Boldi wrote:
> So with 64bits widely available now, and to let Linux spread its wings and 
> really fly, how could tmpfs merged w/ swap be tweaked to provide direct 
> mapped access into this linear address space?

Why bother. You can already create a private large file and mmap it if
you want to do this, and you will get better performance than being
smeared around swap with everyone else.

Currently swap means your data is mixed in with other stuff. Swap could
do preallocation of each vma when running in limited overcommit modes
and it would run a lot faster if you did but you would pay a lot in
flexibility and efficiency, as well as needing a lot more swap.

Far better to let applications wanting to work this way do it
themselves. Just mmap and the cache balancing and pager will do the rest
for you.

