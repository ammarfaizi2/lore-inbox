Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934223AbWLDG22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934223AbWLDG22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 01:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934202AbWLDG22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 01:28:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933840AbWLDG21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 01:28:27 -0500
Date: Sun, 3 Dec 2006 22:28:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: wcheng@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
Message-Id: <20061203222816.aaef93a3.akpm@osdl.org>
In-Reply-To: <4573B8DE.20205@redhat.com>
References: <4564C28B.30604@redhat.com>
	<20061122153603.33c2c24d.akpm@osdl.org>
	<456B7A5A.1070202@redhat.com>
	<20061127165239.9616cbc9.akpm@osdl.org>
	<456CACF3.7030200@redhat.com>
	<20061128162144.8051998a.akpm@osdl.org>
	<456D2259.1050306@redhat.com>
	<456F014C.5040200@redhat.com>
	<20061201132329.4050d6cd.akpm@osdl.org>
	<45730E36.10309@redhat.com>
	<20061203124752.15e35357.akpm@osdl.org>
	<4573B8DE.20205@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2006 00:57:50 -0500
Wendy Cheng <wcheng@redhat.com> wrote:

> >  
> >
> >>>Did you look at improving that lock-lookup algorithm, btw?  Core kernel has
> >>>no problem maintaining millions of cached VFS objects - is there any reason
> >>>why your lock lookup cannot be similarly efficient?
> >>> 
> >>>      
> >>>
> Yes, just found the new DLM uses "jhash" call (include/linux/jhash.h). 
> I'm on an older version of DLM that uses FNV hash algorithm 
> (http://www.isthe.com/chongo/tech/comp/fnv/). Will do some performance 
> test runs to compare these two methods.

I'd be surprised if the choice of hash algorithm itself makes much difference.
But we can't say much about it unless we can see the code (ie: your code).

Is it a simple old hash-to-find-the-bucket-then-walk-a-list implementation?
If so, what does the bucket count distribution look like?  What is the average
walk length?  Does it use a single lock, or hashed locking, or a lock-per-bucket?

etc.
