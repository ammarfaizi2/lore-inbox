Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWJTQhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWJTQhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992630AbWJTQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:37:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932278AbWJTQhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:37:12 -0400
Date: Fri, 20 Oct 2006 09:36:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: David Miller <davem@davemloft.net>, ralf@linux-mips.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <4538F1EC.1020806@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610200935290.3962@g5.osdl.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org>
 <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org>
 <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au>
 <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <4538F1EC.1020806@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Oct 2006, Nick Piggin wrote:
> 
> I didn't think that would work if there is no TLB. But if the writeback
> can cause a TLB reload, and then bypass the readonly protection, then
> yes would close all races.

On the other hand, doing the cache flush at COW time is "kind of 
equivalent" to just doing it after the TLB flush. It's now just _much_ 
after the flush ;)

So maybe the COW D$ aliasing patch-series is just the right thing to do. 
Not worry about D$ at _all_ when doing the actual fork, and only worry 
about it on an actual COW event. Hmm?

		Linus
