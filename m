Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTJYQbb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 12:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTJYQbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 12:31:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18654 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262725AbTJYQb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 12:31:29 -0400
Date: Sat, 25 Oct 2003 18:31:28 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org, Alex Lyashkov <shadow@itt.net.ru>
Subject: Re: Linux 2.4 quota (accounting?) bug ...
Message-ID: <20031025163128.GA20786@atrey.karlin.mff.cuni.cz>
References: <20031025162640.GA24020@DUK2.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025162640.GA24020@DUK2.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> a friend of mine, made me aware of the following
> imbalance, which looks like a minor accounting bug 
> to me, but might be a quota bug ...
  Sorry but the code seems correct to me - we get reference to dquot by
get_dquot_ref() and than we put the reference by dqput(). dqput() is
correct because something nasty might happen in the mean time and so we
might be the last holders of the dquot. What do you think is wrong?

								Honza

> 
> fs/dquot.c : 394 vfs_quota_sync()
> -----------------------------------------------------
>                 /* Get reference to quota so it won't be invalidated. get_dquot_ref()
>                  * is enough since if dquot is locked/modified it can't be
>                  * on the free list */
> 
> > 		get_dquot_ref(dquot);
>  		if (dquot->dq_flags & DQ_LOCKED)
>  			wait_on_dquot(dquot);
>  		if (dquot_dirty(dquot))
>  			sb->dq_op->sync_dquot(dquot);
> >		dqput(dquot);
>  		goto restart;
>  	}
> 
> 
> best,
> Herbert
> 
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
