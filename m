Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbUBBXKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUBBXKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:10:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:30115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265757AbUBBXKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:10:06 -0500
Date: Mon, 2 Feb 2004 15:09:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: <20040202144642.50ea0468.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402021508330.9720@home.osdl.org>
References: <200402020729.i127TKG8011009@magilla.sf.frob.com>
 <20040202144642.50ea0468.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Feb 2004, Andrew Morton wrote:
> 
> One way to handle that would be to give the `write' arg to
> handle_mm_fault() a third value which means "give us a writeable page, but
> don't make the pte writeable".  Maybe that isn't warranted for this special
> case.  But it would be better, really.

I agree - it would be a "fault for an exclusive write, but don't do the
writability part". I don't think any of the low-level filesystems would 
even know about that flag, since the actual page table accesses are done 
by the generic VM.

		Linus
