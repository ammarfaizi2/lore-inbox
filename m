Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261936AbSJNQKu>; Mon, 14 Oct 2002 12:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261945AbSJNQKt>; Mon, 14 Oct 2002 12:10:49 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:31502 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261936AbSJNQKs>; Mon, 14 Oct 2002 12:10:48 -0400
Date: Mon, 14 Oct 2002 17:16:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Clark <michael@metaparadigm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014171639.C19897@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Clark <michael@metaparadigm.com>,
	Mark Peloquin <markpeloquin@hotmail.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	evms-devel@lists.sourceforge.net
References: <Pine.GSO.4.21.0210131243480.9247-100000@steklov.math.psu.edu> <3DA9B05F.8000600@metaparadigm.com> <20021014044355.GQ3045@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014044355.GQ3045@clusterfs.com>; from adilger@clusterfs.com on Sun, Oct 13, 2002 at 10:43:55PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 10:43:55PM -0600, Andreas Dilger wrote:
> I never did get a clear understanding why Christoph wants access to
> "intermediate" block devices from EVMS, except for the ioctl issue.

It's not really the userspace access that matters (it comes for free
when doing it properly) but more that I want to avoid duplicating
kernel-internal data structures and code.  Just look at ldev_mgr.c
in the evms source code and see how much simpler it would get if we
merged struct evms_logical_node (and it's members) into struct gendisk and
struct block_device - sure that's not a trivial task, but it'll pay
out in the long term.

> It's like "ls -l" showing you each and every block that makes up a file,
> or "ps aux"

It's more like ps aux showing you all threads of a multithreaded
process.  Yes, people have turned it off now, but you really want
to be able to see it without doing hacks.

