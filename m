Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbTCGXo2>; Fri, 7 Mar 2003 18:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbTCGXo2>; Fri, 7 Mar 2003 18:44:28 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:19207 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261877AbTCGXoZ>; Fri, 7 Mar 2003 18:44:25 -0500
Date: Fri, 7 Mar 2003 23:54:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Christoph Hellwig <hch@infradead.org>, cherry@osdl.org, rddunlap@osdl.org,
       Joel.Becker@oracle.com, greg@kroah.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030307235454.A19662@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, cherry@osdl.org, rddunlap@osdl.org,
	Joel.Becker@oracle.com, greg@kroah.com, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307225517.GF2835@ca-server1.us.oracle.com> <20030307225710.A18005@infradead.org> <20030307151744.73738fdd.rddunlap@osdl.org> <1047080297.10926.180.camel@cherrytest.pdx.osdl.net> <20030307233636.A19260@infradead.org> <20030307154624.12105fa3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030307154624.12105fa3.akpm@digeo.com>; from akpm@digeo.com on Fri, Mar 07, 2003 at 03:46:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:46:24PM -0800, Andrew Morton wrote:
> Christoph, it would help this discussion very much if you could tell everyone
> how we should set about solving the many-disks problem.  In detail.

Just use blk_register_region() to claim the region you want, you
don't have to care for any major/minor binary.  There is not much of
the dev_t space used for block devices at all so there's no problem.

Actually coordinating those allocations with LANANA might help to not
step other people on their feet, but your return value will tell that
anyway.

