Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271812AbTG2Qtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271828AbTG2Qtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:49:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62481 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271812AbTG2Qti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:49:38 -0400
Date: Tue, 29 Jul 2003 18:49:36 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: herbert@13thfloor.at
Subject: Re: Quota in 2.6.0-test2 broken ...
Message-ID: <20030729164936.GD20290@atrey.karlin.mff.cuni.cz>
References: <20030729160458.GA31881@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729160458.GA31881@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Quota is definitely broken in 2.6.0-test2 because the
> code tries to acquire dqio_sem in *_read_file_info, while
> already holding the same sem in vfs_quota_on, which
> simply deadlocks ...
  Huh I see. Actually only old quota format is affected by this bug
(that may be a reason why it went unnoticed for a while).

> removing the down(dqio_sem) in vfs_quota_on at least
> allows quota to be enabled 8-) but still deadlocks on 
> quota transfers? ... :(
  I'll have a look at this - I don't see a reason for this in a code.

> it seems this stuff hasn't been tested since the last
> update? doesn't anybody use quota anymore?
  When you have test machine you usually don't run a quota on it and
when you have machine with lots of users on it you won't use unstable
kernels. So I guess this is not a big wonder (I suppose the bugreports
for 2.6 quota code will start to appear soon ;).

								Honza
  
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
