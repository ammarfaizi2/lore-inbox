Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTBUJtJ>; Fri, 21 Feb 2003 04:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTBUJtJ>; Fri, 21 Feb 2003 04:49:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32207 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267270AbTBUJtH>;
	Fri, 21 Feb 2003 04:49:07 -0500
Date: Fri, 21 Feb 2003 01:43:16 -0800 (PST)
Message-Id: <20030221.014316.69598293.davem@redhat.com>
To: ak@suse.de
Cc: sim@netnation.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030221072719.GD25144@wotan.suse.de>
References: <20030220093422.GA16369@wotan.suse.de>
	<20030220.202438.10564686.davem@redhat.com>
	<20030221072719.GD25144@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 21 Feb 2003 08:27:19 +0100
   
   For icmp_xmit_lock it can be only done in a limited fashion - you are
   always restricted by the buffer size of the ICMP socket. Also I don't 
   know how to lock the socket from BH context nicely - the only simple way
   probably is the trick from the retransmit timer to just try again
   in a jiffie, but could have nasty queueing up under high load.
   
   Fixing the error drop behaviour of TCP will be somewhat nasty too.
   
   In both cases you'll need a retry timer (unreliable) or an dedicated ICMP 
   backlog (complicated)
   
The big problem is that we have one ICMP socket for UP and only
one for SMP too.  That's just dumb, we should make this be a
per-cpu thing.

I suspect this will fix the original bug report.

I don't think the TCP case is much of an issue.  TCP retries things
etc.
