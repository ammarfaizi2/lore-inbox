Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTFBPkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbTFBPks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:40:48 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:55780 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262499AbTFBPko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:40:44 -0400
Date: Mon, 2 Jun 2003 17:53:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, matsunaga <matsunaga_kazuhisa@yahoo.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030602155353.GB679@wohnheim.fh-wedel.de>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de> <002901c32919$ddc37000$570486da@w0a3t0> <20030602153656.GA679@wohnheim.fh-wedel.de> <1054568407.20369.382.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1054568407.20369.382.camel@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 June 2003 16:40:07 +0100, David Woodhouse wrote:
> 
> mtdblock shouldn't actually be _using_ the vmalloc'd buffer for write
> caching in production at all. Anyone using mtdblock in write mode for
> production wants shooting.

Or any other form of lart.

> Perhaps we could get away with allocating it only when the device is
> opened for write? Even that's suboptimal since in 2.4, JFFS2 opens the
> mtdblock device for write but doesn't actually _write_ to it; just gets
> the appropriate MTD device and uses that directly.

Maybe lazy allocation.  vmalloc() it with the first write(), which
should be never in production use.  So the extra overhead doesn't
really matter.

Do you mind if I submit such a patch?

Jörn

-- 
Correctness comes second.
Features come third.
Performance comes last.
Maintainability is needed for all of them.
