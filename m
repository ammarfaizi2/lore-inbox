Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWGRDb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWGRDb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWGRDb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:31:56 -0400
Received: from [216.208.38.107] ([216.208.38.107]:58758 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S1751155AbWGRDb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:31:56 -0400
Subject: Re: How to explain to lock validator: locking inodes in inode order
From: Arjan van de Ven <arjan@infradead.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bda6d13a0607171924v5cd15811v7c9749ad481b232d@mail.gmail.com>
References: <bda6d13a0607171924v5cd15811v7c9749ad481b232d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 05:31:53 +0200
Message-Id: <1153193513.4533.3.camel@testmachine>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-17 at 19:24 -0700, Joshua Hudson wrote:
> Code does this:
> 
> /* Lock two items. See locking.txt */
> static inline void kb0_lock2m(struct kb0_idata *m1, struct kb0_idata *m2)
> {
>         if (m1->vi.i_ino > m2->vi.i_ino)
>                 mutex_lock(&m2->k_mutex);
>         mutex_lock(&m1->k_mutex);
>         if (m1->vi.i_ino < m2->vi.i_ino)
>                 mutex_lock(&m2->k_mutex);
> }
> 
> Not sure how to explain to the lock validator that this code can never deadlock.

you're sure it can;t? (which fs is this btw?)

all places in the kernel that take this mutex in that order only do it
in i_ino order, including all directory operations like cross directory
rename?

(if so you can explain normal parent/child nesting, but only if so)

