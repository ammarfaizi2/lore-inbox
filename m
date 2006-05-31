Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWEaAkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWEaAkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWEaAkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:40:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9437 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932074AbWEaAky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:40:54 -0400
Date: Wed, 31 May 2006 10:40:22 +1000
From: David Chinner <dgc@sgi.com>
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Balbir Singh <balbir@in.ibm.com>
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists V3
Message-ID: <20060531004022.GM8069029@melbourne.sgi.com>
References: <20060526023536.GN8069029@melbourne.sgi.com> <4de7f8a60605300753j3b1e257u3849b72e7bc4d100@mail.gmail.com> <20060530150438.GB4377@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530150438.GB4377@hasse.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 05:04:38PM +0200, Jan Blunck wrote:
> > David Chinner <dgc@sgi.com> wrote:
> > -
> > void shrink_dcache_sb(struct super_block * sb)
> > {
....
> > +       __shrink_dcache_sb(sb, &sb->s_dentry_lru_nr, 0);
> > }
> 
> This doesn't prune all the dentries on the unused list. The parents of the
> pruned dentries are added to the unused list. Therefore just shrinking
> sb->s_dentry_lru_nr dentries isn't enough.

Yes, you are right, Jan. I'm surprised I didn't see problems due to this.
The original patch got this right by shrinking in this case until the list
was empty. I'll wrap this one in a while loop...

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
