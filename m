Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVGYGqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVGYGqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVGYGpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 02:45:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18395 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261218AbVGYGns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 02:43:48 -0400
Date: Sun, 24 Jul 2005 23:42:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: dirk@opfer-online.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-Id: <20050724234238.2141e828.akpm@osdl.org>
In-Reply-To: <1122222021.7585.64.camel@localhost.localdomain>
References: <20050715013653.36006990.akpm@osdl.org>
	<1122222021.7585.64.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie <rpurdie@rpsys.net> wrote:
>
> On Fri, 2005-07-15 at 01:36 -0700, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> 
>  On the Zaurus I'm seeing a couple of false "BUG: soft lockup detected on
>  CPU#0!" reports. These didn't show under 2.6.12-mm1 which was the last
>  -mm kernel I tested. softlockup.c seems identical between these versions
>  so it looks like some other change has caused this to appear...
> 
>  Both of these are triggered from the nand driver. The functions
>  concerned (nand_wait_ready and nand_read_buf) are known to be slow (they
>  wait on hardware).

OK, thanks.  We can stick a touch_softlockup_watchdog() into those two
functions to tell them that we know what we're doing.  If you have time to
write-and-test a patch then please do so - otherwise I'll take an untested
shot at it.
