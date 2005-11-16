Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVKPQFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVKPQFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVKPQFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:05:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:49369 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030381AbVKPQFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:05:18 -0500
Subject: Re: [RFC] sys_punchhole()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, andrea@suse.de, hugh@veritas.com,
       lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <1131686314.2833.0.camel@laptopd505.fenrus.org>
References: <1131664994.25354.36.camel@localhost.localdomain>
	 <1131686314.2833.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 08:05:06 -0800
Message-Id: <1132157106.24066.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 06:18 +0100, Arjan van de Ven wrote:
> On Thu, 2005-11-10 at 15:23 -0800, Badari Pulavarty wrote:
> > 
> > We discussed this in madvise(REMOVE) thread - to add support 
> > for sys_punchhole(fd, offset, len) to complete the functionality
> > (in the future).
> 
> in the past always this was said to be "really hard" in linux locking
> wise, esp. the locking with respect to truncate...
> 
> did you find a solution to this problem ?

I have been thinking about some of the race condition we might run into.
Its hard to think all of them, when I really don't have any code to play
with :(

Anyway, I think race against truncate is fine. We hold i_alloc_sem -
which should serialize against truncates. This should also serialize
against DIO. Holding i_sem should take care of writers.

One concern I can think of is, racing with read(2). While we are
thrashing pagecache and calling filesystem to free up the blocks - 
a read(2) could read old disk block and give old data (since it won't
find it in pagecache). This could become a security hole :(

Thanks,
Badari

