Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTESXln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTESXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:41:43 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12711 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261906AbTESXlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:41:42 -0400
Date: Mon, 19 May 2003 19:54:41 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200305192354.h4JNsfQ09659@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <mailman.1053352200.24653.linux-kernel2news@redhat.com>
References: <200305191337.h4JDbf311387@oboe.it.uc3m.es> <mailman.1053352200.24653.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Let's quote the example from rubini & corbet of the sbull block device
>> driver. The request function ends like so:
> 
> defective locking in a driver is no excuse to pamper over it with
> recusrive shite.

Arjan is a little too harsh here, but on the principle I happen
to agree, because I worked with systems which allow recursive locks.
They very often cover up for programmer's lack of basic understanding.
Worse, sometimes even experienced programmers can do poorly.
I ran into the latter cathegory of code when fixing so-called
"presto" in Solaris (now replaced by Encore-originated code).

Normal spinlocks are not without problems, in particular people
tend to write:

   void urb_rm_priv_locked(struct urb *) {
     ......
   }
   void urb_rm_priv(struct urb *u) {
     spin_lock_irqsave();
     urb_rm_prin_locked(u);
     spin_unlock_irqrestore();
   }

Which eats a stack frame. We make this tradeoff on purpose,
as a lesser evil.

BTW, I do not see Linus and his leutenants rebuking the onslaught
of recursive ingenuity in this thread. Ignoring the hogwash,
or waiting and watching?

-- Pete
