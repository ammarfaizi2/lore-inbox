Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWHYPha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWHYPha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWHYPha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:37:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50106 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964879AbWHYPh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:37:29 -0400
Subject: Re: [PATCH] BC: resource beancounters (v2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <44EF13BB.9030406@yahoo.com.au>
References: <44EC31FB.2050002@sw.ru>	<20060823100532.459da50a.akpm@osdl.org>
	 <44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>
	 <44EF13BB.9030406@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 16:57:14 +0100
Message-Id: <1156521434.3007.251.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-26 am 01:14 +1000, ysgrifennodd Nick Piggin:
> I still think doing simple accounting per-page would be a better way to
> go than trying to pin down all "user allocatable" kernel allocations.
> And would require all of about 2 hooks in the page allocator. And would
> track *actual* RAM allocated by that container.

You have a variety of kernel objects you want to worry about and they
have very differing properties.

Some are basically shared resources - page cache, dentries, inodes, etc
and can be balanced pretty well by the kernel (ok the dentries are a bit
of a problem right now). Others are very specific "owned" resources -
like file handles, sockets and vmas.

Tracking actual RAM use by container/user/.. isn't actually that
interesting. It's also inconveniently sub page granularity.

Its a whole seperate question whether you want a separate bean counter
limit for sockets, file handles, vmas etc.

Alan

