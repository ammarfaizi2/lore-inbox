Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTIHNZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbTIHNY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51933 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262321AbTIHNYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:04 -0400
Date: Sat, 6 Sep 2003 10:05:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: [BUG] mtime&ctime updated when it should not
Message-ID: <20030906080543.GA3944@openzaurus.ucw.cz>
References: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz> <20030901121807.29119055.akpm@osdl.org> <20030901193128.GA26983@atrey.karlin.mff.cuni.cz> <20030901125830.6f8d8f04.akpm@osdl.org> <20030902130657.GB30594@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902130657.GB30594@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  > Isn't this sufficient?
> > >    I think it is not (I tried exactly the same patch but it didn't work)
> > >  - the problem is that vmtruncate() is called when prepare_write() fails
> > >  and this function also updates mtime and ctime.
> > 
> > Oh OK.
> > 
> > So we would need to change each filesystem's ->truncate to not update the
> > inode times, then move the timestamp updating up into vmtruncate().
>   That is one solution. The other (less intrusive) is to just store old
> time stamps and restore times when you find out that write failed.

What if userspace sees the new time for a short while? That would certainly be
a bug...
				Pavel

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

