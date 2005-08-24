Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVHXAIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVHXAIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 20:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVHXAIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 20:08:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932502AbVHXAIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 20:08:31 -0400
Date: Tue, 23 Aug 2005 17:08:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mremap() use is racy
In-Reply-To: <430B9E45.3080107@redhat.com>
Message-ID: <Pine.LNX.4.58.0508231705470.3317@g5.osdl.org>
References: <430B7EAE.6020001@redhat.com> <Pine.LNX.4.61.0508232135480.12189@goblin.wat.veritas.com>
 <430B8D96.5080002@redhat.com> <Pine.LNX.4.58.0508231425330.3317@g5.osdl.org>
 <430B9E45.3080107@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Aug 2005, Ulrich Drepper wrote:
>
> Linus Torvalds wrote:
> > 
> > Especially if you use MAP_SHARED, you don't even need to mprotect 
> > anything: you'll get a nice SIGBUS if you ever try to access past the last 
> > page that maps the file.
> 
> If you guarantee this (and test for this) it's fine with me. 

It's how the kernel _should_ work, but very few apps seem to depend on it, 
so no guarantees. I looked over the code, and I think we've lost the 
SIGBUS thing.

Basically, if you don't ever access past the end, you should always be ok.  
If you access past the end, at least some _really_ old kernel versions
will zero-fill the page with an anonymous page and lose coherency, while
more modern kernels should _either_ cause a SIGBUS or alternatively at 
least have a coherent zero-filled page.

		Linus
