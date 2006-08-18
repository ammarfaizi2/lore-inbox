Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWHRUdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWHRUdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWHRUdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:33:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5254 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161096AbWHRUdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:33:42 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, rohitseth@google.com,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, Andi Kleen <ak@suse.de>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1155929523.12204.32.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <1155835003.14617.45.camel@galaxy.corp.google.com> <44E57FB4.8090905@sw.ru>
	 <1155913165.28764.6.camel@localhost.localdomain>
	 <1155929523.12204.32.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 21:52:50 +0100
Message-Id: <1155934370.31543.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 12:32 -0700, ysgrifennodd Dave Hansen:
> > It ought to be cheap. Given each set of page structs is an array its a
> > simple subtract and divide (or with care and people try to pack them
> > nicely for cache lines - shift) to get to the parallel accounting array.
> 
> I wish page structs were just a simple array. ;)

Note I very carefully said "each set of"

> It will just be a bit more code, but we'll need this for the two other
> memory models: sparsemem and discontigmem.  For discontig, we'll just
> need pointers in the pg_data_ts and, for sparsemem, we'll likely need
> another pointer in the 'struct mem_section'.

Actually I don't believe this is true in either case. Change the code
which allocates the page arrays to allocate (+ sizeof(void *) *
pages_in_array on the end of each array when using UBC. The rest then
seems to come out naturally.

Alan

