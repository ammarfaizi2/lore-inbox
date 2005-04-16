Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVDPLMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVDPLMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 07:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVDPLMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 07:12:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5023 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262209AbVDPLMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 07:12:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050415234213.GC11761@kvack.org> 
References: <20050415234213.GC11761@kvack.org>  <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org> <20050407114302.GA13363@infradead.org> <29082.1113581624@redhat.com> <1113604974.27810.75.camel@lade.trondhjem.org> 
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Sat, 16 Apr 2005 12:12:08 +0100
Message-ID: <17130.1113649928@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:

> 
> What about the use of atomic operations on frv?  Are they more lightweight 
> than a semaphore, making for a better fastpath?

What do you mean? Atomic ops don't compare to semaphores.

On FRV atomic ops don't disable interrupts; they reserve one of the eight
conditional execution flags at compile time and that flag is cleared by entry
to an exception, thus aborting the write instruction. See:

	Documentation/fujitsu/frv/atomic-ops.txt

I could try and improve the fastpath on the semaphores for FRV - and perhaps
should - but I implemented the semaphores before I'd thought of the clever way
to do atomic ops.

David
