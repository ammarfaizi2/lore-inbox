Return-Path: <linux-kernel-owner+w=401wt.eu-S964895AbWLMCSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWLMCSl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWLMCSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:18:41 -0500
Received: from pat.uio.no ([129.240.10.15]:50729 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964895AbWLMCSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:18:40 -0500
X-Greylist: delayed 1842 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 21:18:40 EST
Subject: Re: Status of buffered write path (deadlock fixes)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
In-Reply-To: <457F4EEE.9000601@yahoo.com.au>
References: <45751712.80301@yahoo.com.au>
	 <20061207195518.GG4497@ca-server1.us.oracle.com>
	 <4578DBCA.30604@yahoo.com.au>
	 <20061208234852.GI4497@ca-server1.us.oracle.com>
	 <457D20AE.6040107@yahoo.com.au> <457D7EBA.7070005@yahoo.com.au>
	 <20061212223109.GG6831@ca-server1.us.oracle.com>
	 <457F4EEE.9000601@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 20:47:38 -0500
Message-Id: <1165974458.5695.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.647, required 12,
	autolearn=disabled, AWL 1.22, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 11:53 +1100, Nick Piggin wrote:

> Not silly -- I guess that is the main sticking point. Luckily *most*
> !uptodate pages will be ones that we have newly allocated so will
> not be in pagecache yet.
> 
> If it is in pagecache, we could do one of a number of things: either
> remove it or try to bring it uptodate ourselves. I'm not yet sure if
> either of these actions will cause other problems, though :P
> 
> If both of those are really going to cause problems, then we could
> solve this in a more brute force way (assuming that !uptodate, locked
> pages, in pagecache at this point are very rare -- AFAIKS these will
> only be caused by IO errors?). We could allocate another, temporary
> page and copy the contents into there first, then into the target
> page after the prepare_write.

We are NOT going to mandate read-modify-write behaviour on
prepare_write()/commit_write(). That would be a completely unnecessary
slowdown for write-only workloads on NFS.

Trond

