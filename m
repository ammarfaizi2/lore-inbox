Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUC2OTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 09:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUC2OTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 09:19:33 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:22790 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262506AbUC2OTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 09:19:32 -0500
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       areiter@preventsys.com, rmk+serial@arm.linux.org.uk, tytso@mit.edu
Subject: Re: Subject: Re: NULL pointer in proc_pid_stat -- oops.
References: <1080524145.2233.1877.camel@cube>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 29 Mar 2004 23:18:47 +0900
In-Reply-To: <1080524145.2233.1877.camel@cube>
Message-ID: <87d66vd9dk.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> writes:

> >  if (task->tty) {
> >   tty_pgrp = task->tty->pgrp;
> >   tty_nr = new_encode_dev(tty_devnum(task->tty));
> >  }
> >
> > Some place doesn't take the any lock for ->tty.
> > I think we need to take the lock for ->tty.
> 
> Probably this isn't the thing for 2.6.xx,

Ah, sorry for confusing. This is 2.6.x (maybe also 2.4.x).

e.g. the above take the task_lock(). But disassociate_ctty() just take
read_lock(&tasklist_lock), etc. etc. So looks like racy.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
