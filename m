Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVBWWBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVBWWBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVBWWBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:01:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:17858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261616AbVBWWAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:00:43 -0500
Date: Wed, 23 Feb 2005 14:00:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olof Johansson <olof@austin.ibm.com>
cc: Jamie Lokier <jamie@shareable.org>, Joe Korty <joe.korty@ccur.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
In-Reply-To: <20050223191254.GA5608@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0502231356580.18997@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org>
 <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
 <20050223144940.GA880@tsunami.ccur.com> <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org>
 <20050223171015.GD10256@austin.ibm.com> <20050223182203.GA10931@mail.shareable.org>
 <Pine.LNX.4.58.0502231033540.2378@ppc970.osdl.org> <20050223184946.GA11473@mail.shareable.org>
 <20050223191254.GA5608@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Feb 2005, Olof Johansson wrote:
> 
> How's this? I went with get_val_no_fault(), since it isn't really a
> get_user.*() any more (ptr being passed in), and no_paging is a little
> misleading (not all faults are due to paging).

Applied with minor cosmetic changes. I'm like a dog who likes to pee on 
things to show his territory, so I changed "get_val_no_fault" to 
"get_futex_value_locked", and I made sure that the return value is 
sensible (return 0 or -EFAULT rather than the "__memcpy_from_user()" 
return value which is how many bytes we couldn't copy).

Not that we care (we just check the return value against zero anyway,
which is success in both cases), but the compiler should be able to
optimize it away, and it might avoid some confusion down the line..

		Linus
