Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUCCSok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 13:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbUCCSok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 13:44:40 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:15103 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261720AbUCCSoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 13:44:39 -0500
Date: Wed, 03 Mar 2004 12:44:07 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <14140000.1078339447@[10.1.1.4]>
In-Reply-To: <20040303183901.GU4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random>
 <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]>
 <20040303165746.GO4922@dualathlon.random> <10500000.1078333658@[10.1.1.4]>
 <20040303183901.GU4922@dualathlon.random>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, March 03, 2004 19:39:01 +0100 Andrea Arcangeli
<andrea@suse.de> wrote:

>> What we've actually discussed before was more along the lines of
>> PG_locked to match VM_LOCKED, but the main idea was to be able to skip
>> over ineligible pages without having ot look up their mappings during
>> pageout.
> 
> I'm not very excited using PG_locked for that, that doesn't only mean
> "unswappable", it means also that the page is under I/O (or uner some
> other operation that needs serialization like unmapping the page) which
> is quite a different concept from VM_LOCKED. a wait_on_page would
> deadlock on such a PG_locked page, while wait_on_page on a page of a
> mlocked vma doesn't normally deadlock.
> 
> But I see what you want to do here, and PG_reserved would be too much
> for that since it changes the semantics for cow and free_pages, but
> PG_locked doesn't look good enough either, the VM_LOCKED and PG_locked
> concept is quite different, PG_reserved and VM_RESERVED is quite close
> instead (except for the page->count accounting).

Sorry, I misspoke.  I didn't mean the current PG_locked.  I meant a new
flag, or more probably a counter, that represents all the VM_LOCKED regions
a page is in.

Dave McCracken

