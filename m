Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVCHLuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVCHLuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVCHLuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:50:20 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17388 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261975AbVCHLqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:46:31 -0500
Date: Tue, 8 Mar 2005 11:45:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/swap_state.c: unexport swapper_space
In-Reply-To: <20050308090943.A26847@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0503081125110.7085@goblin.wat.veritas.com>
References: <20050306144758.GJ5070@stusta.de> 
    <Pine.LNX.4.61.0503061515200.19898@goblin.wat.veritas.com> 
    <20050306224912.GE5827@infradead.org> 
    <20050308090943.A26847@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Russell King wrote:
> On Sun, Mar 06, 2005 at 10:49:12PM +0000, Christoph Hellwig wrote:
> > I disagree.  swapper_state is far too much of an internal detail to be
> > exported.  I argued that way when page_mapping was changed to use it and
> > that's why the architectures moved their helpers out of line.
> > Looks like the exported unfortunately got added anyway although we settled
> > that discussion.
> 
> Well, since ARM's usage of page_mapping() is out of line

ARM is out of line, again?

> (which is where it'll now stay) I think Christoph is correct.

Oh, I misunderstood you, sorree ;)

> Maybe this is something which should be aired on linux-arch
> for the other arch maintainers?

I've heard of that, I got the impression we're discouraged from
mailing it.  This is probably too minor to engage their attention.

Currently there is no arch using page_mapping in its header files,
presumably they were all forced out of line at that time.  I think
it's wrong to bump people into rearranging their code to get around
a missing export, but if you're happy with the status quo, so be it.

I expect Christoph and I would agree that what's really wrong is
for page_mapping to be referring to that strange implementation
detail swapper_space at all.  I'd say the export should remain so
long as the reference remains, to avoid post-release surprises
like last time; but I've had my say, que sera sera.

Hugh
