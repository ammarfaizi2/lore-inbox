Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbULVImW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbULVImW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbULVImV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:42:21 -0500
Received: from unthought.net ([212.97.129.88]:14825 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261934AbULVImD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:42:03 -0500
Date: Wed, 22 Dec 2004 09:41:58 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20041222084158.GG347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jan Kasprzak <kas@fi.muni.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221184304.GF16913@fi.muni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 07:43:04PM +0100, Jan Kasprzak wrote:
...
> : 
> : No, the problem I've fixed was related to XFS getting the inode version
> : number wrong - or at least different than NFSD expects.
> : 
> 	We have applied these two patches to 2.6.10-rc2, but this
> does not help. A few minutes ago I've got the "?----------" file
> again from my test script. This time it took >4 hours (it was
> about an hour or so without this patch).

I run the patch on 2.6.9 - it solved the problem in the common case.
Before the patch, I was unable to complete a "cvs checkout" of a
moderately large tree - would end up with undeletable directories and
lots of other weird things...  After the patch, I can run cvs checkout.

However, we still see the problem - so the patch does not solve this
completely, as you have observed as well.

Our most common situation is that a new file gets created as a symlink
pointing to itself, instead of as a regular file.

It also happens regularly, that a command (be it cvs, etags, ld or
something else) reports EINVAL when attempting to create/write a file.

So, status on my side is;  things still suck, but they suck less than on
vanilla 2.6.9

-- 

 / jakob

