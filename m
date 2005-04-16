Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVDPLGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVDPLGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 07:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVDPLGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 07:06:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262064AbVDPLGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 07:06:37 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1113604974.27810.75.camel@lade.trondhjem.org> 
References: <1113604974.27810.75.camel@lade.trondhjem.org>  <20050408223927.GA22217@kvack.org> <1112224663.18019.39.camel@lade.trondhjem.org> <1112309586.27458.19.camel@lade.trondhjem.org> <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org> <20050407114302.GA13363@infradead.org> <29082.1113581624@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Sat, 16 Apr 2005 12:06:10 +0100
Message-ID: <17024.1113649570@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> 
> AFAICS You grab the wait_queue_t lock once in down()/__mutex_lock()
> order to try to take the lock (or queue the waiter if that fails), then
> once more in order to pass the mutex on to the next waiter on
> up()/mutex_unlock(). That is more or less the exact same thing I was
> doing with iosems using bog-standard waitqueues, and which Ben has
> adapted to his mutexes. What am I missing?

In Ben's patch it looks like the down() grabs the spinlock twice. Once to
queue yourself and one to dequeue yourself. The up() grabs the spinlock once
to wake you up, but it wasn't obvious that it actually dequeues you.

David
