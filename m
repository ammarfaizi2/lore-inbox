Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTESMRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTESMRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:17:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62815 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262424AbTESMRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:17:10 -0400
To: Andi Kleen <ak@muc.de>
Cc: kraxel@suse.de, jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
References: <20030515145640.GA19152@averell>
	<m1of2233ds.fsf@frodo.biederman.org> <20030519103717.GC15709@averell>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 May 2003 06:26:01 -0600
In-Reply-To: <20030519103717.GC15709@averell>
Message-ID: <m1he7r2kdi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Sat, May 17, 2003 at 12:58:39AM +0200, Eric W. Biederman wrote:
> > I don't know if this affects the frame buffers per se.
> > 
> > But often BIOS's on systems with large amounts of memory configure
> > overlapping mtrrs (where an uncacheable mtrr would override a larger
> > cacheable range).  To date this has confused the linux mtrr code when
> > it tries to modify things, and you cannot properly setup mtrrs.    I
> > believe this applies to both the fb case as well as X.
> 
> Interesting. Perhaps it would be really better to use change_page_attr()
> with PAT for this. It would avoid these problems.

At least for x86-64 I would recommend that, as you can count on it existing.

For normal x86 it is more interesting.  But you are less likely to run with 
lots of memory so this case is less likely to show up. I have already heard
people seriously discussing 16GB on an off the shelf on an x86-64
system.  Getting 2GB PC2700 DIMMs is still a bit of a challenge, but
the practical memory size barrier (3GB per task) is finally gone.

For x86-64 a software ``mtrr'' that maps everything the e820 map says
is memory as write-back and everything else as uncacheable by default would
be nice.  As the mtrr interface is already understood by things like X.  And
there needs to be some data structure that remembers what the page
cache-ability attributes should be.

Eric
