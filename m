Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTIDW4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265622AbTIDW4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:56:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12941 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265406AbTIDW4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:56:48 -0400
Date: Thu, 4 Sep 2003 23:56:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix remap of shared read only mappings
Message-ID: <20030904225636.GN31590@mail.jlokier.co.uk>
References: <1062686960.1829.11.camel@mulgrave> <20030904214810.GG31590@mail.jlokier.co.uk> <1062714829.2161.384.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062714829.2161.384.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> However, POSIX does imply levels of cache coherence for both MAP_SHARED
> and MAP_PRIVATE:
> 
> With MAP_SHARED, any change to the underlying object after the mapping
> must become visible to the mapper (although the change may be delayed by
> local caching of the changer's implementation until it is explicitly
> flushed).
...
> So regardless of PROT_SEM we have no choice but to worry about cache
> coherence issues on MAP_SHARED mappings.

You have just argued _against_ worrying about cache coherence by
aligning mapping addresses.

Basically, POSIX says shared mappings aren't guanteed to be coherent
until you call msync().  Then you can just do whatever is needed to
make different views coherent.  That's easier now that we have rmap.

-- Jamie
