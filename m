Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbTCJTWv>; Mon, 10 Mar 2003 14:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbTCJTWv>; Mon, 10 Mar 2003 14:22:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53215 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261439AbTCJTWu>;
	Mon, 10 Mar 2003 14:22:50 -0500
Date: Mon, 10 Mar 2003 11:14:39 -0800 (PST)
Message-Id: <20030310.111439.130618014.davem@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic
 thread_info->status field.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303101119220.2240-100000@home.transmeta.com>
References: <20030310.105659.57012503.davem@redhat.com>
	<Pine.LNX.4.44.0303101119220.2240-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Mon, 10 Mar 2003 11:25:55 -0800 (PST)
   
   > Are you preserving FPU state across fork() on x86?  If so, what do you
   > think might rely on this?
   
   Probably nothing per se. HOWEVER, we'd still need to save the state for 
   rounding etc, so we might as well save it all.
   
I see.

We preserve the rounding/etc. modes on sparc, we merely zap the actual
FPU registers around the system call.

And that's like 4 L2 cache lines of registers on sparc64, so there
really is a benefit from only saving the mode register across a system
call.
