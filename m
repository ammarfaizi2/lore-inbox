Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSJHSR1>; Tue, 8 Oct 2002 14:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbSJHSR1>; Tue, 8 Oct 2002 14:17:27 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:45065 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261354AbSJHSR0>; Tue, 8 Oct 2002 14:17:26 -0400
Date: Tue, 8 Oct 2002 19:23:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 2/4] Add extended attributes to ext2/3
Message-ID: <20021008192306.B12912@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <E17yymE-00021l-00@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17yymE-00021l-00@think.thunk.org>; from tytso@mit.edu on Tue, Oct 08, 2002 at 02:08:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 02:08:14PM -0400, tytso@mit.edu wrote:
> 
> This is the second of four patches which add extended attribute support
> to the ext2 and ext3 filesystems.  Please comment and bleed.
> 
> This patch creates a meta block cache which is utilized by the ext3 and
> ext2 extended attribute patch (patches 3 and 4, respectively).  This
> cache allows directory blocks to be indexed by multiple keys.  In the
> case of the extended attribute patches, it is used to look up blocks by
> both the block number and by the hash of the extended attributes.  This
> is extremely important to allow the sharing of acl's when stored as
> extended attributes.  Otherwise every single file would require its own,
> separate, one block overhead to store then ACL, even though there might
> be a large number of files that have the same ACL.

The code doesn't really make æny sense outside ext2/ext3. I'd suggest you
move it there instead of bloating every kernel with it unconditionally.

__mb_cache_entry_in_lru() is buggy and can't work anymore now that akpm removed
some list_head debugging.

And please get rid of the LINUX_VERSION_CODE checks..

