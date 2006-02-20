Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWBTVSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWBTVSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWBTVSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:18:36 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61065
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750808AbWBTVSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:18:36 -0500
Date: Mon, 20 Feb 2006 13:18:47 -0800 (PST)
Message-Id: <20060220.131847.25386315.davem@davemloft.net>
To: mingo@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: softlockup interaction with slow consoles
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When register_console() runs, it dumps the entire log buffer
to the console device with interrupts off.

If you're going over a slow console, this can easily take more
than 10 seconds especially on SMP with many cpus brought up.

This makes the softlock fire, which is terribly annoying :-)

I think the bug is in the console registry code, I think it
should capture chunks of the existing console buffer into some
local memory and push things piece by piece with interrupts
enabled to the console driver(s).

Any better ideas?
