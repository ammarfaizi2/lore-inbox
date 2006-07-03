Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWGCOCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWGCOCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWGCOCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:02:43 -0400
Received: from thunk.org ([69.25.196.29]:14052 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750906AbWGCOCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:02:42 -0400
Date: Mon, 3 Jul 2006 10:02:17 -0400
From: Theodore Tso <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 7/8] inode-diet: Use a union for i_blocks and i_size, i_rdev and i_devices
Message-ID: <20060703140217.GA8099@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060703005333.706556000@candygram.thunk.org> <20060703010023.720991000@candygram.thunk.org> <20060703090642.GB8242@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703090642.GB8242@infradead.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 10:06:42AM +0100, Christoph Hellwig wrote:
> On Sun, Jul 02, 2006 at 08:53:40PM -0400, Theodore Ts'o wrote:
> > The i_blocks and i_size fields are only used for regular files.  So we
> > move them into the union, along with i_rdev and i_devices, which are
> > only used by block or character devices.
> 
> Can we please make this a named instead of unnamed union so everyone still
> using the fields will trip up?  To reduce the impact a few more imajor/iminor
> conversions might be needed were direct references to i_rdev crept back in.

I did that originally but when I sent out my first version of patches
for review, other developers asked me to use an unnamed union ---
since otherwise the patch would be much, much larger (lots of changes
would need to be made) and that makes it much harder to merge into
either Andrew's or Linus's tree.

What do other people think?  I can go either way on this one.

							- Ted
