Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbTESXuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTESXuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:50:39 -0400
Received: from quattro.sventech.com ([205.252.248.110]:27365 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id S262289AbTESXug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:50:36 -0400
Date: Mon, 19 May 2003 20:03:35 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030519200335.H13617@sventech.com>
References: <200305191337.h4JDbf311387@oboe.it.uc3m.es> <mailman.1053352200.24653.linux-kernel2news@redhat.com> <200305192354.h4JNsfQ09659@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305192354.h4JNsfQ09659@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, May 19, 2003 at 07:54:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003, Pete Zaitcev <zaitcev@redhat.com> wrote:
> >> Let's quote the example from rubini & corbet of the sbull block device
> >> driver. The request function ends like so:
> > 
> > defective locking in a driver is no excuse to pamper over it with
> > recusrive shite.
> 
> Arjan is a little too harsh here, but on the principle I happen
> to agree, because I worked with systems which allow recursive locks.
> They very often cover up for programmer's lack of basic understanding.
> Worse, sometimes even experienced programmers can do poorly.
> I ran into the latter cathegory of code when fixing so-called
> "presto" in Solaris (now replaced by Encore-originated code).
> 
> Normal spinlocks are not without problems, in particular people
> tend to write:
> 
>    void urb_rm_priv_locked(struct urb *) {
>      ......
>    }
>    void urb_rm_priv(struct urb *u) {
>      spin_lock_irqsave();
>      urb_rm_prin_locked(u);
>      spin_unlock_irqrestore();
>    }
> 
> Which eats a stack frame. We make this tradeoff on purpose,
> as a lesser evil.
> 
> BTW, I do not see Linus and his leutenants rebuking the onslaught
> of recursive ingenuity in this thread. Ignoring the hogwash,
> or waiting and watching?

If past experience is any example, I don't think Linus is completely
against recursive spinlocks.

The uhci driver used a simple implementation at one point in time
because of a tricky locking situation. We eventually discovered a non
recursive method of handling it and ditched the code.

Linus actually helped with the code a little bit.

That being said, I'm happy we found an alternative solution and ditched
the recursive spinlock code. I agree with much of your sentiments about
them as well.

JE

