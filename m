Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTDUVbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTDUVbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:31:10 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37594 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262600AbTDUVbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:31:08 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 21 Apr 2003 23:43:06 +0200 (MEST)
Message-Id: <UTC200304212143.h3LLh6e02148.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] new system call mknod64
Cc: Andries.Brouwer@cwi.nl, davem@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice to see this discussion.

Linus says

> The question is only _where_ (not whether) we do the mapping. Right now we 
> keep "dev_t" in the same format as we give back to user space, and thus we 
> always map into that format internally. But we don't have to: we can have 
> an internal format that is different from the one we show users.

and in fact the patches I have been giving out use kdev_t
as internal format, where you can think of kdev_t as
u64, or, if you prefer, as struct { u32 major, minor; }.

As I wrote a month or two ago, my favourite version is to
have register_region work in the kdev_t space, rather than
the dev_t space, since intervals in kdev_t space have a
direct interpretation in terms of major, minor.

Andries

(Both versions do not differ very much;
as far as I am concerned the choice is not very important,
but the kdev_t version is slightly cleaner.)

(As Al already remarked, device numbers do not play much of a role
internally. I removed i_dev. We still have i_rdev.)

