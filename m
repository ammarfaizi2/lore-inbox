Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbWBUTXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWBUTXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 14:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWBUTXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 14:23:50 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:54662
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932752AbWBUTXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 14:23:50 -0500
Date: Tue, 21 Feb 2006 13:23:40 -0600
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: softlockup interaction with slow consoles
Message-ID: <20060221192340.GO4650@waste.org>
References: <20060220.131847.25386315.davem@davemloft.net> <Pine.LNX.4.58.0602210404330.3092@devserv.devel.redhat.com> <20060221.011650.120896368.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221.011650.120896368.davem@davemloft.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 01:16:50AM -0800, David S. Miller wrote:
> From: Ingo Molnar <mingo@redhat.com>
> Date: Tue, 21 Feb 2006 04:09:58 -0500 (EST)
> 
> > i changed soft lockup detection to be turned off during bootup. That
> > should work around any boot-time warnings.
> 
> Excellent.

I don't like it. We should instead just have printk tickle the watchdog.
 
> > (if this can happen on a booted up system then the real fix would indeed
> > be to split up register_console()'s workload - that would also make it
> > more preemption-friendly. But at first sight it looks quite complex to
> > do.)
> 
> Agreed.  I thought about buffering in the slow console driver itself
> but that's bad because if it's a crash message we might not get the
> events (interrupts, or whatever) in order to make forward progress
> printing out the buffer, and thus we'd lose the valuable messages.

Absolutely.

Also note that sysrq-t can be substantially worse than the the
boot-time dump if you've got a lot of processes. So the boot-time hack
is insufficient. Even at 115kbps, this can be several seconds.

-- 
Mathematics is the supreme nostalgia of our time.
