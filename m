Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWFOGlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWFOGlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWFOGlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:41:15 -0400
Received: from thunk.org ([69.25.196.29]:9105 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932448AbWFOGlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:41:14 -0400
Date: Thu, 15 Jun 2006 00:43:02 -0400
From: Theodore Tso <tytso@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060615044302.GA7318@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <E1Foqjw-00010e-Ln@candygram.thunk.org> <20060614181627.B28144@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614181627.B28144@openss7.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 06:16:27PM -0600, Brian F. G. Bidulock wrote:
> > 3) Move i_pipe, i_bdev, and i_cdev into a union.  An inode cannot
> >     simultaneously be a pipe, block device, and character device at the
> >     same time.
> 
> A STREAMS-based FIFO is both a (named) pipe and a character device at the
> same time.  I would prefer if you did not merge i_pipe with i_cdev for this
> reason.  In the current GPL'ed out of tree STREAMS implementation, i_pipe
> is used to point to the Stream head (as the normal v_str pointer in the UNIX
> vnode).  

I'm not particularly sympathetic to out of tree implementations,
especially one which is as (NOT!) likely to be merged as STREAMS
support.  Out of tree patches can always patch struct inode to add all
the bloat they want.  Also, it souinds like you're not usually using
i_pipe as a true pointer to a struct pipe_inode_info, but rather as
kludged location to stash your v_str pointer.  Why not just have your
STREAMS implementation patch include/linux/fs.h to add a v_str pointer?

						- Ted
