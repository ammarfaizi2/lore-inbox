Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWBXQaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWBXQaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWBXQaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:30:10 -0500
Received: from thunk.org ([69.25.196.29]:6369 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932366AbWBXQaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:30:08 -0500
Date: Fri, 24 Feb 2006 11:29:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sam Vilain <sam@vilain.net>
Cc: Xin Zhao <uszhaoxin@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: question about possibility of data loss in Ext2/3 file system
Message-ID: <20060224162957.GA22097@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Sam Vilain <sam@vilain.net>, Xin Zhao <uszhaoxin@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com> <1140645651.2979.79.camel@laptopd505.fenrus.org> <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com> <20060223045836.GC9645@thunk.org> <43FE1110.1030707@vilain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE1110.1030707@vilain.net>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 08:46:24AM +1300, Sam Vilain wrote:
> Theodore Ts'o wrote:
> >>Also, the scheme you mentioned is just for new file creation. What
> >>will happen if I want to update an existing file? Say, I open file A,
> >>seek to offset 5000, write 4096 bytes, and then close. Do you know how
> >>ext2/3 handle this situation?
> >If you have a power failure right after the close, the data could be
> >lost.  This is true for pretty much all Unix filesystems, for
> >performance reasons.  If you care about the data hitting disk, the
> >application must use fsync().  
> 
> I always liked Sun's approach to this in Online Disk Suite - journal at 
> the block device level rather than the FS / application level. 
> Something I haven't seen from the Linux md-utils or DM.

You can do data block journalling in ext3.  But the performance impact
can be significant for some work loads.   TNSFAAFL.

						- Ted
