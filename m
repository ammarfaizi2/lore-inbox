Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265681AbUGNEXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUGNEXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 00:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUGNEXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 00:23:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:30672 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265681AbUGNEXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 00:23:23 -0400
Date: Tue, 13 Jul 2004 21:22:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: peter@mysql.com, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-Id: <20040713212204.08fda0d6.akpm@osdl.org>
In-Reply-To: <20040714041026.GX974@dualathlon.random>
References: <1089771823.15336.2461.camel@abyss.home>
	<20040714031701.GT974@dualathlon.random>
	<1089776640.15336.2557.camel@abyss.home>
	<20040714041026.GX974@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> The oom killer is forbidden to run
>  as long as `free` tells you that >= 4k of swap are still available to the
>  OS.

That code was recently removed, so the OOM killer now kicks in if we run
out of normal zone due to pinned allocations (stack pages, etc).

This promptly caused oom-killings to occur during heavy swapstorms
with laptop_mode=1, which is as yet unfixed.
