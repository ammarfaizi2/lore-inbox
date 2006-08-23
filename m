Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWHWSab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWHWSab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWHWSab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:30:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:57030 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965098AbWHWSa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:30:29 -0400
Subject: Re: [Devel] [PATCH 6/6] BC: kernel memory accounting (marks)
From: Dave Hansen <haveblue@us.ibm.com>
To: devel@openvz.org
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rohit Seth <rohitseth@google.com>, Matt Helsley <matthltc@us.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <44EC371F.7080205@sw.ru>
References: <44EC31FB.2050002@sw.ru>  <44EC371F.7080205@sw.ru>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 11:30:20 -0700
Message-Id: <1156357820.12011.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still a bit concerned about if we actually need the 'struct page'
pointer.  I've gone through all of the users, and I'm not sure that I
see any that _require_ having a pointer in 'struct page'.  I think it
will take some rework, especially with the pagetables, but it should be
quite doable.

vmalloc:
	Store in vm_struct
fd_set_bits:
poll_get:
mount hashtable:
	Don't need alignment.  use the slab?
pagetables:
	either store in an extra field of 'struct page', or use the
	mm's.  mm should always be available when alloc/freeing a
	pagetable page

Did I miss any?

-- Dave

