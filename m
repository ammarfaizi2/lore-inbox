Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161450AbWBUJQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161450AbWBUJQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 04:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161451AbWBUJQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 04:16:37 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47007
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161450AbWBUJQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 04:16:36 -0500
Date: Tue, 21 Feb 2006 01:16:50 -0800 (PST)
Message-Id: <20060221.011650.120896368.davem@davemloft.net>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: softlockup interaction with slow consoles
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0602210404330.3092@devserv.devel.redhat.com>
References: <20060220.131847.25386315.davem@davemloft.net>
	<Pine.LNX.4.58.0602210404330.3092@devserv.devel.redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@redhat.com>
Date: Tue, 21 Feb 2006 04:09:58 -0500 (EST)

> i changed soft lockup detection to be turned off during bootup. That
> should work around any boot-time warnings.

Excellent.

> (if this can happen on a booted up system then the real fix would indeed
> be to split up register_console()'s workload - that would also make it
> more preemption-friendly. But at first sight it looks quite complex to
> do.)

Agreed.  I thought about buffering in the slow console driver itself
but that's bad because if it's a crash message we might not get the
events (interrupts, or whatever) in order to make forward progress
printing out the buffer, and thus we'd lose the valuable messages.
