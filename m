Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTIFWZC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 18:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTIFWZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 18:25:02 -0400
Received: from dp.samba.org ([66.70.73.150]:32223 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262461AbTIFWZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 18:25:00 -0400
Date: Sun, 7 Sep 2003 08:24:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: 2.6.0-test4-mm6: locking imbalance with rtnl_lock/unlock?
Message-ID: <20030906222436.GB15327@krispykreme>
References: <1062885603.24475.7.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062885603.24475.7.camel@ixodes.goop.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> which is SIOCGIFADDR.  It seems to me the down() is actually the
> rtnl_lock() called at net/ipv4/devinet.c:536 in devinet_ioctl.  This
> happens even when netplugd is no longer running.  It looks like someone
> isn't releasing the lock.
> 
> I'm going over all the uses of rtnl_lock() to see if I can find a
> problem, but no sign yet.  I wonder if someone might have broken this
> recently: I'm running 2.6.0-test4-mm6, but I think Bryan is running an
> older kernel (2.6.0-test4?), and hasn't seen any problems.

Yep I saw this too when updating from test2 to BK from a few days ago.
>From memory the cpu that had the rtnl_lock was stuck in dev_close,
probably netif_poll_disable. I got side tracked and wasnt able to look
into it.

Anton
