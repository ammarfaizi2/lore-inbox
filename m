Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVIJVAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVIJVAP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVIJVAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:00:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932306AbVIJVAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:00:13 -0400
Date: Sat, 10 Sep 2005 14:00:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: mikukkon@iki.fi
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix allnoconfig build with gcc4
In-Reply-To: <20050910201913.GA6179@miku.homelinux.net>
Message-ID: <Pine.LNX.4.58.0509101356320.30958@g5.osdl.org>
References: <20050910201913.GA6179@miku.homelinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005 mikukkon@iki.fi wrote:
>
> It seems that git commit 20380731bc2897f2952ae055420972ded4cd786e breaks
> allnoconfig build with gcc4:
> 
>   CC      init/main.o
> In file included from include/linux/netdevice.h:29,
> 		   from include/net/sock.h:48,
> 		   from init/main.c:50:
> include/linux/if_ether.h:114: error: array type has incomplete element type
> 
> The "normal" fix of replacing foo[] with *foo would is not trivial, but
> simply removing the offending line is.
> 
> Signed-off-by: Mika Kukkonen <mikukkon@iki.fi>

No, this would cause a compile error if CONFIG_NET and CONFIG_SYSCTL is
enabled (because sysctl_net.c needs that declaration).

So the correct solution is apparently either one of

 - always declare an empty "struct ctl_table" regardless of whether SYSCTL 
   is enabled or not.

   This might be a good idea, since it probably allows more code to be 
   compiled without checking for CONFIG_SYSCTL.

 - put the ether_table[] declaration inside a #ifdef CONFIG_SYSCTL.

Maybe somebody else has a stronger opinion than I do about which of these 
is the right solution.

		Linus
