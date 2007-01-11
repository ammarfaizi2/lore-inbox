Return-Path: <linux-kernel-owner+w=401wt.eu-S1030202AbXAKDGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbXAKDGU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 22:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbXAKDGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 22:06:20 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50603 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030202AbXAKDGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 22:06:19 -0500
Date: Wed, 10 Jan 2007 19:05:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Aubrey <aubreylee@gmail.com>
cc: Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2007, Aubrey wrote:
>
> Now, my question is, is there a existing way to mount a filesystem
> with O_DIRECT flag? so that I don't need to change anything in my
> system. If there is no option so far, What is the right way to achieve
> my purpose?

The right way to do it is to just not use O_DIRECT. 

The whole notion of "direct IO" is totally braindamaged. Just say no.

	This is your brain: O
	This is your brain on O_DIRECT: .

	Any questions?

I should have fought back harder. There really is no valid reason for EVER 
using O_DIRECT. You need a buffer whatever IO you do, and it might as well 
be the page cache. There are better ways to control the page cache than 
play games and think that a page cache isn't necessary.

So don't use O_DIRECT. Use things like madvise() and posix_fadvise() 
instead. 

		Linus
