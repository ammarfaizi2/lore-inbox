Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWHWALs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWHWALs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWHWALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:11:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932081AbWHWALr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:11:47 -0400
Date: Tue, 22 Aug 2006 17:11:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Mike Benoit <ipso@snappymail.ca>
Subject: Re: [PATCH] reiserfs: eliminate minimum window size for bitmap
 searching
Message-Id: <20060822171133.72692542.akpm@osdl.org>
In-Reply-To: <44EB7518.5010204@suse.com>
References: <44EB1484.2040502@suse.com>
	<44EB23D9.9000508@slaphack.com>
	<44EB28EC.50802@suse.com>
	<44EB684C.2090206@slaphack.com>
	<44EB7518.5010204@suse.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can see that the bigalloc code as-is is pretty sad, but this is a scary
patch.  It has the potential to cause people significant performance
problems way, way ahead in the future.

For example, suppose userspace is growing two files concurrently.  It could
be that the bigalloc code would cause one file's allocation cursor to
repeatedly jump far away from the second.  ie: a beneficial side-effect. 
Without bigalloc that side-effect is lost and the two files blocks end up
all intermingled.

I don't know if that scenario is realistic, but I bet there are similar
accidental oddities which can occur as a result of this change.

But what are they?

