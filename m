Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751724AbWF3JbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWF3JbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWF3JbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:31:10 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:7386 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751724AbWF3JbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:31:08 -0400
Date: Fri, 30 Jun 2006 11:31:14 +0200
From: Johann Lombardi <johann.lombardi@bull.net>
To: Daniel Phillips <phillips@google.com>,
       Andreas Dilger <adilger@clusterfs.com>, sho@tnes.nec.co.jp
Cc: cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
Message-ID: <20060630093113.GA2702@chiva>
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int> <44A417A3.80001@google.com> <20060629202700.GD5318@schatzie.adilger.int> <44A450BB.60105@google.com>
MIME-Version: 1.0
In-Reply-To: <44A450BB.60105@google.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/06/2006 11:35:11,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/06/2006 11:35:13,
	Serialize complete at 30/06/2006 11:35:13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >I have no objection to this at all, but I think it will lead to a slightly
> >more complex implementation.  We even discussed in the distant past to
> >make large directories a series of 4kB "chunks", for fs blocksize >= 4kB.
> >This has negative implications for large filenames because the internal
> >free space fragmentation is high, but has the advantage that it might
> >eventually still be usable if we can get blocksize > PAGE_SIZE.
> >
> >The difficulty is that when freeing dir entires you would have to be
> >concerned with a merging a dir_entry that is spanning the middle
> >of a 2^16 block.
> 
> That is easy, just don't let an entry span subblocks by not letting
> delete merge past the end of a subblock, just a minor tweak.  New block
> initialization needs an outer loop on subblocks and that's it, I think.

I've been working on a patch implementing this feature. It currently works w/o 
htree.
With dir_index, the difficulty is that an entry can span subblocks after a leaf
block split.

Cheers,

Johann
