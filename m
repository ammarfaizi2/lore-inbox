Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965291AbWFIPkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbWFIPkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbWFIPkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:40:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:32396 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965291AbWFIPkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:40:11 -0400
Message-ID: <44899653.1020007@garzik.org>
Date: Fri, 09 Jun 2006 11:40:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org>
In-Reply-To: <20060609030759.48cd17a0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ted&co have been pretty good at avoiding compatibility problems.

Well, extents and 48bit make that track record demonstrably worse.

Users are now forced to remember that, if they write to their filesystem 
after using either $mmver or $korgver kernels, they are locked out of 
using older kernels.

 From the user's perspective, ext3 has no clear "metadata version 1", 
"metadata version 2" division.  Thus they are now forced to keep a 
matrix of kernel versions and ext3 feature flag support, to know which 
kernels are usable with which data.  It is a support nightmare.

At no point is a user ever told, in big capital letters, "IF YOU WRITE 
TO THIS FILESYSTEM, YOU CAN'T BOOT OLDER KERNELS."  There is no "click 
OK to continue with this dramatic event."

And as features continue to be added in this manner, this problem gets 
_exponentially_ worse.


On the project management side of things, I see no indication that this 
momentum slow -- which implies to me that people will keep slapping new 
stuff into ext3, rather than directing energy towards a newer, cleaner 
ext-NG filesystem.

Dragging around back-compat really constrains freedom, and you have to 
have some sort of "pressure relief valve" (a massive, wildly 
incompatible update) eventually.

In my mind, it's analagous to locking developers into developing and 
deploying new features into a stable branch of software.  The hacks just 
get worse and worse, as you bend over backwards for back-compat.

	Jeff


