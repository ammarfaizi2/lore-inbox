Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265959AbUFYAcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUFYAcB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 20:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUFYAcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 20:32:00 -0400
Received: from [66.199.228.3] ([66.199.228.3]:61450 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S265959AbUFYAbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 20:31:42 -0400
Date: Thu, 24 Jun 2004 17:31:41 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406250031.i5P0VfpP028660@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cache memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried upgrading to 2.4.26 and this has the CONFIG_OOM_KILLER which will
probably improve the situation, but the kernel still has the cache problem.

Is there some way I can get a report of all the cached memory, wether it
is inodes or blocks or whatever? I can deal with modifying the kernel to
put in printk's if needbe.

The approach I'm thinking of is
1) Get report on all kernel cached memory
2) do what it takes to increase the cached memory so that it can't get reduced
3) Get another report, and see what's changed.

Thanks for any suggestions.

-Dave
PS Basically what causes the problem the worst is repeatedly doing this:
1) Launch mozilla browser with latest flash plugin (x86)
2) Load a flash site that uses a large japanese unicode font
3) goto step 2 (that is, reload)

Mozilla + flash have a memory leak so every time the japanese font is reloaded
mozilla uses up 3 more megs of ram. A watchdog mechanism kills mozilla when
it uses up too much memory. But after a while doing this, the cached memory
as reported by "free" grows and can't be reduced. So finally rather than the
watchdog killing mozilla and all being ok, the linux kernel kills the XFree86
server in order to free up memory and the system is dead. This last is the
original reason for us tracking down the problem, however the kernel killing
processes is not required for the cache problem to occur.
