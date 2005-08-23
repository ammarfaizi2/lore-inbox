Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVHWV2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVHWV2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVHWV2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:28:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61392 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932199AbVHWV2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:28:13 -0400
Date: Tue, 23 Aug 2005 14:28:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mremap() use is racy
In-Reply-To: <430B8D96.5080002@redhat.com>
Message-ID: <Pine.LNX.4.58.0508231425330.3317@g5.osdl.org>
References: <430B7EAE.6020001@redhat.com> <Pine.LNX.4.61.0508232135480.12189@goblin.wat.veritas.com>
 <430B8D96.5080002@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Aug 2005, Ulrich Drepper wrote:
> 
> Using mmap with a too-large size for the underlying file and then hoping
> that future file growth is magically handled when those pages are
> accessed is not valid.

Actually, it should be pretty much as valid as using mremap - ie it works 
on Linux. 

Especially if you use MAP_SHARED, you don't even need to mprotect 
anything: you'll get a nice SIGBUS if you ever try to access past the last 
page that maps the file.

I think that works correctly for any half-way modern kernel - anything 
that has mremap() should do the right thing (I think older kernels would 
map zero pages past the end of the file mapping, and then if you touched 
the page first, you'd lose the coherency).

		Linus
