Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbTIDWea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265634AbTIDWea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:34:30 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:26373 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265631AbTIDWeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:34:01 -0400
Subject: Re: [PATCH] fix remap of shared read only mappings
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904214810.GG31590@mail.jlokier.co.uk>
References: <1062686960.1829.11.camel@mulgrave> 
	<20030904214810.GG31590@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Sep 2003 18:33:48 -0400
Message-Id: <1062714829.2161.384.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 17:48, Jamie Lokier wrote:
> One last thought: this is what PROT_SEM is for.  Linux doesn't use
> this in any useful way.  But, technically, mmap with MAP_SHARED ad
> PROT_SEM should enable cache coherence, and that might include
> aligning the address.  Without PROT_SEM an application should not rely
> on cache coherence.

I'm not familiar with the PROT_SEM flag.  I don't believe it to be
defined in POSIX.

However, POSIX does imply levels of cache coherence for both MAP_SHARED
and MAP_PRIVATE:

With MAP_SHARED, any change to the underlying object after the mapping
must become visible to the mapper (although the change may be delayed by
local caching of the changer's implementation until it is explicitly
flushed).

With MAP_PRIVATE it is undefined what happens if the underlying object
is changed after mapping.

So regardless of PROT_SEM we have no choice but to worry about cache
coherence issues on MAP_SHARED mappings.

James


