Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVHRCa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVHRCa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVHRCa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:30:58 -0400
Received: from dns.suna-asobi.com ([210.151.31.146]:31368 "EHLO
	dns.suna-asobi.com") by vger.kernel.org with ESMTP id S932080AbVHRCa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:30:58 -0400
Date: Thu, 18 Aug 2005 11:37:21 +0900
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: arjan@infradead.org, linux-kernel@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
In-Reply-To: <20050817233001.6E7C.AKIRA-T@suna-asobi.com>
References: <98df96d305081622107ca969f@mail.gmail.com> <20050817233001.6E7C.AKIRA-T@suna-asobi.com>
Message-Id: <20050818111044.BE62.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Aug 2005 23:30:13 +0900
Akira Tsukamoto <akira-t@suna-asobi.com> mentioned:
> > I'm trying to understand this mechanism but I don't
> > understand very well.
> 
> My explanation was a bit ambiguous, see the code below. 
> Where the fp register saved? It saves fp register *inside* task_struct,

More clarification, to make fp_save generic,
after exception, such as pagefault, copy function might get nested,
during page allocation.
First it has user space fp content, but nested copy needs to save 
kernel space fp content which came from the first copy function.
So saving into task_struct is bit problem.

XMM_SAVE/XMM_RESTORE uses stack for it. 
Surrounding copy loop with XMM_SAVE/XMM_RESTORE should work.

Some might claim that, saving/restore every time might a big overhead,,,
but i think it is better than having a lot of cache miss hit.

Isn't there some way to avoid long preemption disabling?

-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


