Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTIATbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTIATbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:31:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62657 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263241AbTIATb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:31:29 -0400
Date: Mon, 1 Sep 2003 21:31:28 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [BUG] mtime&ctime updated when it should not
Message-ID: <20030901193128.GA26983@atrey.karlin.mff.cuni.cz>
References: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz> <20030901121807.29119055.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901121807.29119055.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@suse.cz> wrote:
> >
> >   Hello,
> > 
> >   one user pointed my attention to the fact that when the write fails
> > (for example when the user quota is exceeded) the modification time is
> > still updated (the problem appears both in 2.4 and 2.6). According to
> > SUSv3 that should not happen because the specification says that mtime
> > and ctime should be marked for update upon a successful completition
> > of a write (not that it would forbid updating the times in other cases
> > but I find it at least a bit nonintuitive).
> 
> hrm.  Doesn't sound super-important.  But..
  I agree that it is a minor problem...

> >   The easiest fix would be probably to "backup" the times at the
> > beginning of the write and restore the original values when the write
> > fails (simply not updating the times would require more surgery because
> > for example vmtruncate() is called when the write fails and it also
> > updates the times).
> >   So should I write the patch or is the current behaviour considered
> > correct?
> 
> Isn't this sufficient?
  I think it is not (I tried exactly the same patch but it didn't work)
- the problem is that vmtruncate() is called when prepare_write() fails
and this function also updates mtime and ctime.

								Honza
