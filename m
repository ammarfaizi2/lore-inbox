Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbTIBNHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 09:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbTIBNHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 09:07:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6631 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261874AbTIBNHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 09:07:07 -0400
Date: Tue, 2 Sep 2003 15:06:58 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [BUG] mtime&ctime updated when it should not
Message-ID: <20030902130657.GB30594@atrey.karlin.mff.cuni.cz>
References: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz> <20030901121807.29119055.akpm@osdl.org> <20030901193128.GA26983@atrey.karlin.mff.cuni.cz> <20030901125830.6f8d8f04.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901125830.6f8d8f04.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@suse.cz> wrote:
> >
> >  > Isn't this sufficient?
> >    I think it is not (I tried exactly the same patch but it didn't work)
> >  - the problem is that vmtruncate() is called when prepare_write() fails
> >  and this function also updates mtime and ctime.
> 
> Oh OK.
> 
> So we would need to change each filesystem's ->truncate to not update the
> inode times, then move the timestamp updating up into vmtruncate().
  That is one solution. The other (less intrusive) is to just store old
time stamps and restore times when you find out that write failed.
  I'll have a look how much work would be your solution..

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
> Jan Kara <jack@suse.cz> wrote:
> >
> >  > Isn't this sufficient?
> >    I think it is not (I tried exactly the same patch but it didn't work)
> >  - the problem is that vmtruncate() is called when prepare_write() fails
> >  and this function also updates mtime and ctime.
> 
> Oh OK.
> 
> So we would need to change each filesystem's ->truncate to not update the
> inode times, then move the timestamp updating up into vmtruncate().
  That is one solution. The other (less intrusive) is to just store old
time stamps and restore times when you find out that write failed.
  I'll have a look how much work would be your solution..

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
