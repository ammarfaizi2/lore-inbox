Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUC2BbL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 20:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUC2BbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 20:31:11 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:22481 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262549AbUC2BbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 20:31:00 -0500
Subject: Subject: Re: NULL pointer in proc_pid_stat -- oops.
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: hirofumi@mail.parknet.co.jp, areiter@preventsys.com,
       rmk+serial@arm.linux.org.uk, tytso@mit.edu
Content-Type: text/plain
Organization: 
Message-Id: <1080524145.2233.1877.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Mar 2004 20:35:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And from the oops trace output (that is attached), we can
>> see that %edx is 0x0; so we can easily see here why we're
>> crashing at least.  After examining the C source, I see
>> that we're dying in the call to task_name() (inline) from
>> proc_pid_stat().
>
> Looks like this problem is same with BSD acct Oops.
>
>  if (task->tty) {
>   tty_pgrp = task->tty->pgrp;
>   tty_nr = new_encode_dev(tty_devnum(task->tty));
>  }
>
> Some place doesn't take the any lock for ->tty.
> I think we need to take the lock for ->tty.

Probably this isn't the thing for 2.6.xx, but how
about a special tty struct instead of the NULL?
Make it const, perhaps write-protected, etc.

Then the if(task->tty) test can be removed.


