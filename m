Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269645AbUJMHYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269645AbUJMHYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 03:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269647AbUJMHYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 03:24:33 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:26257 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269645AbUJMHYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 03:24:23 -0400
Date: Wed, 13 Oct 2004 17:23:53 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-xfs@oss.sgi.com
Subject: Re: Page cache write performance issue
Message-ID: <20041013172352.B4917536@wobbly.melbourne.sgi.com>
References: <20041013054452.GB1618@frodo> <20041012231945.2aff9a00.akpm@osdl.org> <20041013063955.GA2079@frodo> <20041013000206.680132ad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041013000206.680132ad.akpm@osdl.org>; from akpm@osdl.org on Wed, Oct 13, 2004 at 12:02:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 12:02:06AM -0700, Andrew Morton wrote:
> 
> Well something else if fishy: how can you possibly achieve only 4MB/sec? 

These are 1K writes too remember, so it feels a bit like we
write 'em out one at a time, sync (though no O_SYNC, or fsync,
or such involved here).  This is on an i686, so 4K pages, and
using 4K filesystem blocksizes (both xfs and ext2).

And now that you mention, yes, this is multiple times below
the direct IO numbers too (which on this box are ~30MB/sec
for direct blkdev writes, IIRC, & XFS has similar numbers).

> Using floppy disks or something?

Heh, uh, no.  (and no, not "pencils" either ;)

> Does the same happen on ext2?

Yes.

> It's exactly a 500MB write on a 1000MB machine, yes?

Thats correct.

No slab/page/.. debug options enabled either - its the same
.config that was performing ~10x better on 2.6.8.  I also
verified that it wasn't any of the XFS changes either (they
wouldn't have affected ext2 anyway, of course) - the same
XFS code backported to 2.6.8 performs fine also.

cheers.

-- 
Nathan
