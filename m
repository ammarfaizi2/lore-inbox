Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265001AbUFGS5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbUFGS5C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUFGS5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:57:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:14274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265001AbUFGS47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 14:56:59 -0400
Date: Mon, 7 Jun 2004 11:56:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] Missing BKL in sys_chroot() for 2.6
In-Reply-To: <200406061958.48262.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0406071150560.1637@ppc970.osdl.org>
References: <200406061958.48262.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, BlaisorBlade wrote:
>
> (PLEASE cc me on replies as I'm not subscribed).
> 
> Set_fs_root *claims* it wants the BKL held:

I think the set_fs_root() comment is just wrong.

We properly lock the accesses to root/rootmnt with "fs->lock", and in fact 
no other users will have the BKL when accessing them anyway, so I don't 
see what the BKL would help in this case.

However, from a quick grep of users, it does look like some other users 
aren't real careful with "fs->lock" (ie chroot_fs_refs() looks like it 
could have problems - probably purely theoretical).

Al, do your eagle-eyes see something I missed?

		Linus
