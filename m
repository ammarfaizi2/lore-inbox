Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVDYKNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVDYKNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 06:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVDYKNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 06:13:13 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:60879 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262529AbVDYKNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 06:13:04 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mspec driver for 2.6.12-rc2-mm3
References: <16987.39773.267117.925489@jaguar.mkp.net>
	<20050412032747.51c0c514.akpm@osdl.org>
	<yq07jj8123j.fsf@jaguar.mkp.net>
	<20050413204335.GA17012@infradead.org>
	<yq08y3bys4e.fsf@jaguar.mkp.net>
	<20050424101615.GA22393@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 25 Apr 2005 06:13:01 -0400
In-Reply-To: <20050424101615.GA22393@infradead.org>
Message-ID: <yq03btftb9u.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

>>  The code use the size to calculate, it could be changed either
>> way, don't think it's worth making the change.

Christoph> The current code is obsufcated, see the pages-1 stuff and
Christoph> co.  Please change it.

Both ways work, this is down to nitpicking for the sake of
nitpicking. Whatever, I'll change it.

Christoph> Please don't use the ->nopage approach thenm but do
Christoph> remap_pfn_range beforehand.  ->nopage is very nice if the
Christoph> region is actually backed by normal RAM, but what you're
Christoph> doing doesn't make much sense.
>>  Thats what I used to think, however you want the node-local setup
>> for performance reasons. Otherwise I would have switched to
>> remap_pfn_range.

Christoph> Then fixup remap_pfn_range (or rather add a new _node
Christoph> variant).  The current code relies on deep magic to work
Christoph> and could be broken by a new kernel release easily.

Your approach doesn't work. This relies on first-touch to get
performance, remap_pfn_range_node wouldn't work.

Christoph> I'm pretty sure this was NACKed on the ia64 list, and SGI
Christoph> was told to do a more generic efi memmap walk.
>>  No the issue back then was that the driver just took the memory
>> and kept it to itself. The new approach exports it for other users.

Christoph> That comment doesn't make sense at all to me.  exports what
Christoph> to what other users.  And through what way.  Please bring
Christoph> this issue up on the ia64 list again.  (also please post
Christoph> this patch to linux-ia64, too)

mspec_alloc_page can be called from anywhere by anyone who wants to
allocate an uncached page. The old fetchop driver just took the
uncached memory and kept to itself. Thats what I am talking about!
Earlier versions of the patch has already been by the ia64 list, we're
down to details here.

Christoph> Jes, is it just me or are you trying to chicken out on all
Christoph> the real problems? :-)

It's you! I seems you're forgetting to do the real research before
trying to shoot something down ;-)

Cheers,
Jes
