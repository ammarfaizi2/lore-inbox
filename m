Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTIVSoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTIVSoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:44:18 -0400
Received: from waste.org ([209.173.204.2]:18623 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261580AbTIVSoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:44:17 -0400
Date: Mon, 22 Sep 2003 13:44:09 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, Robert Walsh <rjwalsh@durables.org>,
       wangdi <wangdi@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/0] netpoll/kgdb-over-ethernet/netconsole
Message-ID: <20030922184409.GK2414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is an update of my netpoll API work against -mm4. This new
version fixes some issues with SMP and gets stuff working without
driver hacks for NAPI devices (tested with tg3 on SMP - hurray for new
devel box).

(BTW, the old approach to handling tg3 didn't quite work on SMP as it
didn't take the hooked packets off the rx ring and they got handed to
softnet before we made it into the debugger. Softnet would then send an
icmp unreachable, taking down the gdb socket. It's actually really
hard to fix this safelySo consider this a bug
fix too.)

The first patch replaces (aka breaks) the kgdb-over-ethernet hooks, so
you'll need the second patch to make kgdb go again. The third patch,
which adds netconsole, is optional but very handy.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
