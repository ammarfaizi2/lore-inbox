Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274246AbRISW6t>; Wed, 19 Sep 2001 18:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274245AbRISW6a>; Wed, 19 Sep 2001 18:58:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59478 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274244AbRISW60>; Wed, 19 Sep 2001 18:58:26 -0400
To: "Rob Fuller" <rfuller@nsisoftware.com>
Cc: "David S. Miller" <davem@redhat.com>, <alan@lxorguk.ukuu.org.uk>,
        <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2001 16:48:44 -0600
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com>
Message-ID: <m11yl2g5kj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rob Fuller" <rfuller@nsisoftware.com> writes:

> In my one contribution to this thread I wrote:
> 
> "One argument for reverse mappings is distributed shared memory or
> distributed file systems and their interaction with memory mapped files.
> For example, a distributed file system may need to invalidate a specific
> page of a file that may be mapped multiple times on a node."
> 
> I believe reverse mappings are an essential feature for memory mapped
> files in order for Linux to support sophisticated distributed file
> systems or distributed shared memory.  In general, this memory is NOT
> anonymous.  As such, it should not affect the performance of a
> fork/exec/exit.
> 
> I suppose I confused the issue when I offered a supporting argument for
> reverse mappings.  It's not reverse mappings for anonymous pages I'm
> advocating, but reverse mappings for mapped file data.

The reverse mapping issue is not do we have a way to find where in the page
tables a page is mapped.  But if we keep track of it in a data structure
that allows us to do so extremely quickly.  The worst case for our current
data structures to unmap one page is O(page mappings).

For distributed filesystems contention sucks.  No matter how you play it
contention for file data will never be a fast case.  Not if you have
very many people contending for the data.  So this isn't a fast case.

Additionally our current data structures are optimized for unmapping
page ranges.  Since if your contention case is sane you will be
grabbing more than 4k at a time our looping through the vm_areas of
a mapping should be more efficient than doing that loop once for
each page that needs to be unmapped.

Eric




