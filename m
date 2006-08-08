Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWHHNnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWHHNnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWHHNnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:43:42 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:61795 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932370AbWHHNnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:43:41 -0400
Date: Tue, 8 Aug 2006 16:43:37 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060808134337.GF5497@rhun.haifa.ibm.com>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492543835-git-send-email-multinymous@gmail.com> <20060807140721.GH4032@ucw.cz> <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com> <20060807182047.GC26224@atjola.homenet> <20060808122234.GD5497@rhun.haifa.ibm.com> <20060808125652.GA5284@ucw.cz> <20060808131724.GE5497@rhun.haifa.ibm.com> <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:35:23PM +0300, Shem Multinymous wrote:
> Hi Muli,
> 
> On 8/8/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> >> > >   ret = thinkpad_ec_lock();
> >> > >   if (ret)
> >> > >           return ret;
> 
> >Ugh, I missed that - it's called _lock(), but it's actually
> >down_interruptible().
> 
> Why is that confusing?

lock() sounds like spin_lock() to me, and spin_lock() can't
fail. Idiomatic code is easier for my brain to parse.

> >Why not just get rid of the wrapper and call
> >down_interruptible() directly? That makes it obvious what's going on.
> 
> We may end up needing to lock away other subsystems (ACPI?) that
> touch the same ports. Apparently not an issue right now, but could
> change with new firmware. (http://lkml.org/lkml/2006/8/7/147)

When (if) it becomes necessary to lock away other subsystems, the
wrapper can be easily reintroduced.

Cheers,
Muli

