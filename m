Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbUKOLoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbUKOLoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUKOLoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:44:39 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:39015 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261570AbUKOLoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:44:37 -0500
Message-ID: <419896A1.50605@yahoo.com.au>
Date: Mon, 15 Nov 2004 22:44:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 iSeries: don't share request queues in viocd
References: <20041115165357.2e738704.sfr@canb.auug.org.au> <20041115113410.GA14471@infradead.org>
In-Reply-To: <20041115113410.GA14471@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Nov 15, 2004 at 04:53:57PM +1100, Stephen Rothwell wrote:
> 
>>Hi Andrew,
>>
>>This patch fixes the virtual cdrom driver to not share a single request
>>queue.  Sharing the queue causes an oops if you remove the module and more
>>than one cdrom exists.
> 
> 
> Maybe you should fix that underlying bug?  Queues are supposed to be
> shareable.
> 

I think shared queues are actually quite fundamentally broken at the
moment (as pointed out to me by Al). It stems from the refcounting /
conceptual relationship between a gendisk and a queue (I think - been
a while since I looked at the code).

I had something which just about fixed it up except that I couldn't
work out an appropriate place and name for the "queue" in the sysfs
hierarcy (IIRC I just had it as a sequentially increasing number, in
/sys/block/).

It is a relationship that I don't think sysfs can capture very well:
queues are shared between multiple other objects, but they have no
meaning outside the context of one of these objects.
