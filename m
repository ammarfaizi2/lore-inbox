Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTJYQ0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 12:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTJYQ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 12:26:42 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:17330 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262707AbTJYQ0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 12:26:41 -0400
Date: Sat, 25 Oct 2003 18:26:40 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, Alex Lyashkov <shadow@itt.net.ru>
Subject: Linux 2.4 quota (accounting?) bug ...
Message-ID: <20031025162640.GA24020@DUK2.13thfloor.at>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, Alex Lyashkov <shadow@itt.net.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Honza!

a friend of mine, made me aware of the following
imbalance, which looks like a minor accounting bug 
to me, but might be a quota bug ...

fs/dquot.c : 394 vfs_quota_sync()
-----------------------------------------------------
                /* Get reference to quota so it won't be invalidated. get_dquot_ref()
                 * is enough since if dquot is locked/modified it can't be
                 * on the free list */

> 		get_dquot_ref(dquot);
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
 		if (dquot_dirty(dquot))
 			sb->dq_op->sync_dquot(dquot);
>		dqput(dquot);
 		goto restart;
 	}


best,
Herbert


