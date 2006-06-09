Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWFIWE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWFIWE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWFIWE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:04:59 -0400
Received: from thunk.org ([69.25.196.29]:20946 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750721AbWFIWE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:04:58 -0400
Date: Fri, 9 Jun 2006 18:04:41 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Michael Poole <mdpoole@troilus.org>, Gerrit Huizenga <gh@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609220441.GH10524@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Michael Poole <mdpoole@troilus.org>,
	Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com> <4489D36C.3010000@garzik.org> <20060609203523.GE10524@thunk.org> <4489EAFE.6090303@garzik.org> <87ac8matr2.fsf@graviton.dyn.troilus.org> <4489EDCA.5040808@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489EDCA.5040808@garzik.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 05:53:14PM -0400, Jeff Garzik wrote:
> Yes, it's not a small change to the on-disk format.
> 
> If you write tools that read an ext3 filesystem, you won't be able to 
> read file data at all, without updating your code.

Most tools that read an ext2/3 filesystem directly use the libext2fs
library, and it will definitely be the case that for files smaller
than 4TB, even on a filesystem with extents enabled, as long as you
are using a version of libext2fs which is extents-aware, it will work
without any changes.

For files larger than 4TB, we will need some kind of LFS-like
interface change (i.e., ext2fs_file_llseek64 vs. ext2fs_file_llseek),
but that should be the only change needed by the tool.

					- Ted
