Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVKORFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVKORFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVKORFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:05:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964941AbVKORFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:05:18 -0500
Date: Tue, 15 Nov 2005 09:05:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
In-Reply-To: <29307.1132062707@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0511150901280.3945@g5.osdl.org>
References: <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org> 
 <dhowells1132005277@warthog.cambridge.redhat.com> <29307.1132062707@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Nov 2005, David Howells wrote:
>
> I don't think I have a need for both. Either I give you a cookie (for which
> there may be nothing in the cache); or I give you the "negative" cookie for
> which there's definitely nothing in the cache, and gracefully refuse to
> service it.
> 
> So, would you still rather I used NULL? If so, I can change it easily enough.

Yes, if you don't have real negative cookies, then just use NULL.

Think of malloc(). It doesn't return MALLOC_OUT_OF_MEMORY_COOKIE when it 
won't give you any more memory. It returns NULL.

The advantage of NULL is that people know what it is, and that the C 
language _defines_ that you can do "if (xyzzy)" to test for non-NULL. 
Conversely, the disadvantage of using a special cookie (that just happens 
to be NULL) is that the test for NULL still _works_, so now you have two 
ways of doing something and the compiler will never warn.

So in a very real sense, NULL _always_ exists. You can't make it go away 
by defining it to another name, and by using another name you just confuse 
things (if they are in fact the same).

		Linus
